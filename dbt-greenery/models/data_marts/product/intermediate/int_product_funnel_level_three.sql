with session_bool as (
    SELECT
    session_id,
    COUNT(CASE WHEN event_type = 'checkout' THEN 1 END) AS c 
    FROM {{ref('stg_events')}}
    GROUP BY 1
)

SELECT COUNT(CASE WHEN c > 0 THEN 1 END) AS level_three
FROM  session_bool