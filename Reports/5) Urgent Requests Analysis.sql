
-- 5) Urgent Requests Analysis
-- 	What percentage of recipient requests are marked as "high" urgency? Break this down by blood group.


with requests_by_blood_group as (
	select 
		dr.recipient_blood_group as blood_group, 
		count(*) as total_requests,
		count(*) filter(where fbr.urgency = 'high') as high_urgency_requests
	from bbms_analytics.fct_blood_requests fbr
	left join bbms_analytics.dim_recipient dr on fbr.recipient_sk = dr.recipient_sk
	group by dr.recipient_blood_group
	order by dr.recipient_blood_group
)

select 
	blood_group,
	total_requests,
	high_urgency_requests,
	round(100 * high_urgency_requests / total_requests, 2) as high_urgency_requests_percentage_by_blood_group
from requests_by_blood_group