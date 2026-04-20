
# 🛒 Retail Sales Intelligence — SQL Analysis
### End-to-End SQL Analysis of 3M+ Grocery Transactions | Corporación Favorita, Ecuador

---

## 📌 Project Overview

This project performs a complete business intelligence analysis on real-world grocery sales data from **Corporación Favorita**, one of Ecuador's largest supermarket chains.

Using **MySQL**, I analyzed over **3 million sales transactions** across **54 stores**, **33 product categories**, and **5 years (2013–2017)** to uncover actionable business insights across store performance, seasonal trends, promotion effectiveness, and year-over-year growth.

This project demonstrates practical, job-ready SQL skills including multi-table joins, window functions, CTEs, subqueries, and business storytelling through data.

---

## 🗃️ Dataset

- **Source:** [Kaggle — Store Sales: Time Series Forecasting](https://www.kaggle.com/competitions/store-sales-time-series-forecasting)
- **Company:** Corporación Favorita (Ecuador)
- **Total Records:** 3,000,888 sales transactions
- **Time Period:** January 2013 – August 2017
- **Tables Used:** `sales`, `stores`, `oil`, `holidays_events`, `transactions`

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Database and query execution |
| MySQL Workbench | IDE and data import |
| CSV / Excel | Output storage and review |

---

## 📁 Project Structure

```
retail-sales-sql-analysis/
│
├── README.md
├── sql/
│   ├── 01_setup.sql          ← Database schema and table creation
│   ├── 02_cleaning.sql       ← Data validation and quality checks
│   └── 03_analysis.sql       ← 10 business analysis queries
├── outputs/
│   ├── query1_top_stores.csv
│   ├── query2_top_products.csv
│   ├── query3_promotions.csv
│   ├── query4_monthly_sales.csv
│   ├── query5_revenue_by_city.csv
│   ├── query6_rolling_avg.csv
│   ├── query7_holiday_sales.csv
│   ├── query8_yoy_growth.csv
│   ├── query9_top_product_per_store.csv
│   └── query10_transactions.csv
└── insights/
    └── key_findings.md       ← Business insights and recommendations
```

---

## 📊 Key Business Findings

### 🏪 Store Performance
- **Store 44 in Quito** is the top revenue generator at **$62.09M** — nearly 14% more than the second-ranked store
- **9 out of the top 10 stores** are located in **Quito**, confirming it as the company's most profitable market
- All top 10 stores are **Type A** — indicating a strong correlation between store format and revenue potential
- Store 51 in **Guayaquil** ($32.9M) is the only non-Quito store in the top 10, making it a standout performer for its region

### 🛍️ Product Performance
- **GROCERY I** dominates all other categories with **$343.46M** in total sales — 58% more than the second category
- **Top 5 categories** — GROCERY I, BEVERAGES, PRODUCE, CLEANING, DAIRY — account for the majority of total revenue
- **GROCERY I** is the top-selling product in **53 out of 54 stores** — only Store 25 in Salinas leads with BEVERAGES
- Average daily sales of GROCERY I ($3,776.97) is 58% higher than BEVERAGES ($2,385.79)

### 📣 Promotion Effectiveness
- Items **on promotion** generate an average of **$1,137.69** per record vs only **$158.25** without promotion
- This is a **618% increase** in average sales — a massive impact
- Only **~20% of records (611,329)** involve promotions — suggesting significant untapped potential
- Recommendation: Increase promotional coverage in underperforming stores and categories

### 📅 Seasonality & Monthly Trends
- **July** is the highest-grossing month with **$103.36M** in total sales
- **March** ($97.23M) and **December** ($97.03M) follow closely as peak months
- **September** is the weakest month with only **$77.47M** — a 25% drop from July
- The data suggests Q3 (July–August) is the peak period, likely driven by summer/mid-year shopping behavior

### 🎉 Holiday vs Non-Holiday Sales
- Sales on **holidays average $393.86** per transaction vs **$352.16** on regular days
- This is an **11.8% uplift** on holidays — statistically significant across 502,524 holiday records
- Recommendation: Ensure full inventory and maximum staffing on national holidays

### 📈 Year-over-Year Growth
- **2014** saw the strongest growth across all stores — most stores grew **40–65% YoY**
- Growth stabilized in **2015–2016** at 5–25% across most stores
- **2017 shows negative growth** for all stores — but this is because the dataset only covers Jan–Aug 2017 (partial year), not an actual decline
- **Store 49 in Quito** showed the highest 2014 growth at **94.08%**
- **Store 36** (Libertad) had explosive 2014 growth of **136.97%** — likely a new store or major expansion

### 🔄 Transaction Volume
- **Store 44** also leads in daily transactions with an average of **4,336.97** — more than **2.5x the overall average (1,694.60)**
- **19 out of 54 stores** are above the overall average in transaction volume
- All above-average stores are clustered in major cities: Quito, Guayaquil, Ambato, Cayambe
- The bottom 35 stores average only ~1,100 transactions/day — indicating significant performance gaps across the network

---

## 💡 SQL Concepts Demonstrated

| Concept | Used In |
|---|---|
| `JOIN` (INNER, LEFT, CROSS) | Queries 1, 7, 10 |
| `GROUP BY` + Aggregations | Queries 1, 2, 3, 4 |
| `RANK() OVER (PARTITION BY)` | Query 5 |
| `AVG() OVER (ROWS BETWEEN)` | Query 6 — Rolling Average |
| `LAG()` Window Function | Query 8 — YoY Growth |
| `ROW_NUMBER() OVER` | Query 9 |
| `WITH` CTE | Queries 9, 10 |
| `CASE WHEN` | Queries 3, 7, 10 |
| `CROSS JOIN` | Query 10 |
| Subqueries | Queries 5, 8 |
| Date Functions (`MONTH`, `YEAR`, `MONTHNAME`) | Queries 4, 8 |

---

## 🚀 How to Run This Project

1. Install **MySQL 8.0** and **MySQL Workbench**
2. Create a new schema: `retail_sales_db`
3. Run `sql/01_setup.sql` to create all tables
4. Import the CSV files from [Kaggle](https://www.kaggle.com/competitions/store-sales-time-series-forecasting) using LOAD DATA or Import Wizard
5. Run `sql/02_cleaning.sql` to validate data quality
6. Run `sql/03_analysis.sql` to execute all 10 business queries

---

## 👤 About

**Kedaar** | Aspiring Data Analyst  
Currently building a portfolio in SQL, Power BI, and Python  
Open to fresher Data Analyst roles.

LinkedIn : www.linkedin.com/in/kedaar-prabhu-aa90b0232
