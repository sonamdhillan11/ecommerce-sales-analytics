# E-Commerce Sales & Profitability Analytics

## 📌 Project Overview

This project is an end-to-end E-Commerce Sales and Profitability Analytics solution developed to analyze business performance across sales, customers, products, regions, discounts, and profitability.

The project demonstrates how raw transactional data can be transformed into meaningful business insights using **Excel, SQL Server, Power Query, Power BI, and DAX**.

The objective is to understand key business drivers, identify high- and low-performing areas, evaluate profitability, and build an interactive analytical report that can support data-driven decision-making.

---

## 🎯 Business Objectives

The key objectives of this project are to:

- Analyze overall sales, cost, and profit performance
- Track sales and profit trends over time
- Identify top-performing and underperforming products
- Analyze customer segments and customer contribution
- Compare regional sales and profitability
- Evaluate category and subcategory performance
- Analyze payment modes
- Understand the impact of discounts on profitability
- Identify loss-making orders and products
- Calculate key business KPIs
- Build an interactive Power BI report for business analysis

---

## 📊 Dataset

The project uses a structured e-commerce transactional dataset created for this portfolio project.

The dataset consists of three related tables:

### 1. Ecommerce_Orders

The transactional fact table containing:

- Order_ID
- Order_Date
- Customer_ID
- Product_ID
- Quantity
- Discount
- Sales
- Cost
- Profit
- Region
- Payment_Mode

### 2. Ecommerce_Customers

The customer dimension table containing:

- Customer_ID
- Customer_Segment
- City

### 3. Ecommerce_Products

The product dimension table containing:

- Product_ID
- Product
- Category
- Subcategory

The dataset contains **3,000 orders, 800 customers, and 12 products**, covering transactions from **2024 to 2025**.

---

## 🔎 Data Quality & Preparation

Before analysis, the data was checked and prepared for analytical use.

The following data-quality checks were performed:

- Missing value detection
- Duplicate Order_ID detection
- Data type validation
- Quantity validation
- Sales and cost validation
- Profit validation
- Discount range validation
- Date range validation
- Business logic checks

Loss-making transactions were retained intentionally because they provide valuable insights into profitability and potential business problems.

---

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| Excel | Initial data inspection and quality checks |
| SQL Server | Business analysis and advanced SQL queries |
| Power Query | Data transformation and preparation |
| Power BI | Interactive reporting and visualization |
| DAX | Business KPIs and analytical calculations |
| GitHub | Project documentation and portfolio management |

---

## 🧩 Data Model

The project follows a **star-schema data model** consisting of one fact table and two dimension tables.

```text
                  Ecommerce_Customers
                         |
                         | Customer_ID
                         |
                         v
                  Ecommerce_Orders
                         ^
                         |
                         | Product_ID
                         |
                  Ecommerce_Products

### Fact Table

**Ecommerce_Orders**

Contains transactional and measurable business information such as:

- Sales
- Cost
- Profit
- Quantity
- Order information
- Customer and Product keys

### Dimension Tables

**Ecommerce_Customers**

Provides descriptive customer information such as customer segment and city.

**Ecommerce_Products**

Provides descriptive product information such as product, category, and subcategory.

The relationships follow a **one-to-many structure**, where each customer and product can be associated with multiple orders.

---

## 🧮 Key DAX Measures

The following DAX measures were created to calculate important business KPIs:

```DAX
Total Sales = SUM(Ecommerce_Orders[Sales])

Total Cost = SUM(Ecommerce_Orders[Cost])

Total Profit = SUM(Ecommerce_Orders[Profit])

Total Orders = DISTINCTCOUNT(Ecommerce_Orders[Order_ID])

Total Customers = DISTINCTCOUNT(Ecommerce_Orders[Customer_ID])

Total Quantity = SUM(Ecommerce_Orders[Quantity])

AOV = DIVIDE([Total Sales], [Total Orders])

Profit Margin = DIVIDE([Total Profit], [Total Sales], 0)

---

## 💻 SQL Analysis

SQL Server was used to perform business-oriented analysis on the transactional data.

The analysis includes:

### Overall Business Performance
- Total Sales
- Total Cost
- Total Profit
- Total Orders
- Total Customers
- Total Quantity
- Average Order Value
- Profit Margin

### Time Analysis
- Sales and profit by year
- Monthly sales trends
- Highest-sales month
- Highest-profit month
- Year-over-year comparison
- Running total sales

### Product Analysis
- Sales and profit by product
- Quantity sold by product
- Top and lowest-performing products
- Sales and profit by category
- Sales by subcategory
- Top products within each category

### Customer Analysis
- Sales and profit by customer segment
- Top customers by sales
- Top customers by profit
- Customers spending above average
- Customer performance by segment

