with conversion_rate as (
    select 
    count(event_id) as no_visits_to_site,
    sum(case when events.event_type = 'add_to_cart' then 1 else 0 end):: numeric as count_of_orders
    from {{ref('stg_events')}} as events
    left join {{ref('stg_products')}} as products
    on events.id = products.id
)

select 
round(count_of_orders/no_visits_to_site*100,2) as conversion_rate 
from conversion_rate