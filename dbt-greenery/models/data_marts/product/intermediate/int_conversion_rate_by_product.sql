
with conversion_rate_by_product as (
    select 
    products.product_name as product_name,
    count(events.event_id) as no_visits_to_site,
    sum(case when events.event_type = 'add_to_cart' then 1 else 0 end):: numeric as count_of_orders
    from {{ref('stg_events')}} as events
    left join {{ref('stg_products')}} as products
    on events.id = products.id
    group by 1
)

select 
product_name,
no_visits_to_site
,count_of_orders
,round(count_of_orders/no_visits_to_site*100,2) as conversion_rate_by_product
from conversion_rate_by_product
group by 1,2,3
order by 3

 

