{{
    config(
        materialized='incremental',
        unique_key='donation_id',
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

donation_source as (

    select * 
    from {{ ref('stg_donations') }}
    where ingested_at >= (select max_ingested_at from max_ingested)

),

final as (

    select 
        -- grain
        ds.donation_id,

        ds.donor_id,
        ds.hospital_id,
        ds.recipient_id,

        ddt.date_id as donation_date_id,

        ds.quantity as volume_ml,

        ds.status as donation_status,

        ds.ingested_at

    from donation_source ds

    left join {{ ref('dim_donor') }} dd 
        on ds.donor_id = dd.donor_id 

    left join {{ ref('dim_hospital') }} dh 
        on ds.hospital_id = dh.hospital_id 

    left join {{ ref('dim_recipient') }} dr 
        on ds.recipient_id = dr.recipient_id 

    inner join {{ ref("dim_date") }} ddt 
        on ds.date = ddt.full_date

)

select * from final