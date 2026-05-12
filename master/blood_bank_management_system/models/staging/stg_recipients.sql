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
        age::int as age,
        trim(split_part(location, ',', 1))::varchar as city,
        trim(split_part(location, ',', 2))::varchar as state,
        initcap(trim(name)) as recipient_name,
        upper(trim(blood_group)) as blood_group
    from source
)

select * from cleaned
