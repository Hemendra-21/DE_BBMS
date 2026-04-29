{{ 
    config(
        materialized='table'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'recipients') }}

),

cleaned as (

    select
        recipient_id::int as recipient_id,
        initcap(trim(name)) as name,
        age::int as age,
        upper(trim(blood_group)) as blood_group,
        trim(split_part(location, ',', 1))::varchar as city,
        trim(split_part(location, ',', 2))::varchar as state
    from source
)

select * from cleaned