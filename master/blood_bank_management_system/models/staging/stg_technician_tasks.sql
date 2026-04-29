{{ 
    config(
        materialized='incremental',
        unique_key=['technician_id', 'task_id'],
        incremental_strategy='delete+insert'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'technician_tasks') }}

),

cleaned as (

    select
        technician_id::int as technician_id,
        task_id::int as task_id,

        current_timestamp as ingested_at

    from source
    where technician_id is not null
      and task_id is not null
)

select * from cleaned