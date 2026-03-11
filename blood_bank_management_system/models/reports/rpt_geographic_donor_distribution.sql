SELECT 
    donor_location,
    COUNT(donor_id) AS total_donors
FROM {{ ref('dim_donor') }}
WHERE is_current = true
GROUP BY donor_location
ORDER BY total_donors DESC