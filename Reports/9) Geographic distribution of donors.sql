-- Geographic distribution of donors 

SELECT 
	donor_location, 
	count(donor_id) as total_donors
FROM bbms_analytics.dim_donor
where is_current is true
group by donor_location
order by donor_location