1/What is our user repeat rate?

Repeat Rate = Users who purchased 2 or more times / users who purchased : 30
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


2/What are good indicators of a user who will likely purchase again? 
-I think the int_no_user_purchases metric is a good tool to address this

What about indicators of users who are likely NOT to purchase again? 
-I also think the int_no_user_purchases metric can address this

If you had more data, what features would you want to look into to answer this question?



3/Explain the marts models you added. Why did you organize the models in the way you did?
The organization is done this way to make it easier to access models by mart and workflow
CORE MART MODELS:
 - int_dim_order_details: an intermediate model with a table containing dimensions all data in the orders and order_items table
 - int_fct_order_details: an intermediate model with an aggregated table containing all facts data on the orders and order_items table like sum of revenue,order quantity shipping cost and order cost. The grain is the order id 
MARKETING MART MODELS:
 - int_no_user_purchases: an intermediate model containing users categorized by how many purchases they have made
 - int_user_details: an intermediate model containing dimension data on all users, their names, addresses, emails, phone numbers, states and countries
 - int_user_repeat_rate_agg: an aggregated intermediate model containing a metric, user repeat rate, measuring the rate at which users purchase again.
 - int_users_orders: an intermediate aggregated table containing users and their respective order details. The grain is the user id
PRODUCT MART MODELS
 - int_page_views: intermediate model on page view details like month of page view and page views per month.
 - int_products_promos: an intermediate model containing product details alongside promo details of the products


4/What assumptions are you making about each model? (i.e. why are you adding each test?)

I added basic unique and not_null tests to my staging models to check for null and duplicate values. 
I added a macro test - positive values -  to my intermediate models to verify business logic



5/Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

Not necessarily. I had some issues properly configuring the tests in the yml file but I figured that out.