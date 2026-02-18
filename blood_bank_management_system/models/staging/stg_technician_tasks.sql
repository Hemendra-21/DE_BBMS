

SELECT DISTINCT
    technician_id::int as technician_id,
    task_id::int as task_id

FROM {{source('raw', 'technician_tasks')}}
