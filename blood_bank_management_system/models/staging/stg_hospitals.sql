
SELECT
    hospital_id::int as hospital_id,

    initcap(trim(name))::varchar as hospital_name,
    initcap(trim(street_address))::varchar as street_address,
    initcap(trim(city))::varchar as city,
    initcap(trim(province))::varchar as province,

    upper(trim(postal_code))::varchar as postal_code,
    initcap(trim(country))::varchar as country,

    trim(phone_number)::varchar as phone_number,
    lower(trim(email_address))::varchar as email_address,

    lower(trim(hospital_type))::varchar as hospital_type,

    case 
        when operating_hours ilike '%24%' then '24/7' 
        else trim(operating_hours)::varchar
    end as operating_hours,

    lower(trim(accreditation_status))::varchar as accreditation_status,

    trim(emergency_contact)::varchar as emergency_contact

FROM {{source('raw', 'hospitals')}}
