{{ 
    config(
        materialized='incremental',
        unique_key='hospital_id',
        incremental_strategy='delete+insert'
    ) 
}}

with source as (
    select * 
    from {{ source('raw', 'hospitals') }}

),

cleaned as (

    select
        hospital_id::int as hospital_id,

        initcap(trim(name)) as name,
        initcap(trim(street_address)) as street_address,
        initcap(trim(city)) as city,
        initcap(trim(province)) as province,

        upper(trim(postal_code)) as postal_code,
        initcap(trim(country)) as country,

        trim(phone_number) as phone_number,
        lower(trim(email_address)) as email_address,

        lower(trim(hospital_type)) as hospital_type,

        case 
            when operating_hours ilike '%24%' then '24/7' 
            else trim(operating_hours)
        end as operating_hours,

        lower(trim(accreditation_status)) as accreditation_status,

        trim(emergency_contact) as emergency_contact,

        ingested_at::timestamp as ingested_at

    from source
)

select * from cleaned