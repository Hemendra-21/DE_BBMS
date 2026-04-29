{{
    config(
        materialized='incremental',
        unique_key='test_id',
        incremental_strategy='delete+insert'
    )
}}

with source as (

    select * 
    from {{ source('raw', 'blood_tests') }}

),

cleaned as (

    select
        test_id::int as test_id,
        donation_id::int as donation_id,
        donor_id::int as donor_id,
        technician_id::int as technician_id,

        date::date as test_date,

        trim(test_type) as test_type,
        case 
            when trim(result) = 'safe' then 'Negative'
            else 'Positive'
        end as result,
        nullif(trim(comments), '') as comments,

        current_timestamp as ingested_at

    from source
)

select * from cleaned