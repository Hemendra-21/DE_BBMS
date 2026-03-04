{{
    config(
        materialized='incremental',
        unique_key='blood_test_id',
        incremental_strategy='delete+insert'
    )
}}

with blood_tests_source as (
    select * from {{ ref("stg_blood_tests") }}
),
final as (
    select 
        bts.test_id as blood_test_id,
        dd.donor_sk,
        ddt.date_sk as blood_test_date_sk,
        bts.disease_tested,
        bts.result as test_result
    from blood_tests_source bts
    left join {{ref ("dim_donor") }} dd on bts.donor_id = dd.donor_id and bts.test_date between dd.valid_from and dd.valid_to
    inner join {{ ref("dim_date") }} ddt on bts.test_date = ddt.full_date
)

select * from final