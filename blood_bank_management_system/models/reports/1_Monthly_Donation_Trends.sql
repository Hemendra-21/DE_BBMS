select 
    ddt.year as donation_year, 
    ddt.month as donation_month_number,
    trim(ddt.month_name) as donation_month, 
    dd.donor_blood_group as donated_blood_group,
    count(*) as total_donations	

from {{ ref('fct_blood_donations') }} fd

left join {{ ref('dim_donor') }} dd 
    on fd.donor_id = dd.donor_id 

left join {{ ref('dim_date') }} ddt 
    on fd.donation_date_id = ddt.date_id

group by 
    ddt.year, 
    ddt.month, 
    ddt.month_name, 
    dd.donor_blood_group

order by 
    ddt.year, 
    ddt.month, 
    dd.donor_blood_group