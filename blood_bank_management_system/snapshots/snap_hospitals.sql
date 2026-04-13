{% snapshot snap_hospitals %}

    {{
        config(
            target_schema='snapshots',
            unique_key='hospital_id',
            strategy='check',
            check_cols=[
                'name',
                'city',
                'phone_number',
                'hospital_type',
            ]
        )
    }}
    select * from {{ ref('stg_hospitals') }}
    
{% endsnapshot %}