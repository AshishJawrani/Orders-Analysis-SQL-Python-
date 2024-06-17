
create table df_orders (
[order_id] int primary key 
,[order_date] date
, [ship_mode] varchar (20) 
, [segment] varchar (20) 
, [country] varchar (20) 
, [city] varchar (20) 
, [state] varchar (20) 
, [postal_code] varchar (20)
, [region] varchar (20)
, [category] varchar (20) 
, [sub_category] varchar (20) 
, [product_id] varchar (50) 
, [quantity] int
, [discount] decimal (7,2) 
, [sale_price] decimal (7,2) 
, [profit] decimal(7,2))

select * from df_orders

--Top 10 highest revenue generating products
select top 10 product_id, sum(sale_price) as Total_sales
from df_orders
group by product_id 
order by Total_sales desc;

--Top 5 highest selling products in each region
with cte as(
select Region,product_id, sum(sale_price) as Total_sales
from df_orders
group by product_id,Region
--order by Region,Total_sales desc
)
, cte2 as(
select *, DENSE_RANK() over (partition by Region order by Total_sales desc) as drnk
from cte
)
select Region, Product_id, Total_sales from cte2 where drnk <= 5;

--Month over month growth comparison for 2022 and 2023 sales 
with cte as(
select year(order_date) as Order_year, month(order_date) as Order_month, sum(sale_price) as sales
from df_orders
group by year(order_date), month(order_date)
)
select order_month,
sum(case when order_year=2022 then sales else 0 end) as sales_2022,
sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte 
group by order_month;

--Highest sales month for each category
with cte as(
select format(order_date,'yyyyMM') as Order_month, category, sum(sale_price) as Sales
from df_orders
group by format(order_date,'yyyyMM'), category
)
, cte2 as(
select *,
DENSE_RANK() over (partition by category order by sales desc) as drnk
from cte
)
select Category, Order_month, Sales from cte2 where drnk=1;

--Highest growth subcategory by profit in 2023 compared to 2022

with cte as(
select sub_category, year(order_date) as Order_year, sum(sale_price) as sales
from df_orders
group by sub_category,year(order_date)
)
,cte2 as(
select sub_category,
sum(case when order_year=2022 then sales else 0 end) as sales_2022,
sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte 
group by sub_category
)
select top 1 *, (sales_2023-sales_2022)*100/sales_2022 as Growth_percentage 
from cte2
order by Growth_percentage desc


