WITH product_funnel_level_one as (
    SELECT *
    FROM {{ref('int_product_funnel_level_one')}}
),
product_funnel_level_two as (
    SELECT *
    FROM {{ref('int_product_funnel_level_second')}}
),
product_funnel_level_three as (
    SELECT *
    FROM {{ref('int_product_funnel_level_three')}}
), 
all_funnels as (
   SELECT *
   FROM {{ref('int_product_funnel_level_one')}} 

   UNION

   SELECT *
   FROM {{ref('int_product_funnel_level_second')}}

   UNION

   SELECT *
   FROM {{ref('int_product_funnel_level_three')}}
),
final as (
    SELECT *, 
    LAG(level_one,1) OVER (ORDER BY level_one) AS LAG_Values,
    level_one - LAG(level_one,1) OVER (ORDER BY level_one) as value_difference,
    level_one + LAG(level_one,1) OVER (ORDER BY level_one):: numeric AS value_sum
    FROM all_funnels
    ORDER BY 1 DESC
)
SELECT *, 
ROUND(value_difference / AVG(value_sum)* 100,2) as Percentage_Difference
FROM final
GROUP BY 1, 2, 3, 4
ORDER BY 1 DESC