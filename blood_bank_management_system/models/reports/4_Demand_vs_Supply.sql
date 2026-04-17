with demand as (

    select 
        fbr.blood_required_date_id as date_id,
        dr.recipient_blood_group,
        count(*) as requested_units

    from {{ ref('fct_blood_requests') }} fbr

    left join {{ ref('dim_recipient') }} dr
        on fbr.recipient_id = dr.recipient_id

    group by 
        fbr.blood_required_date_id,
        dr.recipient_blood_group

),

supply as (

    select 
        date_received_id as date_id,
        blood_group,
        sum(units_available) as available_units
    from {{ ref('fct_blood_inventory') }}
    group by date_received_id, blood_group

),

combined as (

    select 
        coalesce(d.date_id, s.date_id) as date_id,
        coalesce(d.recipient_blood_group, s.blood_group) as blood_group,

        coalesce(d.requested_units, 0) as requested_units,
        coalesce(s.available_units, 0) as available_units

    from demand d
    full outer join supply s
        on d.date_id = s.date_id
       and d.recipient_blood_group = s.blood_group

)

select 
    ddt.full_date as blood_required_date,
    c.blood_group as requested_blood_group,
    c.requested_units,
    c.available_units,
    c.available_units - c.requested_units as gap_units,

    case 
        when c.available_units > c.requested_units then 'Surplus'
        when c.available_units = c.requested_units then 'Balanced'
        else 'Shortage'
    end as supply_status

from combined c
join {{ ref('dim_date') }} ddt
    on c.date_id = ddt.date_id

order by ddt.full_date, c.blood_group