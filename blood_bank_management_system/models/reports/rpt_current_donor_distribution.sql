-- Current active donors grouped by blood group

select
	donor_blood_group,
	count(donor_id) as total_donors
from {{ ref('dim_donor') }}
where is_current is true
group by donor_blood_group
order by donor_blood_group