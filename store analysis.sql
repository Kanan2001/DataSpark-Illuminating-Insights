-- Query 1: Size Bucket vs Total Sales
SELECT
    -- Categorize stores into size buckets based on square meters
    CASE
        WHEN square_meters < 250 THEN '<250'
        WHEN square_meters BETWEEN 250 AND 500 THEN '250 to 500'
        WHEN square_meters BETWEEN 501 AND 750 THEN '500 to 750'
        WHEN square_meters BETWEEN 751 AND 1000 THEN '750 to 1000'
        WHEN square_meters BETWEEN 1001 AND 1250 THEN '1000 to 1250'
        WHEN square_meters BETWEEN 1251 AND 1500 THEN '1250 to 1500'
        WHEN square_meters BETWEEN 1501 AND 1750 THEN '1500 to 1750'
        WHEN square_meters BETWEEN 1751 AND 2000 THEN '1750 to 2000'
        WHEN square_meters > 2000 THEN '> 2000'
    END AS size_bucket,
    -- Calculate total sales for each size bucket
    ROUND(SUM(unit_price_usd * quantity), 2) AS total_sales
FROM overall
GROUP BY size_bucket
ORDER BY
    -- Order buckets by the defined size range
    CASE
        WHEN size_bucket = '<250' THEN 1
        WHEN size_bucket = '250 to 500' THEN 2
        WHEN size_bucket = '500 to 750' THEN 3
        WHEN size_bucket = '750 to 1000' THEN 4
        WHEN size_bucket = '1000 to 1250' THEN 5
        WHEN size_bucket = '1250 to 1500' THEN 6
        WHEN size_bucket = '1500 to 1750' THEN 7
        WHEN size_bucket = '1750 to 2000' THEN 8
        WHEN size_bucket = '> 2000' THEN 9
    END;

-- Query 2: Store Age Bucket vs Total Sales
SELECT
    -- Categorize stores into age buckets based on the difference between the current year and the store's open year
    CASE
        WHEN YEAR(CURDATE()) - YEAR(open_date) <= 5 THEN '<=5'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 6 AND 10 THEN '5 to 10'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 11 AND 15 THEN '10 to 15'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 16 AND 20 THEN '15 to 20'
    END AS store_age_bucket,
    -- Calculate total sales for each store age bucket
    ROUND(SUM(unit_price_usd * quantity), 2) AS total_sales
FROM overall
GROUP BY store_age_bucket
ORDER BY store_age_bucket;

-- Query 3: Sales Performance by Storekey, Country, Continent, and State
SELECT
  storekey,                                             -- Store identifier
  Country,                                             -- Country where the store is located
  Continent,                                           -- Continent where the store is located
  State,                                               -- State where the store is located
  -- Calculate total revenue for each combination of storekey, Country, Continent, and State
  ROUND(SUM(unit_price_usd * quantity), 2) AS total_revenue_USD
FROM overall
GROUP BY
  storekey, Country, Continent, State                   -- Group by store key, country, continent, and state
ORDER BY total_revenue_USD DESC;                        -- Order by total revenue in descending order
