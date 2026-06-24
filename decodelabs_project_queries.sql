CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
USE ecommerce_analysis;

-- Check table structure
DESCRIBE table_1;

-- View the data
SELECT * FROM table_1 
LIMIT 1000;

-- Convert text to number and sum
SELECT 
    SUM(CAST(REPLACE(TotalPrice, '$', '') AS DECIMAL(10,2))) AS TOTAL_REVENUE
FROM table_1;

-- total revenue
SELECT 
    CONCAT('$', FORMAT(SUM(CAST(REPLACE(TotalPrice, '$', '') AS DECIMAL(10,2))), 2)) 
    AS TOTAL_REVENUE
FROM table_1;

-- revenue by products
SELECT 
    Product,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Units_Sold,
    CONCAT('$', FORMAT(SUM(CAST(REPLACE(TotalPrice, '$', '') AS DECIMAL(10,2))), 2)) AS Revenue
FROM table_1
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 10;

-- revenue by month
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    CONCAT('$', FORMAT(SUM(CAST(REPLACE(TotalPrice, '$', '') AS DECIMAL(10,2))), 2)) AS Revenue
FROM table_1
GROUP BY Month
ORDER BY Month;

-- average order values
SELECT 
    COUNT(*) AS Total_Orders,
    CONCAT('$', FORMAT(AVG(CAST(REPLACE(TotalPrice, '$', '') AS DECIMAL(10,2))), 2)) AS Avg_Order_Value
FROM table_1;

-- most popular payment method
SELECT 
    PaymentMethod,
    COUNT(*) AS Order_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM table_1), 2) AS Percentage
FROM table_1
GROUP BY PaymentMethod
ORDER BY Order_Count DESC;

-- best refferal source
SELECT 
    ReferralSource,
    COUNT(*) AS Order_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM table_1), 2) AS Percentage_of_Orders,
    CONCAT('$', FORMAT(SUM(CAST(REPLACE(TotalPrice, '$', '') AS DECIMAL(10,2))), 2)) AS Revenue_Generated
FROM table_1
GROUP BY ReferralSource
ORDER BY Order_Count DESC
LIMIT 10;

-- top customers
SELECT 
    CustomerID,
    COUNT(*) AS Order_Count,
    CONCAT('$', FORMAT(SUM(CAST(REPLACE(TotalPrice, '$', '') AS DECIMAL(10,2))), 2)) AS Total_Spent,
    MAX(Date) AS Last_Purchase
FROM table_1
GROUP BY CustomerID
ORDER BY Total_Spent DESC
LIMIT 10;

