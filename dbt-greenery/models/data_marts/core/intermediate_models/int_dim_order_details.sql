{{
  config(
    materialized='table'
  )
}}

with int_dim_order_details as (

    SELECT 
    shipping_service,
    order_status
    FROM {{ ref('stg_orders')}} 
)

select * from int_dim_order_details