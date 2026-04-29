{{
    config(
        materialized='table'
    )
}}

with date_bounds as (
    select
        min(date) as min_date,
        max(date) as max_date
    from {{ ref('stg_donations') }}
),

date_series as (
    select 
        generate_series(
            (select min_date from date_bounds),
            (select max_date from date_bounds),
            interval '1 day'
        )::date as full_date
)

select 
    to_char(full_date, 'YYYYMMDD')::int as date_id,
    full_date,
    extract(day from full_date) as day,
    extract(year from full_date)::int as year,
    extract(month from full_date)::int as month_number,
    extract(month from full_date)::int as month,
    to_char(full_date, 'Mon') as month_name,
    to_char(full_date, 'YYYY-MM') as year_month,
    (
        extract(year from full_date)::int * 100
        + extract(month from full_date)::int
    ) as year_month_sort
from date_series
