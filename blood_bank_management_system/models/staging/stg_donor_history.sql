{{ 
    config(
        materialized='incremental',
        unique_key='history_id',
        incremental_strategy='delete+insert'
    ) 
}}

with source as (
    select * 
    from {{ source('raw', 'donor_history') }}

),

cleaned as (

    select
        history_id::int as history_id,
        donor_id::int as donor_id,
        donation_id::int as donation_id,
        lower(trim(reaction)) as reaction,
        notes::varchar as notes,
        ingested_at::timestamp as ingested_at
    from source
)


select * from cleaned