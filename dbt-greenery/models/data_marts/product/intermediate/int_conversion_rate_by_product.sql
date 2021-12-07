-- sessions with add_to_cart for product_x and checkout / sessions with add_to_cart for product_x
with sessions_with_checkout AS (
    SELECT
    session_id,
    MAX(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) has_checkout
    FROM {{ref('stg_events')}}
    GROUP BY session_id
)
, sessions_with_product AS (
    SELECT
    session_id,
    split_part(page_url,'/',5) AS product_id
    FROM {{ref('stg_events')}}
    WHERE event_type = 'add_to_cart'
    GROUP BY session_id, product_id
) 
, con_rate_by_product_id AS (
    SELECT 
    product_id,
    SUM(has_checkout)::numeric / COUNT(session_id) AS conv_rate
    FROM sessions_with_product
    LEFT JOIN sessions_with_checkout
       USING(session_id)
    GROUP BY product_id
)
SELECT
product_name,
conv_rate
FROM con_rate_by_product_id
JOIN {{ref('stg_products')}}
USING (product_id)

 

