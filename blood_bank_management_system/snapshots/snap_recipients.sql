{% snapshot snap_recipients %}

{{
    config(
        target_schema='snapshots',
        unique_key='recipient_id',
        strategy='check',
        check_cols=[
            'recipient_name',
            'recipient_age',
            'recipient_location' 
        ]
    )
}}
select * from {{ ref('stg_recipients') }}

{% endsnapshot %}