
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


--Display all records from the customers table.
SELECT * FROM customers;

--Display only the first 10 customers.
SELECT * FROM customers
LIMIT 10;

--Find the total number of customers.
SELECT COUNT(*) FROM customers;

--Find all unique subscription types.
SELECT DISTINCT subscription_type FROM customers;

--Find all unique regions.
SELECT DISTINCT region FROM customers;

--Display customers who are older than 30.
SELECT * FROM customers 
WHERE age > 30;

--Find customers who have a Premium subscription.
SELECT * FROM customers
WHERE subscription_type = 'Premium';

--Find customers who have churned.
SELECT * FROM customers
WHERE churned = 1;

--Find customers who have not churned.
SELECT * FROM customers
WHERE churned = 0;

--Display customers who have been inactive for more than 30 days.
SELECT * FROM customers
WHERE last_login_days > 30;

--Find customers whose monthly fee is less than 500.
SELECT * FROM customers
 WHERE monthly_fee < 500;

--Display the top 10 customers based on watch hours.
SELECT * FROM customers
ORDER BY watch_hours DESC
LIMIT 10;