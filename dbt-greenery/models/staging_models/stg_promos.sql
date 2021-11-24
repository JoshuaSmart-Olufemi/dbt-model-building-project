WITH promos AS(
    
    SELECT 
    id,
    promo_id as promo_code,
    discout as promo_discount,
    status as promo_status
    FROM {{ source('tutorial', 'promos') }}
)

SELECT * FROM promos