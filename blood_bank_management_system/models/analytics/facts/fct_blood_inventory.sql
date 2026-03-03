{{ config(
        materialized='incremental',
        unique_key='inventory_id',
        incremental_strategy='merge'
    )
}}

with blood_inventory_source as (
    select * from {{ ref('stg_blood_inventory') }}
)


select 
    bis.inventory_id,
    bis.donation_id,
    bis.blood_group,
    coalesce(ddt_received.date_sk, 0) as received_date_sk,
    coalesce(ddt_expiration.date_sk, 0) as expiration_date_sk,
    bis.units_available,
    bis.volume,
    bis.quality,
    status
from blood_inventory_source bis

left join {{ ref('dim_date') }} ddt_received on bis.date_received = ddt_received.full_date
left join {{ ref('dim_date') }} ddt_expiration on bis.expiration_date = ddt_expiration.full_date