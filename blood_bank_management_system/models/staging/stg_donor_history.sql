
SELECT
    history_id::int as history_id,
    donor_id::int as donor_id,
    donation_id::int as donation_id,
    lower(trim(reaction))::varchar as reaction,
    notes::varchar as notes
FROM {{source('raw', 'donor_history')}}