
with conversion_rate_product as (
    select 
    count(session_id) cnt_sess_addcart_checkout,
    prd.product_name as product_name,
    split_part(page_url,'/',5) as product_guid
    from {{ref('stg_events')}} evn
    left join {{ref('stg_products')}} prd 
    on prd.product_id = split_part(page_url,'/',5)
    where event_type = 'add_to_cart' AND 
    event_type = 'checkout'
    group by 2,3
),
checkout_event_or_not as (
    select 
    count(session_id) as cnt_sess_addcart,
    prd.product_name as product_name
    from {{ref('stg_events')}} evn
    left join {{ref('stg_products')}} prd 
    on prd.product_id = split_part(page_url,'/',5)
    where event_type = 'add_to_cart'
    group by 2
),
final as (
    select 
    a.product_name,
    round(cnt_sess_addcart_checkout/cnt_sess_addcart*100,2) as conversion_rate_per_product
    from conversion_rate_product as a
    left join checkout_event_or_not as b 
    on a.product_name = b.product_name
    
)

select * 
from final


 

