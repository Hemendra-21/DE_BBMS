SELECT
    recipient_id::int as recipient_id,
    hospital_id::int as hospital_id,

    initcap(trim(name))::varchar as recipient_name,
    age::int as recipient_age,

    upper(trim(blood_group))::varchar as blood_group,

    required_date::date as required_date,

    lower(trim(urgency))::varchar as urgency,

    initcap(trim(location))::varchar as recipient_location

FROM {{source('raw', 'recipients')}}
