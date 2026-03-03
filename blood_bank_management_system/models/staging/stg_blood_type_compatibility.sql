with source as (
    select * from {{ source('raw', 'blood_type_compatibility')}}
),

cleaned as(
    select
        upper(trim(donor_blood_type))::varchar as donor_blood_type,
        upper(trim(recipient_blood_type))::varchar as recipient_blood_type
    from source
)

select * from cleaned