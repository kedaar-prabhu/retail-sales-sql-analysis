-- ============================================================
-- FILE: 03_analysis.sql
-- PROJECT: Retail Sales Intelligence — SQL Analysis
-- DATASET: Corporación Favorita Store Sales (Kaggle)
-- AUTHOR: Kedaar
-- DESCRIPTION: 10 business analysis queries covering store
--              performance, product trends, promotions,
--              seasonality, and year-over-year growth
-- ============================================================

USE retail_sales_db;


-- ============================================================
-- QUERY 1: Top 10 Stores by Total Revenue
-- Business Question: Which stores generate the most revenue?
-- SQL Concepts: JOIN, GROUP BY, ORDER BY, ROUND, LIMIT
-- Key Finding: Store 44 in Quito leads with $62.09M
-- ============================================================

SELECT 
    s.store_nbr,
    st.city,
    st.type,
    ROUND(SUM(s.sales), 2) AS total_revenue
FROM sales s
JOIN stores st ON s.store_nbr = st.store_nbr
GROUP BY s.store_nbr, st.city, st.type
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- QUERY 2: Top 5 Product Families by Total Sales
-- Business Question: Which product categories drive the most revenue?
-- SQL Concepts: GROUP BY, SUM, AVG, ORDER BY, LIMIT
-- Key Finding: GROCERY I leads at $343.46M — 58% more than BEVERAGES
-- ============================================================

SELECT 
    family,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS avg_daily_sales
FROM sales
GROUP BY family
ORDER BY total_sales DESC
LIMIT 5;


-- ============================================================
-- QUERY 3: Impact of Promotions on Average Sales
-- Business Question: Do promotions actually increase sales?
-- SQL Concepts: CASE WHEN, GROUP BY, AVG, COUNT
-- Key Finding: Promoted items average $1,137.69 vs $158.25 — a 618% uplift
-- ============================================================

SELECT 
    CASE WHEN onpromotion > 0 THEN 'On Promotion' ELSE 'No Promotion' END AS promo_status,
    ROUND(AVG(sales), 2) AS avg_sales,
    COUNT(*) AS total_records
FROM sales
GROUP BY promo_status;


-- ============================================================
-- QUERY 4: Monthly Sales Trends
-- Business Question: Which months consistently generate the highest sales?
-- SQL Concepts: MONTH(), MONTHNAME(), GROUP BY, ORDER BY
-- Key Finding: July is the peak month ($103.36M); September is weakest ($77.47M)
-- ============================================================

SELECT 
    MONTH(date) AS month_number,
    MONTHNAME(date) AS month_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY month_number, month_name
ORDER BY total_sales DESC;


-- ============================================================
-- QUERY 5: Store Rankings by Revenue Within Each City
-- Business Question: Which store is the top performer in each city?
-- SQL Concepts: RANK() OVER (PARTITION BY), Subquery, JOIN
-- Key Finding: Quito has 18 stores with Store 44 ranking #1 at $62.09M
-- ============================================================

SELECT 
    store_nbr,
    city,
    total_revenue,
    RANK() OVER (PARTITION BY city ORDER BY total_revenue DESC) AS city_rank
FROM (
    SELECT 
        s.store_nbr,
        st.city,
        ROUND(SUM(s.sales), 2) AS total_revenue
    FROM sales s
    JOIN stores st ON s.store_nbr = st.store_nbr
    GROUP BY s.store_nbr, st.city
) AS store_totals
ORDER BY city, city_rank;


-- ============================================================
-- QUERY 6: 7-Day Rolling Average of Daily Sales
-- Business Question: What is the smoothed daily sales trend over time?
-- SQL Concepts: AVG() OVER (ROWS BETWEEN), Window Functions, GROUP BY
-- Key Finding: Rolling avg peaks around Dec 2016 (~$1.1M/day)
-- ============================================================

SELECT 
    date,
    ROUND(SUM(sales), 2) AS daily_sales,
    ROUND(AVG(SUM(sales)) OVER (
        ORDER BY date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_7day_avg
FROM sales
GROUP BY date
ORDER BY date;


-- ============================================================
-- QUERY 7: Sales on Holidays vs Non-Holidays
-- Business Question: Do holidays significantly boost sales?
-- SQL Concepts: LEFT JOIN, CASE WHEN, AVG, SUM, COUNT
-- Key Finding: Holiday avg ($393.86) is 11.8% higher than non-holiday ($352.16)
-- ============================================================

SELECT 
    CASE WHEN h.date IS NOT NULL THEN 'Holiday' ELSE 'Non-Holiday' END AS day_type,
    ROUND(AVG(s.sales), 2) AS avg_sales,
    ROUND(SUM(s.sales), 2) AS total_sales,
    COUNT(*) AS total_records
FROM sales s
LEFT JOIN holidays_events h ON s.date = h.date
GROUP BY day_type;


-- ============================================================
-- QUERY 8: Year-over-Year Sales Growth by Store
-- Business Question: Which stores show the strongest growth trends?
-- SQL Concepts: LAG() Window Function, PARTITION BY, Subquery, YEAR()
-- Key Finding: Most stores grew 40-65% in 2014; Store 49 grew 94%
-- ============================================================

SELECT 
    store_nbr,
    year,
    total_sales,
    LAG(total_sales) OVER (PARTITION BY store_nbr ORDER BY year) AS prev_year_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (PARTITION BY store_nbr ORDER BY year)) 
        / LAG(total_sales) OVER (PARTITION BY store_nbr ORDER BY year) * 100
    , 2) AS yoy_growth_pct
FROM (
    SELECT 
        store_nbr,
        YEAR(date) AS year,
        ROUND(SUM(sales), 2) AS total_sales
    FROM sales
    GROUP BY store_nbr, year
) AS yearly_sales
ORDER BY store_nbr, year;


-- ============================================================
-- QUERY 9: Top Performing Product Per Store (CTE)
-- Business Question: What is the #1 selling product in each store?
-- SQL Concepts: WITH CTE, ROW_NUMBER() OVER (PARTITION BY), SUM
-- Key Finding: GROCERY I is the top product in 53 out of 54 stores
-- ============================================================

WITH ranked_products AS (
    SELECT 
        store_nbr,
        family,
        ROUND(SUM(sales), 2) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY store_nbr ORDER BY SUM(sales) DESC) AS rn
    FROM sales
    GROUP BY store_nbr, family
)
SELECT 
    store_nbr,
    family AS top_product,
    total_sales
FROM ranked_products
WHERE rn = 1
ORDER BY store_nbr;


-- ============================================================
-- QUERY 10: Stores with Above/Below Average Transaction Volume
-- Business Question: Which stores are high-traffic vs low-traffic?
-- SQL Concepts: WITH CTE, CROSS JOIN, AVG, CASE WHEN, JOIN
-- Key Finding: Only 19 of 54 stores exceed the average (1,694.60 transactions/day)
-- ============================================================

WITH store_avg AS (
    SELECT 
        store_nbr,
        ROUND(AVG(transactions), 2) AS avg_transactions
    FROM transactions
    GROUP BY store_nbr
),
overall_avg AS (
    SELECT ROUND(AVG(transactions), 2) AS overall_avg FROM transactions
)
SELECT 
    sa.store_nbr,
    st.city,
    st.type,
    sa.avg_transactions,
    oa.overall_avg,
    CASE 
        WHEN sa.avg_transactions > oa.overall_avg THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM store_avg sa
JOIN stores st ON sa.store_nbr = st.store_nbr
CROSS JOIN overall_avg oa
ORDER BY sa.avg_transactions DESC;
