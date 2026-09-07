/*
===============================================================================
PROJECT : E-Commerce Sales, Customer & Profitability Analytics
DATABASE: Ecommerce_Analytics
PURPOSE : SQL business analysis for portfolio / interview demonstration
===============================================================================
TABLES
Ecommerce_Orders     : Fact table
Ecommerce_Customers  : Customer dimension
Ecommerce_Products   : Product dimension
===============================================================================
*/

-- ============================================================================
-- 1. OVERALL BUSINESS PERFORMANCE
-- ============================================================================

-- Q1. Total Sales, Total Cost and Total Profit
SELECT SUM(Sales) AS Total_Sales, SUM(Cost) AS Total_Cost,
       SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders;

-- Q2. Average Order Value (AOV)
SELECT SUM(Sales) / COUNT(DISTINCT Order_ID) AS AOV
FROM Ecommerce_Orders;

-- Q3. Total Quantity Sold
SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM Ecommerce_Orders;

-- Q4. Number of Unique Customers
SELECT COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM Ecommerce_Orders;

-- Q5. Total Number of Orders
SELECT COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Ecommerce_Orders;

-- Q6. Overall Profit Margin
SELECT SUM(Profit) / NULLIF(SUM(Sales), 0) * 100 AS Profit_Margin_Percentage
FROM Ecommerce_Orders;


-- ============================================================================
-- 2. TIME ANALYSIS
-- ============================================================================

-- Q7. Total Sales by Year
SELECT YEAR(Order_Date) AS Order_Year, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;

-- Q8. Total Profit by Year
SELECT YEAR(Order_Date) AS Order_Year, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;

-- Q9. Monthly Sales Trend
SELECT YEAR(Order_Date) AS Order_Year, MONTH(Order_Date) AS Order_Month,
       SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;

-- Q10. Month with Highest Sales
SELECT TOP 1 YEAR(Order_Date) AS Order_Year,
       MONTH(Order_Date) AS Order_Month, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Total_Sales DESC;

-- Q11. Month with Highest Profit
SELECT TOP 1 YEAR(Order_Date) AS Order_Year,
       MONTH(Order_Date) AS Order_Month, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Total_Profit DESC;

-- Q12. Compare Sales: 2024 vs 2025
SELECT YEAR(Order_Date) AS Order_Year, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;

-- Q13. Compare Profit: 2024 vs 2025
SELECT YEAR(Order_Date) AS Order_Year, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;


-- ============================================================================
-- 3. PRODUCT ANALYSIS
-- ============================================================================

-- Q14. Sales by Product
SELECT p.Product, SUM(o.Sales) AS Total_Sales
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Total_Sales DESC;

-- Q15. Highest-Sales Product
SELECT TOP 1 p.Product, SUM(o.Sales) AS Total_Sales
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Total_Sales DESC;

-- Q16. Highest-Profit Product
SELECT TOP 1 p.Product, SUM(o.Profit) AS Total_Profit
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Total_Profit DESC;

-- Q17. Highest-Quantity Product
SELECT TOP 1 p.Product, SUM(o.Quantity) AS Total_Quantity_Sold
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Total_Quantity_Sold DESC;

-- Q18. Lowest-Profit Product
SELECT TOP 1 p.Product, SUM(o.Profit) AS Total_Profit
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Total_Profit ASC;

-- Q19. Sales by Category
SELECT p.Category, SUM(o.Sales) AS Total_Sales
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

-- Q20. Profit by Category
SELECT p.Category, SUM(o.Profit) AS Total_Profit
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Profit DESC;

-- Q21. Most Profitable Category
SELECT TOP 1 p.Category, SUM(o.Profit) AS Total_Profit
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Profit DESC;

-- Q22. Sales by Subcategory
SELECT p.Subcategory, SUM(o.Sales) AS Total_Sales
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Subcategory
ORDER BY Total_Sales DESC;


-- ============================================================================
-- 4. CUSTOMER ANALYSIS
-- ============================================================================

