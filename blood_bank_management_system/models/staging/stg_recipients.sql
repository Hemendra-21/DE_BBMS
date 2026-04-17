{{ 
    config(
        materialized='incremental',
        unique_key=['recipient_id', 'required_date'],
        incremental_strategy='delete+insert'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'recipients') }}

), 

cleaned as(

    select
        recipient_id::int as recipient_id,
        hospital_id::int as hospital_id,

        initcap(trim(name)) as name,
        age::int as age,

        upper(trim(blood_group)) as blood_group,

        required_date::date as required_date,

        lower(trim(urgency)) as urgency,

        initcap(trim(location)) as location,

        current_timestamp as ingested_at

    from source
)

select * from cleaned