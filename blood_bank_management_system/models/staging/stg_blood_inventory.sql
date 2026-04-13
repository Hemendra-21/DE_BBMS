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

    select *
    from (
        select
            inventory_id::int as inventory_id,
            donation_id::int as donation_id,
            recipient_id::int as recipient_id,

            upper(trim(blood_group)) as blood_group,
            initcap(trim(quality)) as quality,
            lower(trim(status)) as status,

            units_available::int as units_available,
            volume::int as volume,
            temperature::numeric(3,1) as temperature,

            date_received::date as date_received,
            expiration_date::date as expiration_date,

            ingested_at::timestamp as ingested_at,

            -- keep latest if duplicates exist in same load
            row_number() over (
                partition by inventory_id
                order by ingested_at desc
            ) as rn

        from source

    ) t
    where rn = 1

)

select * from cleaned