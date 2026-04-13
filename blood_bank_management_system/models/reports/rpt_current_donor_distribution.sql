-- Current active donors grouped by blood group

select
    donor_blood_group,
    count(donor_id) as total_donors
from {{ ref('dim_donor') }}
group by donor_blood_group
order by donor_blood_group