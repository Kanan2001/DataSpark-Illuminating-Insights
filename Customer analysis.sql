-- Query 1: Count of customers by gender
SELECT gender, COUNT(*) AS Count_gender
FROM customers
GROUP BY gender;
-- This query groups the customers by their gender and counts the number of customers in each gender group.

-- Query 2: Age bucketing based on order date and birthday
SELECT
    age_bucket,
    COUNT(*) AS count
FROM (
    SELECT
        *,
        CASE
            -- Determine the age bucket based on the difference between the order date and birthday
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) <= 18 THEN '<=18'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 18 AND 25 THEN '18-25'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 25 AND 35 THEN '25-35'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 35 AND 45 THEN '35-45'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 45 AND 55 THEN '45-55'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 55 AND 65 THEN '55-65'
            ELSE '>65'
        END AS age_bucket
    FROM overall
) AS age_groups
GROUP BY age_bucket;
-- This query calculates the age of customers at the time of their orders, categorizes them into age buckets,
-- and then counts the number of customers in each age bucket.

-- Query 3: Customer count by geographical location
SELECT 
    continent, country, state, city, 
    COUNT(CustomerKey) AS customer_count
FROM 
    CUSTOMERS
GROUP BY 
    continent, country, state, city
ORDER BY 
    customer_count DESC;
-- This query groups customers by geographical details (continent, country, state, city) and counts the number of customers
-- in each group, ordering the results by the customer count in descending order.
