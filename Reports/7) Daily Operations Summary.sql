-- Total donations collected per day

SELECT ddt.full_date, count(donation_id) as total_donations
FROM bbms_analytics.fct_donations fd
inner join bbms_analytics.dim_date ddt on fd.donation_date_sk = ddt.date_sk 
group by ddt.full_date
order by ddt.full_date


-- Total tests completed per day

select ddt.full_date, count(blood_test_id) as total_donations
from bbms_analytics.fct_blood_tests fbt
inner join bbms_analytics.dim_date ddt on fbt.blood_test_date_sk = ddt.date_sk 
group by ddt.full_date
order by ddt.full_date



