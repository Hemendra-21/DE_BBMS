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
        initcap(trim(location)) as location
    from source
)

select * from cleaned