with source_donors as (

    select *
    from {{ ref('stg_donors') }}

), final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['donor_id']) }} as donor_sk,
        donor_id,
        donor_name,
        gender as donor_gender,
        blood_group as donor_blood_group,
        donor_location,
        is_eligible
    from source_donors
)

select * from final