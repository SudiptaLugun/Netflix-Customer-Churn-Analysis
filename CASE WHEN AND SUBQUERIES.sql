
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


-- Categorise customers by age.Create three groups: 
--Below 25 = Young, 25–40 = Adult, Above 40 = Senior
SELECT customer_id, age,
CASE 
WHEN age < 25 THEN 'Young'
WHEN age < 40 THEN 'Adult'
ELSE 'Senior' 
END AS age_category
FROM customers;

--Categorise customers based on watch hours.
-- Below 50 = Low Watch, 50–150 = Medium Watch, Above 150 = High Watch
SELECT customer_id, watch_hours,
CASE
WHEN watch_hours <50 THEN 'low watch'
WHEN watch_hours < 150 THEN 'medium watch'
ELSE 'high watch'
END AS watch_category
FROM customers;

--Identify customer churn risk based on inactivity.
--More than 60 days = High Risk, 31–60 days = Medium Risk, 0–30 days = Low Risk
SELECT customer_id, last_login_days,
CASE
WHEN last_login_days > 60 THEN 'high risk'
WHEN last_login_days > 30 THEN 'medium risk'
ELSE 'low risk'
END AS churn_risk
FROM customers;

--Calculate churn status using CASE WHEN.
SELECT customer_id, churned,
CASE
WHEN churned = 1 THEN 'churned'
WHEN churned = 0  THEN 'active'
ELSE 'unknown' 
END AS churn_status
FROM customers;

--Count customers in each churn-risk category.
SELECT 
CASE 
 WHEN last_login_days > 60 THEN 'high risk'
 WHEN last_login_days > 30 THEN 'medium risk'
 ELSE 'low risk'
 END AS risk_category,
 COUNT(*) AS total_customer
 FROM customers
 GROUP BY risk_category
 ORDER BY total_customer DESC;

--Find customers whose watch hours are greater than the overall average watch hours.
SELECT customer_id , watch_hours
FROM customers
WHERE watch_hours > (
SELECT AVG(watch_hours)
FROM customers);

--Find customers whose monthly fee is greater than the average monthly fee.
SELECT customer_id , monthly_fee
FROM customers
WHERE monthly_fee > (
SELECT AVG(monthly_fee)
FROM customers);

--Find customers whose age is greater than the average age of churned customers.
SELECT customer_id,age,churned
FROM customers
WHERE age > ( 
SELECT AVG(age)
FROM customers
WHERE churned = 1);

--Find customers who watch more hours than the average watch hours of Premium subscribers.
SELECT customer_id,watch_hours,subscription_type
FROM customers
WHERE watch_hours > (
SELECT AVG(watch_hours) 
FROM customers
WHERE subscription_type = 'Premium'
);

--Find customers who belong to the most popular subscription type.
SELECT *
FROM customers
WHERE subscription_type = (
SELECT subscription_type
FROM customers
GROUP BY subscription_type
ORDER BY COUNT(*) DESC
LIMIT 1
);

--Find the region with the highest number of churned customers and display its customers.
SELECT * FROM customers
WHERE region = (
SELECT region 
FROM customers
WHERE churned =1
GROUP BY region
ORDER BY COUNT(*) DESC
LIMIT 1)
AND churned = 1;

) 