{{
    config(
        materialized='table'
    )
}}

with snap as (
    select * from {{ ref('snap_hospitals') }}
),

latest as (
    select *
    from snap
    where dbt_valid_to is null
)

select 
    hospital_id,

    trim(name) as hospital_name,
    trim(city) as hospital_city,
    upper(trim(country)) as hospital_country,
    trim(phone_number) as hospital_phone_number,
    trim(hospital_type) as hospital_type,
    trim(accreditation_status) as accreditation_status

from latest