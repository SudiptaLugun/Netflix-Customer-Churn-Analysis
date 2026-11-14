
CREATE TABLE customers (
    customer_id UUID PRIMARY KEY,
    age INTEGER,
    gender VARCHAR(20),
    subscription_type VARCHAR(50),
    watch_hours NUMERIC(10,2),
    last_login_days INTEGER,
    region VARCHAR(100),
    device VARCHAR(50),
    monthly_fee NUMERIC(10,2),
    churned INTEGER,
    payment_method VARCHAR(50),
    number_of_profiles INTEGER,
    avg_watch_time_per_day NUMERIC(10,2),
    favorite_genre VARCHAR(100),
    watch_hours_category VARCHAR(50),
    inactivity_category VARCHAR(50),
    monthly_fee_category VARCHAR(50),
    churn_status VARCHAR(30),
    daily_watch_category VARCHAR(50),
    age_group VARCHAR(30)
);


-- Display all customers older than 30.
WITH customer_data AS (
SELECT * FROM customers
)
SELECT * FROM customer_data
WHERE age > 30;

--Find customers who have churned.
WITH churned_customer AS (
SELECT * FROM customers 
WHERE churned = 1
) 
SELECT * FROM churned_customer;

--Find the average watch hours of customers.
WITH watch_summary AS (
SELECT AVG(watch_hours) AS avg_watch_hours
FROM customers
)
SELECT ROUND(avg_watch_hours,2) FROM watch_summary;

--Count customers in each region.
WITH region_data AS (
SELECT region, COUNT(*) AS total_customer
FROM customers
GROUP BY region
)
SELECT * FROM region_data;

--Find customers with monthly fees less than 500.
WITH customer_fee AS (
SELECT * FROM customers 
WHERE monthly_fee < 500
)
SELECT * FROM customer_fee;

--Give every customer a row number.
SELECT customer_id, age,
ROW_NUMBER() OVER() AS row_num
FROM customers;

--Rank customers according to their watch hours.
SELECT customer_id, watch_hours,
RANK() OVER(
ORDER BY watch_hours DESC
) AS watch_rank
FROM customers;

--Rank customers according to their monthly fees.
SELECT customer_id, monthly_fee,
DENSE_RANK() OVER(
ORDER BY monthly_fee DESC
) AS fee_rank 
FROM customers;

--Find the average watch hours of each subscription type.
SELECT customer_id ,watch_hours,subscription_type,
AVG(watch_hours) OVER( 
PARTITION BY subscription_type
)AS avg_watch_hours 
FROM customers;

--Find the total number of customers in each region without removing individual customer records.
SELECT customer_id, region, 
COUNT(*) OVER( PARTITION BY region) AS total_customer
FROM customers;

--Find the previous customer's monthly fee.
SELECT customer_id, monthly_fee,
LAG(monthly_fee) OVER(
ORDER BY customer_id DESC
)AS previous_fee
FROM customers;

--Find the next customer's monthly fee.
SELECT customer_id, monthly_fee,
LEAD(monthly_fee) OVER (
ORDER BY customer_id DESC
) AS next_fee
FROM customers;