{{
    config(
        materialized='incremental',
        unique_key='donation_id',
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

donation_source as (

    select * 
    from {{ ref('stg_donations') }}
    where ingested_at > (select max_ingested_at from max_ingested)

),

final as (

    select 
        ds.donation_id,

        ds.donor_id,
        ds.hospital_id,
        ds.recipient_id,

        ddt.date_id as donation_date_id,

        ds.quantity as donated_volume_ml,
        ds.status as donation_status,

        ds.ingested_at

    from donation_source ds

    inner join {{ ref("dim_date") }} ddt 
        on ds.date = ddt.full_date

    where ds.donation_id is not null

)

select * from final