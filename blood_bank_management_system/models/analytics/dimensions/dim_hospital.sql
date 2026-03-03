{{
    config(
        materialized='table'
    )
}}
with snap as (
    select * from {{ ref('snap_hospitals') }}
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
        dbt_valid_from as valid_from,
        dbt_valid_to as valid_to,
        case 
            when dbt_valid_to is null then true 
            else false
        end as is_current
    from snap
)

select * from final