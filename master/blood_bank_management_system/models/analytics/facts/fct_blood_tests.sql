{{
    config(
        materialized='incremental',
        unique_key='blood_test_id',
        incremental_strategy='delete+insert'
    )
}}

with max_ingested as (

    {% if is_incremental() %}
        select
            coalesce(max(ingested_at), '1900-01-01'::timestamp)
                as max_ingested_at
        from {{ this }}
    {% else %}
        select '1900-01-01'::timestamp as max_ingested_at
    {% endif %}

),

source_data as (

    select *
    from {{ ref('stg_blood_tests') }}
    where ingested_at > (select mi.max_ingested_at from max_ingested as mi)

),

final as (

    select
        s.test_id as blood_test_id,

        s.donor_id,
        s.donation_id,

        d.date_id as blood_test_date_id,

        s.test_type as blood_test_type,
        s.result as blood_test_result,

        s.ingested_at

    from source_data as s

    inner join {{ ref('dim_date') }} as d
        on s.test_date = d.full_date

    where s.test_id is not null

)

select * from final
