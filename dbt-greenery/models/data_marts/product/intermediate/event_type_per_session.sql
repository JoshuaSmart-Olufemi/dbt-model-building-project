{% set payment_methods = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type')


%}

with event_types_per_session as(
    select *
    from {{ ref('stg_events')}}
)

select 
event_type,
count(distinct (session_id)) as unique_sessions
{% for event_type in event_types %}
,case when event_type = '{{event_type}}' then event_type end as "{{event_type}}s"
{% endfor %}
from event_types_per_session
group by 1