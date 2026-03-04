{{
    config(
        materialized='incremental',
        unique_key='donation_id',
        incremental_strategy='delete+insert'
    )
}}

with donation_source as (
    select * from {{ ref('stg_donations') }}
),
final as (
    select 
        ds.donation_id,
        dd.donor_sk,
        dh.hospital_sk,
        dr.recipient_sk,
        ddt.date_sk as donation_date_sk,
        ds.quantity,
        ds.donation_status
    from donation_source ds
    left join {{ ref('dim_donor') }} dd on ds.donor_id = dd.donor_id and ds.donation_date between dd.valid_from and dd.valid_to
    left join {{ ref('dim_hospital') }} dh on ds.hospital_id = dh.hospital_id and ds.donation_date between dh.valid_from and coalesce(dh.valid_to, '9999-12-31')
    left join {{ ref('dim_recipient') }} dr on ds.recipient_id = dr.recipient_id and ds.donation_date between dr.valid_from and coalesce(dr.valid_to, '9999-12-31')
    inner join {{ ref("dim_date") }} ddt on ds.donation_date = ddt.full_date

)

select * from final