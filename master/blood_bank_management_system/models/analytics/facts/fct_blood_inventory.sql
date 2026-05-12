{{
    config(
        materialized='incremental',
        unique_key='inventory_id',
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

source as (

    select *
    from {{ ref("stg_blood_inventory") }}
    where ingested_at > (select mi.max_ingested_at from max_ingested as mi)

),

final as (

    select

        src.inventory_id,
        src.donation_id,
        src.blood_group,

        src.status,
        src.quality,

        src.units_available as available_units,
        src.volume as available_volume_ml,

        src.recipient_id,

        ddt_received.date_id as received_date_id,
        ddt_expired.date_id as expiration_date_id,

        src.ingested_at

    from source as src

    left join {{ ref("dim_date") }} as ddt_received
        on src.date_received = ddt_received.full_date

    left join {{ ref("dim_date") }} as ddt_expired
        on src.expiration_date = ddt_expired.full_date

    where src.inventory_id is not null

)

select * from final
