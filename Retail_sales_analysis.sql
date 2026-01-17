
---- Retail Sales Analysis ------ P1 ----
create database sql_project_P1

use sql_project_P1

---- create table
DROP TABLE IF EXISTS retail_sales_p1 ;
create table  retail_sales_p1
      (
			transactions_id INT PRIMARY KEY,
			sale_date date,
			sale_time TIME ,
			customer_id INT,
			gender varchar  (15),
			age INT,
			category Varchar (15),
			quantity INT,	
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
      )

select top 10*
from retail_sales_p1


SELECT
	 COUNT(customer_id)
from retail_sales_p1

---Data Cleaning---

select * from retail_sales_p1
where  sale_date IS NULL

select * from retail_sales_p1
where sale_time IS NULL
 
 select * from retail_sales_p1
 where 
		transactions_id IS NULL
		OR
		sale_date is null
		OR
		sale_time IS NULL
		or
		gender IS NULL
		OR
		age IS NULL
		OR
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null

DELETE from retail_sales_p1
	WHERE
		transactions_id IS NULL
		OR
		sale_date is null
		OR
		sale_time IS NULL
		or
		gender IS NULL
		OR
		age IS NULL
		OR
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null


--Data Exploration


--How Many sales we have ?

select count(*) as total_Sales
from retail_sales_p1

---- how may customers we have ?----


select COUNT( DISTINCT customer_id) as total_customer
from retail_sales_p1

how many categeries we have ?

SELECT 
	DISTINCT category from retail_sales_p1


-------Data Analysis & Business key problems & Answers




-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * 
FROM retail_sales_p1
where sale_date ='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retail_sales_p1
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date <  '2022-12-01'
  AND Quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
	
select 
	category ,
	SUM(total_sale) as net_Sale,
	COUNT(*) as total_orders
from retail_sales_p1
GROUP by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
	
		select 
		AVG(age) as avg_age
		from retail_sales_p1
		where category ='Beauty'
		

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

	SELECT * FROM retail_sales_p1
	WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
	
	SELECT 
		category,
		gender,
		count(*) as total_transactions
	FROM retail_sales_p1
	GROUP by category,
			 gender
order by category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
	
	WITH monthly_avg AS (
    SELECT
        YEAR(sale_date)  AS sales_year,
        MONTH(sale_date) AS sales_month,
        AVG(total_sale)  AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rn
    FROM retail_sales_p1
    GROUP BY
        YEAR(sale_date),
        MONTH(sale_date)
)
SELECT
    sales_year,
    sales_month,
    avg_sale
FROM monthly_avg
WHERE rn = 1;

	
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
	
	SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales_p1
GROUP BY customer_id
ORDER BY total_sales DESC;

	


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

	SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales_p1
GROUP BY category
ORDER BY category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 16 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales_p1
)
SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift
ORDER BY shift;



---END OF Project----