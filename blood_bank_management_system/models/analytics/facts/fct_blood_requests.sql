{{
    config(
        materialized='incremental',
        unique_key='',
        incremental_strategy='merge'
    )
}}


with source as(
    select * from {{ ref('stg_recipients') }}
)


select 
    {{ dbt_utils.generate_surrogate_key(['s.recipient_id', 's.hospital_id', 's.required_date']) }} as blood_request_sk,
    dr.recipient_sk,
    dh.hospital_sk,
    ddt.date_sk as blood_required_date_sk,
    urgency
from source s
left join {{ref("dim_recipient")}} dr on s.recipient_id = dr.recipient_id
left join {{ ref("dim_hospital") }} dh on s.hospital_id = dh.hospital_id
left join {{ ref("dim_date") }} ddt on s.required_date = ddt.full_date
