1/ How many users do we have?

Answer:
select count(distinct(user_id)) from users;
COUNT: 130

2/ On average, how many orders do we receive per hour?

Answer:
with cte_one as (select date_part('hour', created_at) as oph, count(1) from orders group by 1) select AVG(count) from cte_one;

COUNT: 16

3/ On average, how long does an order take from being placed to being delivered?

Answer:
select avg(delivered_at - created_at) as days_to_deliver 
from orders where status = 'delivered';

days_to_deliver: 3 days


4/ How many users have only made one purchase? Two purchases? Three+ purchases?

with amount as (select user_id, count(distinct order_id) as amount_of_orders from orders group by 1) select sum(case when amount_of_orders =1 then 1 else 0 end) as one_p, sum(case when amount_of_orders = 2 then 1 else 0 end) as two_p,
sum(case when amount_of_orders>=3 then 1 else 0 end) as three_plus_p from amount;

Answer: 
One_Purchase: 25
Two_Purchases:22
Three_Plus_Purchases:81

5/ On average, how many unique sessions do we have per hour?

Answer:
with cte_one as (select date_part('hour', created_at) as usph, count(distinct(session_id)) as cdsi from events group by 1) select AVG(cte_one.cdsi) from cte_one;

unique sessions per hour: 120.5. Round up  to 121