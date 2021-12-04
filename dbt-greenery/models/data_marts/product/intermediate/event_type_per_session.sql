{% set payment_methods = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type')


%}

with event_types_per_session as(
    select *
    from {{ ref('stg_events')}}
)

select 
distinct(event_type) as unique_event_types,
count(distinct (session_id)) as unique_sessions
{% for event_type in event_types %}
,sum(case when event_type = '{{event_type}}' then 1 else 0 end) as no_of_"{{event_type}}s"
{% endfor %}
from event_types_per_session
group by 1