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
)

select 
    donor_id,
    name as donor_name,
    gender as donor_gender,
    blood_group as donor_blood_group,
    is_eligible,
    location as donor_location
from latest