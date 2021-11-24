{{
  config(
    materialized='table'
  )
}}

with facts_products_promos as (

    SELECT 
    sum_product_price,
    sum_product_quantity,
    sum_promo_discount
    FROM {{ref('int_products_promos')}} 
)

SELECT * FROM facts_products_promos