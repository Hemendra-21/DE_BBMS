-- 4) Hospital Demand vs Supply 
-- 	How many units and what volume are available in inventory for the requested requirement date?


with per_day_inventory_levels as (
	select
	    ddt.full_date as inventory_date,
	    fi.blood_group,
	    sum(fi.units_available) as total_units_available,
	    sum(fi.volume_ml) as total_volume_available
	from bbms_analytics.fct_blood_inventory fi
	join bbms_analytics.dim_date rec_ddt
	    on fi.date_received_sk = rec_ddt.date_sk
	join bbms_analytics.dim_date exp_ddt
	    on fi.expiration_date_sk = exp_ddt.date_sk
	join bbms_analytics.dim_date ddt
	    on ddt.full_date between rec_ddt.full_date and exp_ddt.full_date
	where fi.quality = 'Good'
	and fi.status not in ('discarded','distributed')
	group by ddt.full_date, fi.blood_group
	order by ddt.full_date, fi.blood_group
),
demand_dates as (
	select distinct(full_date) as blood_request_date
	from bbms_analytics.fct_blood_requests fbr
	inner join bbms_analytics.dim_date ddt on fbr.blood_required_date_sk = ddt.date_sk
)



select 
	dd.blood_request_date,
    pil.blood_group,
    pil.total_units_available,
    pil.total_volume_available
from per_day_inventory_levels pil
inner join demand_dates dd on pil.inventory_date = dd.blood_request_date 
order by dd.blood_request_date, pil.blood_group
