
with donations as (

    select *
    from {{ ref('fct_blood_donations') }}

),

blood_tests as (

    select *
    from {{ ref('fct_blood_tests') }}

),

dim_date as (

    select *
    from {{ ref('dim_date') }}

),

daily_donations as (

    select 
        donation_date_id as date_id,
        count(*) as total_donations
    from donations
    group by donation_date_id

),

daily_tests as (

    select 
        blood_test_date_id as date_id,
        count(distinct blood_test_id) as total_tests
    from blood_tests
    group by blood_test_date_id

),

final as (

    select 
        ddt.full_date,

        coalesce(dd.total_donations, 0) as total_donations,
        coalesce(dt.total_tests, 0) as total_tests

    from dim_date ddt

    left join daily_donations dd
        on ddt.date_id = dd.date_id

    left join daily_tests dt
        on ddt.date_id = dt.date_id

    where ddt.full_date >= '2020-01-01'
      and ddt.full_date < '2021-01-01'

)

select *
from final
order by full_date