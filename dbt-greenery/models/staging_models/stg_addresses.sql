with cte_addresses as (
    SELECT * 
    FROM {{ source('tutorial', 'addresses') }}
)

SELECT * FROM cte_addresses