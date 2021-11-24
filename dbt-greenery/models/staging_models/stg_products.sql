WITH products AS(
    SELECT 
    id,
    product_id,
    name as product_name,
    price as product_price,
    quantity as product_quantity
    FROM {{ source('tutorial', 'products') }}
)

SELECT * FROM products

