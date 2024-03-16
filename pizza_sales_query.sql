select * from pizza_sales;
-- total revenue
select sum(total_price) as total_revenue from pizza_sales;

-- avg order value
select sum(total_price)/count(distinct order_id) as avg_order_value from pizza_sales;

-- total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;

-- total orders
select count(distinct order_id) as total_order from pizza_sales;

-- avg pizzas per order
select sum(quantity)/count(distinct order_id) as avg_pizza_per_order from pizza_sales;

-- to convert text datatype of datetime to date format
update pizza_sales
set order_date = str_to_date(order_date, "%d-%m-%Y");

alter table pizza_sales
modify order_date date;

-- daily trend for total orders
SELECT DAYNAME(order_date) as order_day, COUNT(DISTINCT order_id) as total_order
FROM pizza_sales
GROUP BY order_day
order by total_order desc;

-- monthly trend for total order
select monthname(order_date) as month_name, count(distinct order_id) as total_order
from pizza_sales
group by month_name
order by total_order desc;

-- total sales and total sales percentage according to pizza category
select pizza_category, sum(total_price) as total_sales, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as total_sales_percentage
from pizza_sales
group by pizza_category;

-- if we want to filter the above data for janaury month
select pizza_category, sum(total_price) as january_total_sales, sum(total_price)*100 / (select sum(total_price) from pizza_sales where month(order_date) = 1) as janaury_total_sales_percentage
from pizza_sales
where month(order_date) = 1
group by pizza_category;

--  total sales and total sales percentage according to pizza size
select pizza_size, sum(total_price) as total_sales, cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales) as decimal (10,2))  as total_sales_percentage
from pizza_sales
group by pizza_size
order by total_sales_percentage desc;

-- using quarter for the above query
select pizza_size, cast(sum(total_price) as decimal (10,2)) as total_sales, cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales where quarter(order_date) = 1) as decimal (10,2)) as percentage
from pizza_sales
where quarter(order_date) = 1
group by pizza_size
order by percentage desc ;

-- top 5 selling pizzas by revenue
select pizza_name, sum(total_price) as total_revenue from pizza_sales 
group by pizza_name
order by total_revenue desc
limit 5;

-- bottom 5 selling pizzas by revenue
select pizza_name, sum(total_price) as total_revenue from pizza_sales 
group by pizza_name
order by total_revenue
limit 5;

-- top 5 selling pizzas by quantity
select pizza_name, sum(quantity) as total_quantity from pizza_sales 
group by pizza_name
order by total_quantity desc
limit 5;

-- bottom 5 selling pizzas by quantity
select pizza_name, sum(quantity) as total_quantity from pizza_sales 
group by pizza_name
order by total_quantity
limit 5;



