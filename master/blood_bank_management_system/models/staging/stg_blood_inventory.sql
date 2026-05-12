{{
    config(
        materialized='incremental',
        unique_key='inventory_id',
        incremental_strategy='delete+insert'
    )
}}

with source as (

    select *
    from {{ source('raw', 'blood_inventory') }}

),

cleaned as (

    select
        inventory_id::int as inventory_id,
        donation_id::int as donation_id,

        units_available::int as units_available,

        volume::int as volume,
        temperature::numeric(3, 1) as temperature,
        date_received::date as date_received,

        expiration_date::date as expiration_date,
        case
            when trim(recipient_id::text) in ('', 'NA', 'null') then null
            else recipient_id::int
        end as recipient_id,
        upper(trim(blood_group)) as blood_group,

        initcap(trim(quality)) as quality,
        lower(trim(status)) as status,

        current_timestamp as ingested_at

    from source
)

select * from cleaned
