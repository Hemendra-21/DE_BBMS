{% snapshot snap_donors %}

    {{
        config(
            target_schema='snapshots',
            unique_key='donor_id',
            strategy='check',
            check_cols=[
                'donor_name',
                'is_eligible',
                'donor_location'
            ]
        )
    }}

    select 
        donor_id,
        donor_name,
        donor_gender,
        blood_group as donor_blood_group,
        is_eligible,
        donor_location
    from {{ ref('stg_donors') }}

{% endsnapshot %}