WITH cte_order_items AS(
     SELECT id,
     order_id,
     product_id,
     quantity as order_quantity
     FROM {{ source('tutorial', 'order_items') }}

)

SELECT * FROM cte_order_items