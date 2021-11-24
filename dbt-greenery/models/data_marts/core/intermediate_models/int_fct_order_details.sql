{{
  config(
    materialized='table'
  )
}}

with int_fct_order_details as (

    SELECT orders.order_id,
    SUM(orders.order_cost) AS sum_order_cost,
    SUM(orders.shipping_cost) AS sum_shipping_cost,
    SUM(orders.revenue) AS sum_revenue,
    sum(order_items.order_quantity) as sum_order_quantity
    FROM {{ ref('stg_orders')}} as orders
    LEFT JOIN {{ ref('stg_order_items')}} as order_items
    ON orders.order_id = order_items.order_id
    GROUP BY 1
)

SELECT * FROM int_fct_order_details