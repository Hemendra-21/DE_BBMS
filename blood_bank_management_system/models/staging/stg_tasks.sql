{{ 
    config(
        materialized='incremental',
        unique_key='task_id',
        incremental_strategy='delete+insert'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'tasks') }}

), 

cleaned as (

    select
        task_id::int as task_id,
        initcap(trim(description)) as description

    from source
    where task_id is not null
)

select * from cleaned