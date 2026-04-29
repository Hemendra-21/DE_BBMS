{% snapshot snap_donors %}

    {{
        config(
            target_schema='snapshots',
            unique_key='donor_id',
            strategy='check',
            check_cols=[
                'name',
                'is_eligible',
                'city',
                'state'
            ]
        )
    }}

    select 
        donor_id,
        name,
        age,
        gender,
        blood_group,
        is_eligible,
        city,
        state,
        last_donation_date
    from {{ ref('stg_donors') }}

{% endsnapshot %}