{{
    config(
        materialized='table'
    )
}}
with snap as (
    select * from {{ ref('snap_donors') }}
),
updated_date as (
    select *,
    row_number() over (partition by donor_id order by dbt_valid_from asc) as rn
    from snap
),

final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['donor_id', 'dbt_valid_from']) }} as donor_sk,
        donor_id,
        donor_name,
        donor_gender,
        donor_blood_group,
        is_eligible,
        donor_location,
        case 
            when rn = 1 then timestamp '2020-01-01'
            else dbt_valid_from
        end as valid_from,
        coalesce(dbt_valid_to, timestamp '9999-12-31') as valid_to,
        case 
            when dbt_valid_to is null then true 
            else false 
        end as is_current
    from updated_date
)

select * from final