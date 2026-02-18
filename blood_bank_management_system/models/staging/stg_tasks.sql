

SELECT
    task_id::int as task_id,
    initcap(trim(description))::varchar as task_description

FROM {{source('raw', 'tasks')}}
