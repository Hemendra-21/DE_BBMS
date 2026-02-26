{{
    config(
        materialized='incremental',
        unique_key='donation_id',
        incremental_strategy='merge'       
    )
}}

with donation_source as (
    select * from {{ref('stg_donations')}}
)


select 
    ds.donation_id,
    dd.donor_sk,
    dh.hospital_sk,
    dr.recipient_sk,
    ddt.date_sk as donation_date_sk,
    ds.quantity,
    ds.status as donation_status 
from donation_source ds 

left join {{ ref('dim_donor') }} dd on ds.donor_id = dd.donor_id
left join {{ ref('dim_hospital') }} dh on ds.hospital_id = dh.hospital_id
left join {{ ref('dim_recipient') }} dr on ds.recipient_id = dr.recipient_id
left join {{ ref('dim_date') }} ddt on ds.donation_date = ddt.full_date

