with date_series as (
    select 
        generate_series(
            '2020-01-01'::date,
            '2030-12-31'::date,
            interval '1 day'
        )::date as full_date
)


select 
    to_char(full_date, 'YYYYMMDD')::int as date_sk,
    full_date,
    extract(day from full_date) as day,
    extract(month from full_date) as month,
    to_char(full_date, 'Month') as month_name,
    extract(year from full_date) as year
from date_series