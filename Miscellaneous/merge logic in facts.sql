{{
    config(
        materialized='incremental',
        unique_key='donation_id',
        incremental_strategy='merge'
    )
}}


-- Now dbt will:

-- INSERT new donation_id rows

-- UPDATE existing donation_id rows automatically

-- No updated_at required.

-- How Does This Work?

-- Behind the scenes, dbt generates something like:



MERGE INTO analytics.fct_donations t
USING staging_data s
ON t.donation_id = s.donation_id
WHEN MATCHED THEN UPDATE
WHEN NOT MATCHED THEN INSERT


-- So:

-- ✔ If donation_id exists → UPDATE
-- ✔ If donation_id doesn’t exist → INSERT

-- That’s exactly what you need.