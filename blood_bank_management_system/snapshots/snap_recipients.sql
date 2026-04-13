{% snapshot snap_recipients %}

{{
    config(
        target_schema='snapshots',
        unique_key='recipient_id',
        strategy='check',
        check_cols=[
            'name',
            'age',
            'location' 
        ]
    )
}}
select * from {{ ref('stg_recipients') }}

{% endsnapshot %}