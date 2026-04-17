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

    trim(name) as recipient_name,
    upper(trim(blood_group)) as recipient_blood_group,
    trim(location) as recipient_location

from latest