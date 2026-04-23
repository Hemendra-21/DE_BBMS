{{ 
    config(
        materialized='incremental',
        unique_key='request_id',
        incremental_strategy='delete+insert'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'recipient_requests') }}

),

cleaned as (

    select
        request_id::int as request_id,
        recipient_id::int as recipient_id,
        hospital_id::int as hospital_id,
        required_date::date as required_date,
        lower(trim(urgency)) as urgency,
        current_timestamp as ingested_at
    from source
)

select * from cleaned