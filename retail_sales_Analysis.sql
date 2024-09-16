
------------DATA CLEANING PROCESS----------------------

select * from reatil_sales
where transactions_id is NULL


select * from reatil_sales
where sale_date is NULL

select * from reatil_sales
where sale_time is NULL


--** To find the Null values at one go 

select * from reatil_sales
where transactions_id is NULL
or
sale_date is NULL
or
sale_time is NULL
or
gender is null
or 
age is null
or
customer_id is null
or
category is null
or 
quantiy is null
or 
price_per_unit is null
or
cogs is null
or
total_sale is null

--** How to delete null value rows

delete from reatil_sales
where transactions_id is NULL
or
sale_date is NULL
or
sale_time is NULL
or
gender is null
or 
age is null
or
customer_id is null
or
category is null
or 
quantiy is null
or 
price_per_unit is null
or
cogs is null
or
total_sale is null

select COUNT(*) from reatil_sales


---------------------DATA EXPLORATION PROCESS --------------------------------

--How many sales we have 

select COUNT(*) as total_sales from reatil_sales


--How many customers do we have 

select COUNT( distinct customer_id) as total_customers from reatil_sales

--How many categories we have

select category , COUNT( distinct category) as total_categories from reatil_sales
group by category

-----DATA ALALYIS & BUSINESS KEY PROBLEMS & ANSWERS

--Write a SQL query to retrive all columns for sales made on '2022-11-05'

select * from reatil_sales
where  extract sale_date )like '2022-11-05'


--Write a SQL query to retrive all transactions where category is 'clothing' and the quantity sold is more than 10 in the month of nov-2022

select * from reatil_sales
where category like 'clothing'
and 
quantiy < 10 

--Write a SQL query to calculate the total sales (total_sale) as ecah category 

select  category ,  sum(total_sale)  as 'totalsales' , count(*) as 'total_orders ' from reatil_sales
group by category 


--Write a Sql query to find the average age of customers who purchased items from the 'Beauty' category

select  category , cast(avg(age) AS decimal(10,0)) as 'avg_age' from reatil_sales
where category like 'Beauty'
group by category

--Write a SQL query to find all transactions where the total_sale is greater than 1000
select * from reatil_sales
where total_sale > 1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
select   category , gender ,
 COUNT(transactions_id) as 'total_transactions' from reatil_sales
group by  category , gender

--Write a SQL query to calculate the average sale for each month .Find out best seling month in each year

select * from  (
select YEAR(sale_date) as 'year' ,
MONTH(sale_date) as 'month',
cast (avg(total_sale) AS decimal(10,2)) as 'total_sale',
rank() over(partition by YEAR(sale_date) order by avg(total_sale) ) as ranking
from reatil_sales
group by YEAR(sale_date) , MONTH(sale_date)
 ) as a1
where ranking = 1

--Write a SQL query to find the top 5 customers based on the highest total sales

select top 5  customer_id , sum(total_sale) as 'total_sales'
from reatil_sales
group by customer_id

-----select customer_id , SUM(total_sale) as 'total_sales'
----from reatil_sales
----group by customer_id
---order by total_sales desc
---fetch  first 5  Rows only 






--Write a SQL query to find the number of unique customwers who purchased items from ecah category

select count(distinct customer_id) count_of_cus , category from reatil_sales
group by category


--Write a SQL query to create each shift abd number and number of orders (example morning <=12 , Afternoon between 12 & 17 , evening > 17)


select * ,
CASE 
when extract(hour from sale_time) < 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17  then 'Afternoon'
else 'Evening'
end as shift
from reatil_sales
