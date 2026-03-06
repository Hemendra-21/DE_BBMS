-- 8) Per day inventory levels by blood group

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
order by ddt.full_date, fi.blood_group;