with blood_requests as (

    select *
    from {{ ref('fct_blood_requests') }}

),

recipients as (

    select *
    from {{ ref('dim_recipient') }}

),

final as (

    select 
        dr.recipient_blood_group,

        count(*) as total_requests,

        sum(case when fbr.urgency = 'high' then 1 else 0 end) as high_urgency_requests,

        round(
            sum(case when fbr.urgency = 'high' then 1 else 0 end) * 100.0 
            / count(*),
            2
        ) as high_urgency_percentage

    from blood_requests fbr

    join recipients dr
        on fbr.recipient_id = dr.recipient_id

    group by dr.recipient_blood_group

)

select *
from final
order by recipient_blood_group