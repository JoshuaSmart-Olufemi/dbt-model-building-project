-- CON RATE: number of sessions that had a checkout event / total number of unique sessions 
with sessions_with_checkout as (
    SELECT
    session_id,
    MAX(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) has_checkout
    FROM {{ref('stg_events')}}
    GROUP BY session_id
)

SELECT 
  ROUND(SUM(has_checkout)::numeric / COUNT(session_id)*100,2) as conv_rate
FROM sessions_with_checkout
