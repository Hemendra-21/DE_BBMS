{{
    config(
        materialized='incremental',
        unique_key='blood_request_sk',
        incremental_strategy='delete+insert'
    )
}}

with recipient_source as (
    select * from {{ ref('stg_recipients') }}
),
final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['rs.recipient_id', 'rs.hospital_id', 'rs.required_date'])}} as blood_request_sk,
        dr.recipient_sk,
        dh.hospital_sk,
        ddt.date_sk as blood_required_date_sk,
        rs.urgency
    from recipient_source rs 
    left join {{ref("dim_recipient")}} dr on rs.recipient_id = dr.recipient_id and rs.required_date between dr.valid_from and dr.valid_to
    left join {{ref("dim_hospital")}} dh on rs.hospital_id = dh.hospital_id and rs.required_date between dh.valid_from and dh.valid_to
    inner join {{ref("dim_date")}} ddt on rs.required_date = ddt.full_date 
)

select * from final