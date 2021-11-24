{{
  config(
    materialized='table'
  )
}}

with fact_order_details as (
    select *
    from {{ref('int_fct_order_details')}}
)

select * from fact_order_details