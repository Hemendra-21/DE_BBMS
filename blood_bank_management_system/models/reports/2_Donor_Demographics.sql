select
    donor_blood_group,
    count(*) as total_donors,
    rank() over (order by count(*) desc) as donor_rank
from {{ ref('dim_donor') }}
group by donor_blood_group
order by donor_rank