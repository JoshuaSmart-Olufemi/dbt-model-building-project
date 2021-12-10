with session_bool as (
    SELECT
    session_id,
    COUNT(CASE WHEN event_type = 'add_to_cart' THEN 1 END) AS atc,
    COUNT(CASE WHEN event_type = 'checkout' THEN 1 END) AS c 
    FROM {{ref('stg_events')}}
    GROUP BY 1
)

SELECT COUNT(CASE WHEN (atc > 0 or c > 0) THEN 1 END) AS level_two
FROM  session_bool