-- How many donors do we have for each blood group? 

select
	donor_blood_group,
	count(donor_id) as total_donors
from bbms_analytics.dim_donor
where is_current is true
group by donor_blood_group
order by donor_blood_group




-- Which blood group has the highest donor count? Get all blood groups if multiple blood groups have the same highest donor count.

with total_donors_details as (	
	select 
	donor_blood_group, count(donor_id) as total_donors
	from bbms_analytics.dim_donor
	where is_current = true
	group by donor_blood_group
)

select * 
from total_donors_details
where total_donors = (select max(total_donors) from total_donors_details)
