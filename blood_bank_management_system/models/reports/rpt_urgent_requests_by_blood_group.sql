WITH requests_by_blood_group AS (
    SELECT 
        dr.recipient_blood_group AS blood_group, 
        COUNT(*) AS total_requests,
        COUNT(*) FILTER (WHERE fbr.urgency = 'high') AS high_urgency_requests
    FROM {{ ref('fct_blood_requests') }} fbr
    LEFT JOIN {{ ref('dim_recipient') }} dr 
        ON fbr.recipient_sk = dr.recipient_sk
    GROUP BY dr.recipient_blood_group
)

SELECT 
    blood_group,
    total_requests::int,
    high_urgency_requests::int,
    (total_requests - high_urgency_requests) AS non_high_urgency_requests,
    ROUND(100.0 * high_urgency_requests / NULLIF(total_requests, 0), 2) 
        AS high_urgency_percentage
FROM requests_by_blood_group
ORDER BY blood_group