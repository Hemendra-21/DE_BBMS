{{ 
    config(
        materialized='incremental',
        unique_key='donor_id',
        incremental_strategy='delete+insert'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'donors') }}

),

cleaned as (

    select 
        donor_id::int as donor_id,
        registered_by_staff_id::int as registered_by_staff_id,
        primary_contact_id::int as primary_contact_id,
        name::varchar as name,
        age::int as age,
        gender::varchar as gender,
        weight::numeric(5,2) as weight,

        upper(trim(blood_group)) as blood_group,
        last_donation_date::date as last_donation_date,

        case 
            when is_eligible = '1' then true 
            else false 
        end as is_eligible,

        donations_count::int as donations_count, 
        contact_method_type::varchar as contact_method_type,
        contact_detail::varchar as contact_detail,
        donor_type::varchar as donor_type,
        notes::varchar as notes,
        last_health_check_date::date as last_health_check_date,
        donation_frequency_allowed::int as donation_frequency_allowed,
        location::varchar as location,
        days_since_last_donation::int as days_since_last_donation,

        (blood_group_a_plus = '1') as blood_group_a_plus,
        (blood_group_a_minus = '1') as blood_group_a_minus,
        (blood_group_b_plus = '1') as blood_group_b_plus,
        (blood_group_b_minus = '1') as blood_group_b_minus,
        (blood_group_ab_plus = '1') as blood_group_ab_plus,
        (blood_group_ab_minus = '1') as blood_group_ab_minus,
        (blood_group_o_plus = '1') as blood_group_o_plus,    
        (blood_group_o_minus = '1') as blood_group_o_minus,

        current_timestamp as ingested_at

    from source
)

select * from cleaned