with snap as(
    select * from {{ ref('snap_donors') }}
),

current_staging as (
    select * from {{ ref('stg_donors') }}
),

final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['snap.donor_id', 'snap.dbt_valid_from'])}} as donor_sk,
        snap.donor_id, 

        stg.donor_name,
        stg.gender as donor_gender,
        stg.blood_group as donor_blood_group,

        snap.is_eligible,
        snap.donor_location,

        snap.dbt_valid_from,
        snap.dbt_valid_to,

        case 
            when snap.dbt_valid_to is null then true 
            else false 
        end as is_current

    from snap left join current_staging stg 
    on snap.donor_id = stg.donor_id
)


select * from final