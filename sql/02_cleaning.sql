-- ============================================================
-- FILE: 02_cleaning.sql
-- PROJECT: Retail Sales Intelligence — SQL Analysis
-- DESCRIPTION: Data validation and quality checks
-- ============================================================

USE retail_sales_db;

-- 1. Check row counts across all tables
SELECT 'stores' AS table_name, COUNT(*) AS row_count FROM stores
UNION ALL SELECT 'oil', COUNT(*) FROM oil
UNION ALL SELECT 'holidays_events', COUNT(*) FROM holidays_events
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL SELECT 'sales', COUNT(*) FROM sales;

-- 2. Check for NULL values in sales
SELECT COUNT(*) AS null_sales FROM sales WHERE sales IS NULL;

-- 3. Check for NULL values in oil prices
SELECT COUNT(*) AS null_oil FROM oil WHERE dcoilwtico IS NULL;

-- 4. Check for duplicate IDs in sales table
SELECT id, COUNT(*) AS duplicate_count
FROM sales
GROUP BY id
HAVING COUNT(*) > 1;

-- 5. Validate date range of sales data
SELECT 
    MIN(date) AS earliest_date,
    MAX(date) AS latest_date
FROM sales;

-- 6. Check for negative sales values
SELECT COUNT(*) AS negative_sales_count
FROM sales
WHERE sales < 0;

-- 7. Check distinct store types
SELECT type, COUNT(*) AS store_count
FROM stores
GROUP BY type
ORDER BY type;

-- 8. Check distinct product families
SELECT family, COUNT(*) AS record_count
FROM sales
GROUP BY family
ORDER BY record_count DESC;

-- 9. Check for stores in sales that don't exist in stores table
SELECT DISTINCT s.store_nbr
FROM sales s
LEFT JOIN stores st ON s.store_nbr = st.store_nbr
WHERE st.store_nbr IS NULL;

-- 10. Check onpromotion value distribution
SELECT 
    onpromotion,
    COUNT(*) AS count
FROM sales
GROUP BY onpromotion
ORDER BY count DESC;
