
SELECT 
    donor_id int,
    name::varchar as donor_name,
    age::int as donor_age,
    gender:: varchar,
    weight:: numeric(5,2),
    blood_group::varchar,
    last_donation_date::date,
    case 
        when is_eligible = '1' then true 
        else false 
    end as is_eligible,
    donations_count::int, 
    last_health_check_date:: date as last_health_checkup_date,
    location::varchar as donor_location

FROM {{ source('raw', 'donors') }}
