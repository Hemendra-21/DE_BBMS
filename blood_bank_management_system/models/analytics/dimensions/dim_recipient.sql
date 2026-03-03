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
        dbt_valid_from,
        dbt_valid_to
    from snap        
)

select * from final