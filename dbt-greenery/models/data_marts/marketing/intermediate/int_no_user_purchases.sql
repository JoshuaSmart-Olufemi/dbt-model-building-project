with amount as (
    select 
    user_id, 
    count(distinct(order_id)) as amount_of_orders 
    from {{ref('stg_orders') }} 
    group by 1
),
users_and_purchases as (      
select 
sum(case when amount_of_orders =1 then 1 else 0 end) as users_with_one_purchase, 
sum(case when amount_of_orders = 2 then 1 else 0 end) as users_with_two_purchases,
sum(case when amount_of_orders >= 2 then 1 else 0 end) as users_with_two_plus_purchases,
sum(case when amount_of_orders >=3 then 1 else 0 end) as users_with_three_plus_purchases,
amount_of_orders
from amount
group by 5
)

select * from users_and_purchases