--Explore Data Analysis AND Data Preprocessing
--View columns
SELECT *
FROM brightcoffee.sales.data;

-- Checking for duplicates
SELECT *,
    COUNT(*)
FROM brightcoffee.sales.data
GROUP BY ALL
HAVING COUNT(*) > 1;  --Data has no duplicates

-- Checking for null values

SELECT * 
FROM brightcoffee.sales.data
WHERE transaction_id IS NULL OR transaction_date IS NULL OR transaction_time IS NULL OR transaction_qty IS NULL OR store_id IS NULL OR store_location IS NULL OR product_id IS NULL OR unit_price IS NULL OR product_category IS NULL OR product_type IS NULL OR product_detail IS NULL;  -- No null values


--COUNT the number of different shops
SELECT COUNT(DISTINCT store_id)AS number_of_shops
FROM brightcoffee.sales.data;

--Show the name of the different store location
SELECT DISTINCT store_location,
                store_id
FROM brightcoffee.sales.data; 

--Checking the product categories
SELECT DISTINCT product_category
FROM brightcoffee.sales.data;

--Checking the number of product type
SELECT DISTINCT product_type
FROM brightcoffee.sales.data;

--Total number of sales/transactions made
SELECT COUNT(transaction_id) AS number_of_transactions
FROM brightcoffee.sales.data;

--Calculating revenue per transaction
SELECT transaction_id,
transaction_qty*unit_price AS revenue
FROM brightcoffee.sales.data;

--Calculate revenue per store
SELECT store_location,
       SUM(transaction_qty*unit_price) AS revenue
       
FROM brightcoffee.sales.data
GROUP BY store_location;

--What time does the shop opens
SELECT MIN(transaction_time) AS opening_time
FROM brightcoffee.sales.data;

--What time does the shop close
SELECT MAX(transaction_time) AS close_time
FROM brightcoffee.sales.data;

--Filtering with month
SELECT MONTHNAME(transaction_date) AS month
FROM brightcoffee.sales.data;

--Filtering with MONTH And YEAR
SELECT TO_CHAR(transaction_date, 'MON YYYY') AS month_year
FROM brightcoffee.sales.data;

--Filtering with DAYNAME
SELECT DAYNAME(transaction_date) AS day_name
FROM brightcoffee.sales.data;

--Final query to extract data for analysis
SELECT product_category,
       SUM(transaction_qty*unit_price) AS revenue,
       SUM(transaction_qty) AS total_quantity,
       AVG(unit_price) AS avg_unit_price,
       MONTHNAME(transaction_date) AS Month,
       DAYNAME(transaction_date) AS day_name,
       store_location,
       transaction_date,
       transaction_time,
       CASE
         WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '01.Morning'
         WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN '02.Afternoon'
         WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '03.Evening'
         WHEN transaction_time >='20:00:00' THEN '04.Night'
         END AS time_bucket
FROM brightcoffee.sales.data
WHERE transaction_date >= '2023-01-01'
GROUP BY product_category,
         store_location,
         transaction_date,
         time_bucket,
         transaction_time

  ORDER BY revenue DESC;       
         
         

         
