WITH promos AS(
    
    SELECT 
    id,
    promo_id,
    discout as discount,
    status as promo_status
    FROM public.promos
)

SELECT * FROM promos