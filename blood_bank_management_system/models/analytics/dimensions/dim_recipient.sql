{{
    config(
        materialized='table'
    )
}}

with snap as (
    select * from {{ ref('snap_recipients')}}
),
final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['recipient_id', 'dbt_valid_from'])}} as recipient_sk,
        recipient_id,
        recipient_name,
        blood_group as recipient_blood_group,
        recipient_location,
        dbt_valid_from as valid_from,
        dbt_valid_to as valid_to,
        case 
            when dbt_valid_to is null then true
            else false 
        end as is_current
    from snap        
)

select * from final