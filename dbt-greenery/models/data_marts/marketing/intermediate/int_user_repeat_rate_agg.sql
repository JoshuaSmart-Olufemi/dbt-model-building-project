with amount as (
    select 
    user_id, 
    count(distinct order_id) as amount_of_orders 
    from {{ref('stg_orders')}} 
    group by 1
),
users_and_purchases as (
    select 
    sum(case when amount_of_orders >=2 then 1 else 0 end) as users_with_two_plus_purchases
    from amount
)     
select 
sum(users_with_two_plus_purchases/amount_of_orders) as user_repeat_rate
from {{ref('int_no_user_purchases')}}



