WITH per_day_inventory_levels AS (
    SELECT
        ddt.full_date,
        fi.blood_group,
        SUM(fi.units_available) AS total_units_available,
        SUM(fi.volume_ml) AS total_volume_available
    FROM {{ ref('fct_blood_inventory') }} fi
    JOIN {{ ref('dim_date') }} rec_ddt
        ON fi.date_received_sk = rec_ddt.date_sk
    JOIN {{ ref('dim_date') }} exp_ddt
        ON fi.expiration_date_sk = exp_ddt.date_sk
    JOIN {{ ref('dim_date') }} ddt
        ON ddt.full_date BETWEEN rec_ddt.full_date AND exp_ddt.full_date
    WHERE fi.quality = 'Good'
      AND fi.status NOT IN ('discarded','distributed')
    GROUP BY ddt.full_date, fi.blood_group
)

SELECT
    ddt.year,
    ddt.month,
    ddt.month_name,
    pil.blood_group,
    SUM(pil.total_units_available) AS monthly_units_available,
    SUM(pil.total_volume_available) AS monthly_volume_available
FROM per_day_inventory_levels pil
JOIN {{ ref('dim_date') }} ddt
    ON pil.full_date = ddt.full_date
GROUP BY
    ddt.year,
    ddt.month,
    ddt.month_name,
    pil.blood_group
ORDER BY
    ddt.year,
    ddt.month,
    pil.blood_group