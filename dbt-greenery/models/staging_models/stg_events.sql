WITH cte_events as (

    SELECT * 
    FROM {{ source('tutorial', 'events') }}

)

SELECT * FROM cte_events