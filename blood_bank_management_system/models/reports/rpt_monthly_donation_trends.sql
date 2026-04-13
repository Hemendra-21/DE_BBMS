-- 1) Monthly donation trends by blood type

with donation_details as (
	select 
		fd.donation_id,
		dd.donor_id,
		dd.donor_name,
		dd.donor_blood_group ,
		ddt.year,
		ddt.month,
		ddt.month_name 
	from {{ ref('fct_donations') }} fd
	left join {{ ref('dim_donor') }} dd on fd.donor_id = dd.donor_id 
	left join {{ ref('dim_date') }} ddt on fd.donation_date_id = ddt.date_id
)

select 
	year as donation_year, 
    month as donation_month_number,
	month_name as donation_month, 
	donor_blood_group as donated_blood_group,
	count(*) as total_donations	
from donation_details
group by year, month, month_name, donor_blood_group
order by year, month, donor_blood_group





