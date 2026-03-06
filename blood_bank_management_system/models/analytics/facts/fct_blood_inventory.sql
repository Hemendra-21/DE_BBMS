{{
    config(
        materialized='incremental',
        unique_key='inventory_id',
        incremental_strategy='delete+insert'
    )
}}

with blood_inventory_source as (
    select * from {{ ref("stg_blood_inventory") }}
),
final as (
    select 
        bis.inventory_id,
        bis.donation_id,
        fd.donor_sk,
        bis.blood_group,
        ddt_received.date_sk as date_received_sk,
        ddt_expired.date_sk as expiration_date_sk,
        bis.units_available,
        bis.volume as volume_ml,
        bis.quality as quality,
        bis.status
    from blood_inventory_source bis
    left join {{ref('fct_donations')}} fd on bis.donation_id = fd.donation_id
    left join {{ref("dim_date")}} ddt_received on bis.date_received = ddt_received.full_date
    left join {{ref("dim_date")}} ddt_expired on bis.expiration_date = ddt_expired.full_date 
)

select * from final