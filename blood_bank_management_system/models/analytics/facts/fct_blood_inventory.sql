{{
    config(
        materialized='incremental',
        unique_key='inventory_id',
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

source as (

    select * 
    from {{ ref("stg_blood_inventory") }}
    where ingested_at > (select max_ingested_at from max_ingested)

),

final as (

    select 

        inventory_id,
        donation_id,
        blood_group,

        status,
        quality,

        units_available as available_units,
        volume as available_volume_ml,

        recipient_id,

        ddt_received.date_id as received_date_id,
        ddt_expired.date_id as expiration_date_id,

        ingested_at

    from source

    left join {{ ref("dim_date") }} ddt_received 
        on source.date_received = ddt_received.full_date

    left join {{ ref("dim_date") }} ddt_expired 
        on source.expiration_date = ddt_expired.full_date 

    where inventory_id is not null

)

select * from final