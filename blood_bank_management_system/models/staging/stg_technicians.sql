{{ 
    config(
        materialized='incremental',
        unique_key='technician_id',
        incremental_strategy='delete+insert'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'technicians') }}

), 

cleaned as (

    select
        technician_id::int as technician_id,
        hospital_id::int as hospital_id,
        assigned_hospital_id::int as assigned_hospital_id,

        initcap(trim(name)) as name,
        initcap(trim(qualification)) as qualification,

        trim(phone_number) as phone_number,
        lower(trim(email_address)) as email_address,

        ingested_at::timestamp as ingested_at
    from source
)

select * from cleaned