-- Q23. Sales by Customer Segment
SELECT c.Customer_Segment, SUM(o.Sales) AS Total_Sales
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Total_Sales DESC;

-- Q24. Profit by Customer Segment
SELECT c.Customer_Segment, SUM(o.Profit) AS Total_Profit
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Total_Profit DESC;

-- Q25. Highest-Sales Customer Segment
SELECT TOP 1 c.Customer_Segment, SUM(o.Sales) AS Total_Sales
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Total_Sales DESC;

-- Q26. Highest-Profit Customer Segment
SELECT TOP 1 c.Customer_Segment, SUM(o.Profit) AS Total_Profit
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Total_Profit DESC;

-- Q27. Customers Spending Above Average Customer Spending
SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY Customer_ID
HAVING SUM(Sales) > (
    SELECT AVG(Customer_Total)
    FROM (
        SELECT Customer_ID, SUM(Sales) AS Customer_Total
        FROM Ecommerce_Orders
        GROUP BY Customer_ID
    ) Customer_Sales
)
ORDER BY Total_Sales DESC;

-- Q28. Top 10 Customers by Sales
SELECT TOP 10 Customer_ID, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY Customer_ID
ORDER BY Total_Sales DESC;

-- Q29. Top 10 Customers by Profit
SELECT TOP 10 Customer_ID, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY Customer_ID
ORDER BY Total_Profit DESC;


-- ============================================================================
-- 5. REGIONAL ANALYSIS
-- ============================================================================

-- Q30. Sales by Region
SELECT Region, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Q31. Profit by Region
SELECT Region, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY Region
ORDER BY Total_Profit DESC;

-- Q32. Highest-Sales Region
SELECT TOP 1 Region, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Q33. Highest-Profit Region
SELECT TOP 1 Region, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY Region
ORDER BY Total_Profit DESC;

-- Q34. Lowest-Profit-Margin Region
SELECT TOP 1 Region,
       SUM(Profit) / NULLIF(SUM(Sales), 0) * 100 AS Profit_Margin
FROM Ecommerce_Orders
GROUP BY Region
ORDER BY Profit_Margin ASC;


-- ============================================================================
-- 6. PAYMENT & DISCOUNT ANALYSIS
-- ============================================================================

-- Q35. Number of Orders by Payment Mode
SELECT Payment_Mode, COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Ecommerce_Orders
GROUP BY Payment_Mode
ORDER BY Total_Orders DESC;

-- Q36. Sales by Payment Mode
SELECT Payment_Mode, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY Payment_Mode
ORDER BY Total_Sales DESC;

-- Q37. Highest-Sales Payment Mode
SELECT TOP 1 Payment_Mode, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY Payment_Mode
ORDER BY Total_Sales DESC;

-- Q38. Average Discount by Product
SELECT p.Product, AVG(o.Discount) AS Average_Discount
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Average_Discount DESC;

-- Q39. Profit: Discounted vs Non-Discounted Orders
SELECT CASE WHEN Discount > 0 THEN 'Discounted'
            ELSE 'Non-Discounted' END AS Discount_Status,
       SUM(Profit) AS Total_Profit,
       AVG(Profit) AS Average_Profit
FROM Ecommerce_Orders
GROUP BY CASE WHEN Discount > 0 THEN 'Discounted'
              ELSE 'Non-Discounted' END;

-- Q40. Discount Level with Highest Sales
SELECT TOP 1 Discount, SUM(Sales) AS Total_Sales
FROM Ecommerce_Orders
GROUP BY Discount
ORDER BY Total_Sales DESC;

-- Q41. Discount Level with Highest Profit
SELECT TOP 1 Discount, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY Discount
ORDER BY Total_Profit DESC;


-- ============================================================================
-- 7. LOSS ANALYSIS
-- ============================================================================

-- Q42. Count of Loss-Making Orders
SELECT COUNT(DISTINCT Order_ID) AS Loss_Making_Orders
FROM Ecommerce_Orders
WHERE Profit < 0;

