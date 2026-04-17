with eligible_donors as (

    select 
        donor_id,
        donor_name,
        donor_blood_group
    from {{ ref('dim_donor') }}
    where is_eligible = true

),

last_donation as (

    select 
        fd.donor_id,
        max(ddt.full_date) as last_donation_date
    from {{ ref('fct_donations') }} fd
    join {{ ref('dim_date') }} ddt
        on fd.donation_date_id = ddt.date_id
    join eligible_donors ed   
        on fd.donor_id = ed.donor_id
    group by fd.donor_id

)

select 
    ed.donor_id,
    ed.donor_name,
    ed.donor_blood_group,
    ld.last_donation_date

from eligible_donors ed

left join last_donation ld
    on ed.donor_id = ld.donor_id

where 
    ld.last_donation_date is null
    or current_date - ld.last_donation_date > 180