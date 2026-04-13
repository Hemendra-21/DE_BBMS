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
        ingested_at::timestamp as ingested_at
    from source
)

select * from cleaned