-- Q43. Total Loss from Loss-Making Orders
SELECT SUM(Profit) AS Total_Loss
FROM Ecommerce_Orders
WHERE Profit < 0;

-- Q44. Products with Loss-Making Orders
SELECT p.Product, COUNT(DISTINCT o.Order_ID) AS Loss_Making_Orders,
       SUM(o.Profit) AS Total_Profit
FROM Ecommerce_Orders o
INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
WHERE o.Profit < 0
GROUP BY p.Product
ORDER BY Loss_Making_Orders DESC;

-- Q45. Region with Most Loss-Making Orders
SELECT TOP 1 Region, COUNT(DISTINCT Order_ID) AS Loss_Making_Orders
FROM Ecommerce_Orders
WHERE Profit < 0
GROUP BY Region
ORDER BY Loss_Making_Orders DESC;

-- Q46. Do Loss-Making Orders Have Higher Discounts?
SELECT CASE WHEN Profit < 0 THEN 'Loss-Making'
            ELSE 'Profitable' END AS Order_Type,
       AVG(Discount) AS Average_Discount
FROM Ecommerce_Orders
GROUP BY CASE WHEN Profit < 0 THEN 'Loss-Making'
              ELSE 'Profitable' END;

-- Q47. Customers with Overall Loss
SELECT Customer_ID, SUM(Profit) AS Total_Profit
FROM Ecommerce_Orders
GROUP BY Customer_ID
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- ============================================================================
-- 8. ADVANCED SQL ANALYSIS
-- ============================================================================

-- Q48. Second-Highest Selling Product
WITH Product_Sales AS (
    SELECT p.Product, SUM(o.Sales) AS Total_Sales
    FROM Ecommerce_Orders o
    INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
    GROUP BY p.Product
),
Ranked_Products AS (
    SELECT Product, Total_Sales,
           DENSE_RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
    FROM Product_Sales
)
SELECT Product, Total_Sales
FROM Ranked_Products
WHERE Sales_Rank = 2;

-- Q49. Top 3 Products in Each Category
WITH Product_Sales AS (
    SELECT p.Category, p.Product, SUM(o.Sales) AS Total_Sales
    FROM Ecommerce_Orders o
    INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
    GROUP BY p.Category, p.Product
),
Ranked_Products AS (
    SELECT Category, Product, Total_Sales,
           ROW_NUMBER() OVER (
               PARTITION BY Category ORDER BY Total_Sales DESC
           ) AS Product_Rank
    FROM Product_Sales
)
SELECT Category, Product, Total_Sales, Product_Rank
FROM Ranked_Products
WHERE Product_Rank <= 3
ORDER BY Category, Product_Rank;

-- Q50. Highest-Selling Product for Each Region
WITH Region_Product_Sales AS (
    SELECT o.Region, p.Product, SUM(o.Sales) AS Total_Sales
    FROM Ecommerce_Orders o
    INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
    GROUP BY o.Region, p.Product
),
Ranked_Products AS (
    SELECT Region, Product, Total_Sales,
           ROW_NUMBER() OVER (
               PARTITION BY Region ORDER BY Total_Sales DESC
           ) AS Product_Rank
    FROM Region_Product_Sales
)
SELECT Region, Product, Total_Sales
FROM Ranked_Products
WHERE Product_Rank = 1;

-- Q51. Customers Above Their Segment's Average Sales
WITH Customer_Sales AS (
    SELECT o.Customer_ID, c.Customer_Segment,
           SUM(o.Sales) AS Total_Sales
    FROM Ecommerce_Orders o
    INNER JOIN Ecommerce_Customers c ON o.Customer_ID = c.Customer_ID
    GROUP BY o.Customer_ID, c.Customer_Segment
),
Segment_Averages AS (
    SELECT Customer_Segment, AVG(Total_Sales) AS Average_Segment_Sales
    FROM Customer_Sales
    GROUP BY Customer_Segment
)
SELECT cs.Customer_ID, cs.Customer_Segment, cs.Total_Sales,
       sa.Average_Segment_Sales
