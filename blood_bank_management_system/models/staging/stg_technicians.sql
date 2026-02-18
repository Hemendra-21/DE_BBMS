

SELECT
    technician_id::int as technician_id,
    hospital_id::int as hospital_id,
    assigned_hospital_id::int as assigned_hospital_id,

    initcap(trim(name))::varchar as technician_name,
    initcap(trim(qualification))::varchar as qualification,

    trim(phone_number)::varchar as phone_number,
    lower(trim(email_address))::varchar as email_address

FROM {{source('raw', 'technicians')}}
