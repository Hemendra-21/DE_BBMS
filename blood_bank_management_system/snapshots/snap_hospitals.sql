{% snapshot snap_hospitals %}

    {{
        config(
            target_schema='snapshots',
            unique_key='hospital_id',
            strategy='check',
            check_cols=[
                'hospital_name',
                'hospital_city',
                'phone_number',
                'hospital_type',
                'accreditation_status'
            ]
        )
    }}
    select * from {{ ref('stg_hospitals') }}
    
{% endsnapshot %}