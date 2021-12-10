with product_funnel as (
    SELECT * FROM {{ref('int_product_funnel')}}
)

SELECT * FROM product_funnel