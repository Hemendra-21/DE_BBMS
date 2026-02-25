with source_hospitals as (
    select * 
    from {{ ref('stg_hospitals')}}
), final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['hospital_id'])}} as hospital_sk,
        hospital_id,
        hospital_name, 
        city,
        country,
        phone_number,
        hospital_type,
        accreditation_status
    from source_hospitals
)

select * from final