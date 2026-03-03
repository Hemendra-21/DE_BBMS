with snap as (
    select * from {{ ref('snap_hospitals') }}
),

current_staging as (
    select * from {{ ref('stg_hospitals') }}
),

final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['snap.hospital_id', 'snap.dbt_valid_from'])}} as hospital_sk,
        snap.hospital_id, 

        stg.hospital_name,
        stg.city as hospital_city,
        stg.phone_number,
        stg.hospital_type,
        stg.accreditation_status,

        snap.dbt_valid_from,
        snap.dbt_valid_to,

        case 
            when snap.dbt_valid_to is null then true 
            else false 
        end as is_current

    from snap left join current_staging stg 
    on snap.hospital_id = stg.hospital_id
)

select * from final