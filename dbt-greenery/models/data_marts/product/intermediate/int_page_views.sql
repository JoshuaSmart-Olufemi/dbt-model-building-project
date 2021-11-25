{{
  config(
    materialized='table'
  )
}}
with int_page_views as (
    select 
    to_char(created_at,'Month') as Event_Month,
    event_id,
    user_id,
    session_id,
    count(session_id) over (partition by to_char(created_at,'Month')) as views_per_month
    from {{ref('stg_events')}}
    where event_type = 'page_view'  
)

select 
*
from int_page_views