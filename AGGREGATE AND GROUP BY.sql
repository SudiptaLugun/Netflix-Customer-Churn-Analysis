
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


--Calculate the average age of customers.
SELECT ROUND(AVG(age),2) AS avg_age FROM customers;

--Find the maximum watch hours.
SELECT MAX(watch_hours) AS max_watch_hours FROM customers;

--Find the minimum monthly subscription fee.
SELECT MIN(monthly_fee) AS minimum_monthly_fee FROM customers;

--Calculate total revenue based on monthly fees.
SELECT ROUND(SUM(monthly_fee),2) AS total_revenue FROM customers;

--Count the total number of customers who have churned.
SELECT COUNT(*) AS churned_customers FROM customers
WHERE churned = 1;

--Find the number of customers in each subscription type.
SELECT subscription_type , COUNT(*)AS total_customers FROM customers 
GROUP BY subscription_type;

--Find the average watch hours for each subscription type.
SELECT subscription_type , ROUND(AVG(watch_hours),2) AS avg_watch_hours FROM customers
GROUP BY subscription_type;

--Find the number of churned customers in each region.
SELECT region , COUNT(*) AS  churned_customers FROM customers
WHERE churned = 1
GROUP BY region
ORDER BY COUNT(*) DESC;

--Find the average monthly fee for each device.
SELECT device, ROUND(AVG(monthly_fee),2)AS avg_monthly_fee
FROM customers
GROUP BY device
ORDER BY AVG( monthly_fee) DESC;

--Find the most popular payment method.
SELECT payment_method, COUNT(*) AS total_customer
FROM customers
GROUP BY payment_method 
ORDER BY COUNT(*) DESC;

--Find the number of customers in each age group.
SELECT age_group , COUNT(*) AS total_customer
FROM customers
GROUP BY age_group 
ORDER BY COUNT(*) DESC;

--