{{
    config(
        materialized='table'
    )
}}

with snap as (
    select * from {{ ref('snap_hospitals') }}
),

latest as (
    select *
    from snap
    where dbt_valid_to is null
)

select 
    hospital_id,
    name as hospital_name,
    city,
    country,
    phone_number,
    hospital_type,
    accreditation_status
from latest