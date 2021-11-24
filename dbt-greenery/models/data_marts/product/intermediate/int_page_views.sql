{{
  config(
    materialized='table'
  )
}}
with int_page_views as (
    select 
    to_char(created_at,'Month') as event_month,
    session_id as views,
    count(user_id) as no_of_viewers,
    count(session_id) over (partition by to_char(created_at,'Month')) as views_per_month
    from {{ref('stg_events')}}
    group by 1,2
)

select 
event_month,
no_of_viewers,
views_per_month
from int_page_views