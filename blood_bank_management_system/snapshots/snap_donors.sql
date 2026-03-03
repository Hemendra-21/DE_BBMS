{% snapshot snap_donors %}

    {{
        config(
            target_schema='snapshots',
            unique_key='donor_id',
            strategy='check',
            check_cols=[
                'donor_name',
                'donor_age',
                'is_eligible',
                'donor_location'
            ]
        )
    }}

    select * from {{ ref('stg_donors') }}

{% endsnapshot %}