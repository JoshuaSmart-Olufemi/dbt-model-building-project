1/ How many users do we have?

select count(distinct(user_id)) from users;
COUNT: 130

2/ On average, how many orders do we receive per hour?

with cte_one as (select date_trunc('hour', created_at) as oph, count(1) from orders group by 1) select AVG(count) from cte_one;

COUNT: 8.1632, round up = 8

3/ On average, how long does an order take from being placed to being delivered?

select avg(delivered_at - created_at) as days_to_deliver 
from orders where status = 'delivered';

days_to_deliver: 3 days


4/ How many users have only made one purchase? Two purchases? Three+ purchases?


5/ On average, how many unique sessions do we have per hour?

with cte_one as (select date_trunc('hour', created_at) as usph, count(distinct(session_id)) as cdsi from events group by 1) select AVG(cte_one.cdsi) from cte_one;

unique sessions per hour: 7.3894 = 7