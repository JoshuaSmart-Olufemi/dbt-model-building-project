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
    sum(orders.revenue) as sum_revenue,
    sum(order_items.order_quantity) as sum_order_quantity
    FROM {{ref('stg_users')}} as users
    LEFT JOIN {{ref('stg_orders')}} as orders
    ON users.user_id = orders.user_id
    LEFT JOIN {{ref('stg_order_items')}} as order_items
    ON orders.order_id = order_items.order_id
    GROUP BY 1
)

select * from int_users_orders