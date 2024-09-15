-- Query 1: Monthly Sales Analysis
SELECT
  MONTHNAME(order_date) AS month,                      -- Get the name of the month from the order date
  ROUND(SUM(unit_price_usd * quantity), 2) AS total_revenue_USD  -- Calculate the total revenue by summing unit price multiplied by quantity
FROM
  overall
GROUP BY
  MONTHNAME(order_date);                              -- Group results by month
  

-- Query 2: Top Products by Quantity Sold
SELECT
  product_name,                                       -- Name of the product
  SUM(quantity) AS total_quantity                     -- Total quantity sold of the product
FROM
   overall
GROUP BY
  product_name                                       -- Group results by product name
ORDER BY
  total_quantity DESC                               -- Order the results by total quantity in descending order
LIMIT 10;                                           -- Limit the results to the top 10 products by quantity sold

-- Query 3: Top Products by Revenue
SELECT
  product_name,                                      -- Name of the product
  ROUND(SUM(unit_price_usd * quantity), 2) AS total_revenue_USD  -- Calculate the total revenue by summing unit price multiplied by quantity
FROM
  overall
GROUP BY
  product_name                                      -- Group results by product name
ORDER BY
  total_revenue_USD DESC                            -- Order the results by total revenue in descending order
LIMIT 10;                                          -- Limit the results to the top 10 products by revenue

-- Query 4: Sales by Store Performance
SELECT
  storekey,                                          -- Identifier for the store
  ROUND(SUM(unit_price_usd * quantity), 2) AS total_revenue_USD  -- Calculate the total revenue by summing unit price multiplied by quantity
FROM
  overall
GROUP BY
  storekey                                          -- Group results by store key
ORDER BY
  total_revenue_USD DESC                            -- Order the results by total revenue in descending order
