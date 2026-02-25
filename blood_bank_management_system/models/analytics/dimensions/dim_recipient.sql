with source_recipients as (
    select *  
    from {{ ref('stg_recipients')}}
),
final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['recipient_id'])}} as recipient_sk,
        recipient_id,
        recipient_name, 
        blood_group as recipient_blood_group,
        recipient_location
    from source_recipients
)

select * from final