with source as (
    select * from {{ source('raw', 'blood_tests') }}
),

cleaned as (

    select
        test_id::int as test_id,
        donor_id::int as donor_id,
        technician_id::int as technician_id,

        case
            when date = '0000-00-00' then null
            else date::date
        end as test_date,

        nullif(trim(disease_tested), '')  as disease_tested,
        result::varchar as result,
        trim(test_type) as test_type,
        nullif(trim(comments), '') as comments

    from source

)

select * from cleaned 
where test_date is not null