{{
    config(
        materialized='incremental',
        unique_key='blood_request_id',
        incremental_strategy='delete+insert'
    )
}}

with max_ingested as (

    {% if is_incremental() %}
        select coalesce(max(ingested_at), '1900-01-01'::timestamp) as max_ingested_at
        from {{ this }}
    {% else %}
        select '1900-01-01'::timestamp as max_ingested_at
    {% endif %}

),

request_source as (

    select *
    from {{ ref('stg_recipient_requests') }}
    where ingested_at > (select max_ingested_at from max_ingested)

),

final as (

    select 
        rs.request_id as blood_request_id,
        rs.recipient_id,
        rs.hospital_id,

        ddt.date_id as blood_required_date_id,

        rs.urgency,

        rs.ingested_at

    from request_source rs

    left join {{ ref("dim_date") }} ddt 
        on rs.required_date = ddt.full_date 

    where rs.recipient_id is not null
      and rs.required_date is not null

)

select * from final