with cte_addresses as (
    SELECT * 
    FROM public.addresses
)

SELECT * FROM cte_addresses