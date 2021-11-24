{{
  config(
    materialized='table'
  )
}}

with int_products_promos as (

    SELECT 
    product.product_name,
    promo.promo_code,
    promo.promo_status,
    count(distinct(product.product_id)) as number_of_products,
    sum(product.product_price) as sum_product_price,
    sum(product.product_quantity) as sum_product_quantity,
    sum(promo.promo_discount) as sum_promo_discount
    FROM {{ref('stg_products')}} as product
    LEFT JOIN {{ref('stg_promos')}} as promo
    ON product.id = promo.id
    GROUP BY 1,2,3
)

SELECT * FROM int_products_promos