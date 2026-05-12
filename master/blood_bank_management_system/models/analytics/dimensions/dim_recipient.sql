{{
    config(
        materialized='table'
    )
}}

with snap as (
    select * from {{ ref('snap_recipients') }}
),

latest as (
    select *
    from snap
    where dbt_valid_to is null
)

select
    recipient_id,

    age as recipient_age,
    trim(name) as recipient_name,
    upper(trim(blood_group)) as recipient_blood_group,
    trim(city) as recipient_city,
    trim(state) as recipient_state
from latest
