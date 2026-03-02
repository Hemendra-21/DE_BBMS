{{
    config(
        materialized='incremental',
        unique_key='blood_test_id',
        incremental_strategy='merge'
    )
}}

with blood_tests_source as (
    select * from {{ ref('stg_blood_tests')}}
)

select 
    bts.test_id as blood_test_id,
    dd.donor_sk,
    ddt.date_sk as blood_test_date_sk,
    bts.test_type as blood_test_type,
    bts.disease_tested,
    bts.result as test_result
from blood_tests_source bts 
left join {{ ref('dim_donor') }} dd on bts.donor_id = dd.donor_id
left join {{ ref('dim_date')}} ddt on bts.test_date = ddt.full_date

