-- Query 1: Category and Subcategory Analysis
SELECT
    category,                 -- Category of the product
    subcategory,              -- Subcategory of the product
    ROUND(SUM(unit_price_usd * quantity), 2) AS total_sales  -- Total sales calculated by unit price and quantity
FROM overall
GROUP BY category, subcategory  -- Group the results by category and subcategory
ORDER BY total_sales DESC;      -- Order the results by total sales in descending order

-- Query 2: Most Popular Products Based on Sales Quantity
SELECT
    product_name,             -- Name of the product
    SUM(quantity) AS Quantity  -- Total quantity sold of the product
FROM overall
GROUP BY product_name         -- Group the results by product name
ORDER BY Quantity DESC         -- Order the results by quantity in descending order
LIMIT 10;                      -- Limit the results to the top 10 most popular products

-- Query 3: Least Popular Products Based on Sales Quantity
SELECT
    product_name,             -- Name of the product
    SUM(quantity) AS Quantity  -- Total quantity sold of the product
FROM overall
GROUP BY product_name         -- Group the results by product name
ORDER BY Quantity              -- Order the results by quantity in ascending order
LIMIT 10;                      -- Limit the results to the top 10 least popular products

-- Query 4: Profitability Analysis by Product
SELECT
    product_name,                              -- Name of the product
    ROUND(SUM((unit_price_usd - unit_cost_usd) * quantity), 2) AS Profit_Margin  -- Calculate profit margin as (unit price - unit cost) * quantity
FROM overall
GROUP BY product_name                      -- Group the results by product name
ORDER BY Profit_Margin DESC                 -- Order the results by profit margin in descending order
LIMIT 10;                                  -- Limit the results to the top 10 most profitable products
