{{
    config(
        materialized='table'
    )
}}
with snap as (
    select * from {{ ref('snap_donors') }}
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
        dbt_valid_from,
        dbt_valid_to,
        case 
            when dbt_valid_to is null then true 
            else false 
        end as is_current
    from snap
)

select * from final