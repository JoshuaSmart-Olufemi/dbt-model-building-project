{{
  config(
    materialized='table'
  )
}}
with user_details as (

    SELECT users.id,
    users.user_full_names,
    users.email,
    users.phone_number,
    addresses.address,
    addresses.zipcode,
    addresses.state,
    addresses.country
    FROM {{ref('stg_users')}} as users
    LEFT JOIN {{ ref('stg_addresses')}} as addresses
    ON  users.id = addresses.id
)

select * from user_details