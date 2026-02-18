
SELECT
    upper(trim(donor_blood_type))::varchar as donor_blood_type,
    upper(trim(recipient_blood_type))::varchar as recipient_blood_type

FROM {{source('raw', 'blood_type_compatibility')}}