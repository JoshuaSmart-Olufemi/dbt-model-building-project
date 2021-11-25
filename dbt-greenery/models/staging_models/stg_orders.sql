WITH cte_orders AS(
    
     SELECT 
     id,
     order_id,
     user_id,
     address_id,
     created_at,
     order_cost,
     shipping_cost,
     order_total as revenue,
     shipping_service,
     estimated_delivery_at,
     delivered_at,
     status as order_status 
     FROM {{ source('tutorial', 'orders') }}

)

SELECT * FROM cte_orders