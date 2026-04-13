{{
    config(
        materialized='incremental',
        unique_key=['recipient_id', 'hospital_id', 'required_date'],
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

recipient_source as (

    select * 
    from {{ ref('stg_recipients') }}
    where ingested_at >= (select max_ingested_at from max_ingested)

),

final as (

    select 
        -- grain (no surrogate key)
        rs.recipient_id,
        rs.hospital_id,
        rs.required_date,

        ddt.date_id as blood_required_date_id,

        rs.urgency,

        rs.ingested_at

    from recipient_source rs 

    left join {{ ref("dim_recipient") }} dr 
        on rs.recipient_id = dr.recipient_id 

    left join {{ ref("dim_hospital") }} dh 
        on rs.hospital_id = dh.hospital_id 

    inner join {{ ref("dim_date") }} ddt 
        on rs.required_date = ddt.full_date 

)

select * from final