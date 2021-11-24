{{
  config(
    materialized='table'
  )
}}

with facts_users_orders as (

    SELECT *
    FROM {{ref('int_users_orders')}} as users
    
)

select * from facts_users_orders