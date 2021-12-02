{{
  config(
    materialized='table'
  )
}}

with int_users_orders as (

    SELECT
    users.user_full_names,
    sum(orders.order_cost) as sum_order_cost,
    sum(orders.shipping_cost) as sum_shipping_cost,
    coalesce(sum(orders.revenue),0) as sum_revenue,
    coalesce(sum(order_items.order_quantity),0) as sum_order_quantity,
    coalesce(min(order_items.order_quantity),0) as minimum_order_quantity,
    coalesce(max(order_items.order_quantity),0) as maximum_order_quantity,
    date_part('day',orders.estimated_delivery_at :: timestamp - orders.delivered_at:: timestamp) * 24+ date_part('hour',orders.estimated_delivery_at :: timestamp - orders.delivered_at:: timestamp) as hrs_btw_estimated_delivery_and_actual_delivery
    FROM {{ref('stg_users')}} as users
    LEFT JOIN {{ref('stg_orders')}} as orders
    ON users.user_id = orders.user_id
    LEFT JOIN {{ref('stg_order_items')}} as order_items
    ON orders.order_id = order_items.order_id
    GROUP BY 1,8
)

select * from int_users_orders