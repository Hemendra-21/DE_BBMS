with per_day_inventory_levels as (
    select
        ddt.full_date as report_date,
        fi.blood_group,
        sum(fi.units_available) as total_units_available
    from {{ ref("fct_blood_inventory") }} fi
    join {{ ref("dim_date") }} rec_ddt
        on fi.date_received_id = rec_ddt.date_id
    join {{ ref("dim_date") }} exp_ddt
        on fi.expiration_date_id = exp_ddt.date_id
    join {{ ref("dim_date") }} ddt
        on ddt.full_date between rec_ddt.full_date and exp_ddt.full_date
    where fi.quality = 'Good'
      and fi.status not in ('discarded','distributed')
    group by ddt.full_date, fi.blood_group
),

per_day_demand as (
    select
        ddt.full_date as report_date,
        dr.recipient_blood_group as blood_group,
        count(fbr.blood_request_sk) as total_requested_units
    from {{ ref("fct_blood_requests") }} fbr
    join {{ ref("dim_date") }} ddt
        on fbr.blood_required_date_id = ddt.date_id
    join {{ ref("dim_recipient") }} dr
        on fbr.recipient_id = dr.recipient_id
    group by ddt.full_date, dr.recipient_blood_group
)

select
    coalesce(s.report_date, d.report_date) as report_date,
    coalesce(s.blood_group, d.blood_group) as blood_group,
    coalesce(s.total_units_available, 0) as total_units_available,
    coalesce(d.total_requested_units, 0) as total_requested_units,
    coalesce(s.total_units_available, 0) 
        - coalesce(d.total_requested_units, 0) as gap_units,
    case
        when coalesce(s.total_units_available, 0) 
             - coalesce(d.total_requested_units, 0) < 0 
            then 'Shortage'
        when coalesce(s.total_units_available, 0) 
             - coalesce(d.total_requested_units, 0) = 0 
            then 'Balanced'
        else 'Surplus'
    end as supply_status
from per_day_inventory_levels s
full outer join per_day_demand d
    on s.report_date = d.report_date
   and s.blood_group = d.blood_group
order by report_date, blood_group