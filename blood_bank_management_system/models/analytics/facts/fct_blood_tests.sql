{{
    config(
        materialized='incremental',
        unique_key='blood_test_id',
        incremental_strategy='delete+insert'
    )
}}

with max_ingested as (

    {% if is_incremental() %}
        select coalesce(max(ingested_at), '1900-01-01') as max_ingested_at
        from {{ this }}
    {% else %}
        select '1900-01-01'::timestamp as max_ingested_at
    {% endif %}

),

blood_tests_source as (

    select * 
    from {{ ref("stg_blood_tests") }}
    where ingested_at >= (select max_ingested_at from max_ingested)

),

final as (

    select 
        bts.test_id as blood_test_id,
        bts.donor_id,
        ddt.date_id as blood_test_date_id,
        bts.disease_tested,
        bts.result as test_result,
        bts.ingested_at

    from blood_tests_source bts

    left join {{ ref("dim_donor") }} dd 
        on bts.donor_id = dd.donor_id 

    inner join {{ ref("dim_date") }} ddt 
        on bts.test_date = ddt.full_date

)

select * from final