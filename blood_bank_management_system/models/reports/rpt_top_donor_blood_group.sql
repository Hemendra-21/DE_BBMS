
SELECT 
    donor_blood_group,
    COUNT(donor_id) AS total_donors,
    RANK() OVER (ORDER BY COUNT(donor_id) DESC) AS donor_rank
FROM {{ref('dim_donor')}}
WHERE is_current = true
GROUP BY donor_blood_group
ORDER BY total_donors DESC