FROM Customer_Sales cs
INNER JOIN Segment_Averages sa
    ON cs.Customer_Segment = sa.Customer_Segment
WHERE cs.Total_Sales > sa.Average_Segment_Sales
ORDER BY cs.Total_Sales DESC;

-- Q52. Products Above Average Product Profit
WITH Product_Profit AS (
    SELECT p.Product, SUM(o.Profit) AS Total_Profit
    FROM Ecommerce_Orders o
    INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
    GROUP BY p.Product
)
SELECT Product, Total_Profit
FROM Product_Profit
WHERE Total_Profit > (SELECT AVG(Total_Profit) FROM Product_Profit)
ORDER BY Total_Profit DESC;

-- Q53. Year-over-Year Sales Growth
WITH Yearly_Sales AS (
    SELECT YEAR(Order_Date) AS Order_Year, SUM(Sales) AS Total_Sales
    FROM Ecommerce_Orders
    GROUP BY YEAR(Order_Date)
)
SELECT Order_Year, Total_Sales,
       LAG(Total_Sales) OVER (ORDER BY Order_Year) AS Previous_Year_Sales,
       (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Order_Year))
       / NULLIF(LAG(Total_Sales) OVER (ORDER BY Order_Year), 0) * 100
       AS YoY_Growth_Percentage
FROM Yearly_Sales
ORDER BY Order_Year;

-- Q54. Running Total Sales by Date
WITH Daily_Sales AS (
    SELECT Order_Date, SUM(Sales) AS Daily_Sales
    FROM Ecommerce_Orders
    GROUP BY Order_Date
)
SELECT Order_Date, Daily_Sales,
       SUM(Daily_Sales) OVER (
           ORDER BY Order_Date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS Running_Total_Sales
FROM Daily_Sales
ORDER BY Order_Date;

-- Q55. Rank Products by Sales Within Each Category
WITH Product_Sales AS (
    SELECT p.Category, p.Product, SUM(o.Sales) AS Total_Sales
    FROM Ecommerce_Orders o
    INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
    GROUP BY p.Category, p.Product
)
SELECT Category, Product, Total_Sales,
       RANK() OVER (
           PARTITION BY Category ORDER BY Total_Sales DESC
       ) AS Sales_Rank
FROM Product_Sales
ORDER BY Category, Sales_Rank;

-- Q56. Highest-Profit Product in Each Category
WITH Product_Profit AS (
    SELECT p.Category, p.Product, SUM(o.Profit) AS Total_Profit
    FROM Ecommerce_Orders o
    INNER JOIN Ecommerce_Products p ON o.Product_ID = p.Product_ID
    GROUP BY p.Category, p.Product
),
Ranked_Products AS (
    SELECT Category, Product, Total_Profit,
           ROW_NUMBER() OVER (
               PARTITION BY Category ORDER BY Total_Profit DESC
           ) AS Profit_Rank
    FROM Product_Profit
)
SELECT Category, Product, Total_Profit
FROM Ranked_Products
WHERE Profit_Rank = 1
ORDER BY Category;

-- Q57. Customers Who Never Placed an Order
SELECT c.Customer_ID, c.Customer_Segment, c.City
FROM Ecommerce_Customers c
LEFT JOIN Ecommerce_Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Customer_ID IS NULL;

-- Q58. Products That Never Appeared in an Order
SELECT p.Product_ID, p.Product, p.Category, p.Subcategory
FROM Ecommerce_Products p
LEFT JOIN Ecommerce_Orders o ON p.Product_ID = o.Product_ID
WHERE o.Product_ID IS NULL;


/* ============================================================================
END OF ANALYSIS
PROJECT FLOW: SQL Server -> Data Model -> DAX -> Power BI -> Insights
============================================================================ */
