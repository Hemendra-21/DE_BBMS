with source as (

    select * 
    from {{ source('raw', 'blood_inventory') }}

),

cleaned as (

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

        ingested_at

    from source

)

select * from cleaned