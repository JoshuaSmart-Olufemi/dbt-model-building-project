
with conversion_rate as (
    select

    (cast(sum(case when event_type='checkout'then 1 else  0 end) as float)
    / cast(count(session_id) as float))*100 as con_rate
    from {{ref('stg_events')}}
)

select 
*
from conversion_rate
