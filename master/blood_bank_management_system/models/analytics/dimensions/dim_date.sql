{{
    config(
        materialized='table'
    )
}}


with date_series as (
    select
        generate_series(
            date '2022-12-27',
            date '2026-05-31',
            interval '1 day'
        )::date as full_date
)

select
    to_char(full_date, 'YYYYMMDD')::int as date_id,
    full_date,
    extract(year from full_date)::int as calendar_year,
    extract(month from full_date)::int as month_number,
    extract(month from full_date)::int as calendar_month,
    extract(day from full_date) as calendar_day,
    to_char(full_date, 'Mon') as month_name,
    to_char(full_date, 'YYYY-MM') as year_month_label,
    (
        extract(year from full_date)::int * 100
        + extract(month from full_date)::int
    ) as year_month_sort
from date_series
