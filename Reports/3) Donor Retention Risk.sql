	
-- Identify donors who haven't donated in the last 6 months (180 days) but are still marked as eligible.

with donors_at_risk as(
	select 
	    dd.donor_id,
	    dd.donor_name
	from bbms_analytics.dim_donor dd
	left join bbms_analytics.fct_donations fd on dd.donor_sk = fd.donor_sk
	left join bbms_analytics.dim_date ddt on fd.donation_date_sk = ddt.date_sk
	where dd.is_current = true and dd.is_eligible = true
	group by dd.donor_id, dd.donor_name
	having max(ddt.full_date) < current_date - interval '180 days' or max(ddt.full_date) is null
	order by donor_id
)

select * from donors_at_risk



-- How many are at risk of becoming inactive?

select count(donor_id) as total_donors_at_risk
from donors_at_risk 






