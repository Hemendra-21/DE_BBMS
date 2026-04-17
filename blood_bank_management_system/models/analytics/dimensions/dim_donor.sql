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

        trim(name) as donor_name,
        upper(trim(gender)) as donor_gender,
        upper(trim(blood_group)) as donor_blood_group,
        is_eligible,

        trim(location) as donor_location

    from latest
)

select * from final