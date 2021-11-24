{{
  config(
    materialized='table'
  )
}}
with dim_user_details as (

    SELECT *
    FROM {{ref('int_user_details')}} 
)

select * from dim_user_details