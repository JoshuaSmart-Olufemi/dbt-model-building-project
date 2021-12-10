with session_bool as (
    SELECT
    session_id,
    COUNT(CASE WHEN event_type = 'page_view' THEN 1 END) AS pv,
    COUNT(CASE WHEN event_type = 'add_to_cart' THEN 1 END) AS atc,
    COUNT(CASE WHEN event_type = 'checkout' THEN 1 END) AS c 
    FROM {{ref('stg_events')}}
    GROUP BY 1
)

SELECT COUNT(CASE WHEN (pv > 0 or atc > 0 or c > 0) THEN 1 END) AS level_one
FROM  session_bool