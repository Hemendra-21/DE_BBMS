SELECT
    inventory_id::int as inventory_id,
    donation_id::int as donation_id,
    recipient_id::int as recipient_id,

    blood_group::varchar as blood_group,

    units_available::int as units_available,
    volume::numeric(6,2) as volume,
    temperature::numeric(4,1) as temperature,

    quality::varchar as quality,
    status::varchar as status,

    date_received::date as date_received,
    expiration_date::date as expiration_date
    
FROM {{source('raw', 'blood_inventory') }}
