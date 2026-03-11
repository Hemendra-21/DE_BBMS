SELECT 
    ddt.month,
    ddt.month_name, 
    COUNT(*) AS donation_count
FROM {{ ref('fct_donations') }} fd
JOIN {{ ref('dim_date') }} ddt 
    ON fd.donation_date_sk = ddt.date_sk 
GROUP BY 
    ddt.month,
    ddt.month_name
ORDER BY 
    ddt.month