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
    extract(month from full_date) as month,
    trim(to_char(full_date, 'Month')) as month_name,
    extract(year from full_date) as year,
    extract(quarter from full_date) as quarter,
    to_char(full_date, 'YYYY-MM') as year_month
from date_series