WITH daily_donations AS (
    SELECT 
        ddt.full_date,
        COUNT(fd.donation_id) AS total_donations
    FROM {{ ref('fct_donations') }} fd
    JOIN {{ ref('dim_date') }} ddt 
        ON fd.donation_date_sk = ddt.date_sk
    GROUP BY ddt.full_date
),

daily_tests AS (
    SELECT 
        ddt.full_date,
        COUNT(fbt.blood_test_id) AS total_tests
    FROM {{ ref('fct_blood_tests') }} fbt
    JOIN {{ ref('dim_date') }} ddt 
        ON fbt.blood_test_date_sk = ddt.date_sk
    GROUP BY ddt.full_date
)

SELECT 
    COALESCE(d.full_date, t.full_date) AS full_date,
    COALESCE(d.total_donations, 0) AS total_donations,
    COALESCE(t.total_tests, 0) AS total_tests
FROM daily_donations d
FULL OUTER JOIN daily_tests t
    ON d.full_date = t.full_date
ORDER BY full_date