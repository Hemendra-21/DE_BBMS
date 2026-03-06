-- 6) Seasonal Donation Patterns 
-- 	Analyze donation patterns by month. Which months have the highest and lowest donation volumes?
 

SELECT 
	ddt.month_name, 
	count(*) as donation_count
FROM bbms_analytics.fct_donations fd
inner join bbms_analytics.dim_date ddt on fd.donation_date_sk = ddt.date_sk 
group by ddt.month, ddt.month_name
order by donation_count desc, ddt.month_name
