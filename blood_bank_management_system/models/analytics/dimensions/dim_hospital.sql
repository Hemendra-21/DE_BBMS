{{
    config(
        materialized='table'
    )
}}
with snap as (
    select * from {{ ref('snap_hospitals') }}
),

updated_date as (
    select 
        *,
        row_number() over(partition by hospital_id order by dbt_valid_from asc) as rn
    from snap
),

final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['hospital_id', 'dbt_valid_from']) }} as hospital_sk,
        hospital_id,
        hospital_name,
        city,
        country,
        phone_number,
        hospital_type,
        accreditation_status,
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