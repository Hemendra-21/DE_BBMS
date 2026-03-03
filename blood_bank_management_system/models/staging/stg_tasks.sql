with source as (
    SELECT * FROM {{source('raw', 'tasks')}}
), 
cleaned as (
    select
        task_id::int as task_id,
        initcap(trim(description))::varchar as task_description,
        ingested_at::timestamp as ingested_at

    from source
)

select * from cleaned