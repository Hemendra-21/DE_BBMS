SELECT 
    ddt.month,
    ddt.month_name, 
    COUNT(*) AS donation_count
FROM {{ ref('fct_donations') }} fd
JOIN {{ ref('dim_date') }} ddt 
    ON fd.donation_date_id = ddt.date_id
GROUP BY 
    ddt.month,
    ddt.month_name
ORDER BY 
    ddt.month