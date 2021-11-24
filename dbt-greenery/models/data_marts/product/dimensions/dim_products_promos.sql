{{
  config(
    materialized='table'
  )
}}

with dim_products_promos as (

    SELECT 
    product_name,
    promo_code,
    promo_status
    FROM {{ref('int_products_promos')}} 
)

SELECT * FROM dim_products_promos