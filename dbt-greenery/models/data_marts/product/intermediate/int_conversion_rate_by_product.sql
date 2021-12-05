
with conversion_rate_product as (
    select 
    prd.product_name,
    split_part(page_url,'/',5) as product_guid,
    cast(sum(case when event_type='checkout'then 1 else  0 end) as float)
        / cast(count(session_id) as float) con_rate_prod
    from {{ref('stg_events')}} evn
    left join {{ref('stg_products')}} prd 
    on prd.product_id = split_part(page_url,'/',5)
    group by 1,2
)


select *
from conversion_rate_product

 

