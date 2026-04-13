WITH donor_status AS (
    SELECT 
        dd.donor_id,
        CASE 
            WHEN MAX(ddt.full_date) < CURRENT_DATE - INTERVAL '180 days'
                 OR MAX(ddt.full_date) IS NULL
            THEN 'At Risk'
            ELSE 'Active'
        END AS retention_status
    FROM {{ ref('dim_donor') }} dd
    LEFT JOIN {{ ref('fct_donations') }} fd 
        ON dd.donor_id = fd.donor_id
    LEFT JOIN {{ ref('dim_date') }} ddt 
        ON fd.donation_date_id = ddt.date_id
    WHERE dd.is_current = true 
      AND dd.is_eligible = true
    GROUP BY dd.donor_id
)

SELECT 
    retention_status,
    COUNT(*) AS total_donors
FROM donor_status
GROUP BY retention_status