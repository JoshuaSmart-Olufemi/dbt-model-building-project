{{
  config(
    materialized='table'
  )
}}

with dim_order_details as (
    select *
    from {{ref('int_dim_order_details')}}
)

select * from dim_order_details