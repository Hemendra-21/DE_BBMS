{{ 
    config(
        materialized='incremental',
        unique_key='donation_id',
        incremental_strategy='delete+insert'
    ) 
}}

with source as (

    select * 
    from {{ source('raw', 'donations') }}

),

cleaned as (

    select 
        donation_id::int as donation_id,
        donor_id::int as donor_id,
        hospital_id::int as hospital_id,
        recipient_id::int as recipient_id,
        collection_technician_id::int as collection_technician_id,
        processed_by_technician_id::int as processed_by_technician_id,
        test_result_id::int as test_result_id,

        case 
            when trim(cast(date as text)) in ('0000-00-00', '', 'NA') then null
            else cast(date as date)
        end as date,

        quantity::int as quantity,

        upper(trim(blood_group)) as blood_group,
        lower(trim(status)) as status,

        bag_serial_number::varchar as bag_serial_number,

        storage_temperature::numeric(4,1) as storage_temperature,

        case 
            when trim(cast(expiration_date as text)) in ('0000-00-00', '', 'NA') then null
            else cast(expiration_date as date)
        end as expiration_date,

        lower(trim(donation_type)) as donation_type,

        current_timestamp as ingested_at

    from source
)

select * from cleaned