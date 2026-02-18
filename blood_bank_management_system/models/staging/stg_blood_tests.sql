select 
    test_id::int as test_id,
    donor_id::int as donor_id,
    technician_id::int as technician_id,
    nullif(date, '0000-00-00')::date as test_date,
    disease_tested::varchar as disease_tested,
    result::varchar as result,
    test_type::varchar as test_type,
    comments::varchar as comments

FROM {{ source('raw', 'blood_tests') }}