### Regional Analysis
- Sales by region
- Profit by region
- Highest-performing regions
- Regional profit margins

### Payment & Discount Analysis
- Orders by payment mode
- Sales by payment mode
- Average discount
- Discounted vs non-discounted profitability
- Sales and profit by discount level

### Loss Analysis
- Number of loss-making orders
- Total loss
- Products with loss-making orders
- Regions with loss-making orders
- Discount impact on loss-making orders

### Advanced SQL Techniques

The project also demonstrates:

- Joins
- Aggregate Functions
- GROUP BY
- HAVING
- CASE Statements
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- LAG()
- Running Totals
- Year-over-Year Calculations

Detailed SQL queries are available in:

`SQL/Ecommerce_Analytics.sql`

---

## 📊 Power BI Report

The Power BI report consists of four analytical pages designed to provide different perspectives of business performance.

### 1. Executive Overview

Provides a high-level summary using KPI cards and visualizations.

Key metrics include:

- Total Sales
- Total Cost
- Total Profit
- Total Quantity
- Total Orders
- Total Customers
- Average Order Value
- Profit Margin
- Loss-Making Orders

Visualizations include:

- Sales Trend
- Sales by Region
- Sales by Category

### 2. Sales Analysis

Focuses on sales performance across customers, products, cities, and categories.

Includes:

- Sales by Customer Segment
- Top Products by Sales
- Sales by City
- Profit by Category
- Interactive filters for Date, Category, Product, Region, and Payment Mode

### 3. Customer Analysis

Focuses on customer contribution and behavior.

Includes:

- Customer Segment Analysis
- Sales and Profit by Customer Segment
- Top Customers by Sales
- Top Customers by Profit
- Customer contribution analysis

### 4. Profitability & Loss Analysis

Focuses on profitability and loss areas.

Includes:

- Profit by Category
- Profit by Product
- Profit Margin by Region
- Discounted vs Non-Discounted Profit
- Loss-Making Orders
- Total Loss

---

## 🔍 Key Business Questions

The project answers important business questions such as:

- What is the overall sales and profitability performance?
- Which year generated higher sales and profit?
- Which products generate the highest sales and profit?
- Which categories contribute the most to revenue?
- Which customer segment generates the highest sales?
- Which customers contribute the most revenue and profit?
- Which region performs best?
- How do discounts affect profitability?
- How many orders are loss-making?
- Which products and regions contribute to losses?
- Which customers have above-average spending?

---

## 💡 Business Value

The analysis can support business decisions related to:

- Product and category strategy
- Customer targeting
- Regional performance management
- Pricing and discount optimization
- Profitability improvement
- Identification of loss-making areas
- Sales performance monitoring

---

## 🔄 Project Workflow

```text
Raw Data
   ↓
Data Understanding
   ↓
Data Quality Checks
   ↓
Data Transformation
   ↓
SQL Business Analysis
   ↓
Data Modeling
   ↓
DAX Measures
   ↓
Power BI Visualization
   ↓
Business Insights
   ↓
Recommendations

---

## 📸 Dashboard Preview

### Executive Overview

![Executive Overview](Screenshots/Executive_Overview.png)

### Sales Analysis

![Sales Analysis](Screenshots/sales analysis.png)

### Customer Analysis

![Customer Analysis](Screenshots/customer analysis.png)

### Profitability & Loss Analysis

![Profitability & Loss Analysis](Screenshots/proftability and loss.png)

---

## 🚀 Skills Demonstrated

- Data Analysis
- Data Cleaning & Validation
- SQL
- Advanced SQL
- Data Modeling
- Star Schema
- Power Query
- DAX
- Power BI
- KPI Development
- Data Visualization
- Dashboard Development
- Business Intelligence
- Customer Analysis
- Product Analysis
- Profitability Analysis
- Business Insight Generation

---

## 👩‍💻 Author

**Sonam Dhillan**

Aspiring Data Analyst

**Skills:** SQL | Power BI | DAX | Excel | Python | Data Analytics | Machine Learning

## 📁 Repository Structure

ecommerce-sales-analytics/
│
├── Data/
│   ├── Ecommerce_Orders.csv
│   ├── Ecommerce_Customers.csv
│   └── Ecommerce_Products.csv
│
├── SQL/
│   └── Ecommerce_Analytics.sql
│
├── PowerBI/
│   └── Ecommerce_Analytics.pbix
│
├── Screenshots/
│   ├── Executive_Overview.png
│   ├── Sales_Analysis.png
│   ├── Customer_Analysis.png
│   └── Profitability_Analysis.png
│
└── README.md

## 👩‍💻 Author

**Sonam Dhillan**

Aspiring Data Analyst

**Skills:** SQL | Power BI | DAX | Excel | Python | Data Analytics
