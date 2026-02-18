
SELECT
    donation_id::int as donation_id,
    donor_id::int as donor_id,
    hospital_id::int as hospital_id,
    recipient_id::int as recipient_id,
    collection_technician_id::int as collection_technician_id,
    processed_by_technician_id::int as processed_by_technician_id,
    test_result_id::int as test_result_id,

    nullif(date, '0000-00-00')::date as donation_date,

    quantity::int as quantity,

    upper(trim(blood_group))::varchar as blood_group,

    lower(trim(status))::varchar as status,

    bag_serial_number::varchar as bag_serial_number,

    storage_temperature::numeric(4,1) as storage_temperature,

    nullif(expiration_date, '0000-00-00')::date as expiration_date,

    lower(trim(donation_type))::varchar as donation_type

   
FROM {{source('raw', 'donations')}}
