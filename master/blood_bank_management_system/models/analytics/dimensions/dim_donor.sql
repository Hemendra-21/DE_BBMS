{{
    config(
        materialized='table'
    )
}}

with snap as (
    select * from {{ ref('snap_donors') }}
),

latest as (
    select *
    from snap
    where dbt_valid_to is null
),

final as (
    select
        donor_id,

        age as donor_age,
        is_eligible,
        last_donation_date,
        trim(name) as donor_name,
        upper(trim(gender)) as donor_gender,
        upper(trim(blood_group)) as donor_blood_group,
        trim(city) as donor_city,
        trim(state) as donor_state

    from latest
)

select * from final
