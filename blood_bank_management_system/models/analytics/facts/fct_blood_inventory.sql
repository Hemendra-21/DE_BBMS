{{
    config(
        materialized='incremental',
        unique_key='inventory_id',
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

blood_inventory_source as (

    select * 
    from {{ ref("stg_blood_inventory") }}
    where ingested_at >= (select max_ingested_at from max_ingested)

),

final as (

    select 

        bis.inventory_id,

        bis.donation_id,
        fd.donor_id,

        bis.blood_group,
        bis.quality,
        bis.status,

        bis.units_available,
        bis.volume as volume_ml,

        ddt_received.date_id as date_received_id,
        ddt_expired.date_id as expiration_date_id,

        bis.ingested_at

    from blood_inventory_source bis

    left join {{ ref('fct_donations') }} fd 
        on bis.donation_id = fd.donation_id

    left join {{ ref("dim_date") }} ddt_received 
        on bis.date_received = ddt_received.full_date

    left join {{ ref("dim_date") }} ddt_expired 
        on bis.expiration_date = ddt_expired.full_date 

    where bis.inventory_id is not null

)

select * from final