## Query-1 Rank products by unit price (ROW_NUMNER)
SELECT
    ProductID,
    ProductName,
    UnitPrice,
    ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS Price_Row_Number
FROM Products;
## Note: Gives every product a unique sequential number
## Query-2 Rank products by unit price(RANK)
SELECT
    ProductID,
    ProductName,
    UnitPrice,
    RANK() OVER (ORDER BY UnitPrice DESC) AS Price_Rank
FROM Products;
## Note: products with the same price receive the same rank, and gap can occur. 
## Query-3 Compare ROW_NUMBER and RANK
SELECT
    ProductID,
    ProductName,
    UnitPrice,
    ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS Row_Number_Rank,
    RANK() OVER (ORDER BY UnitPrice DESC) AS Product_Rank
FROM Products;
## note: This directly shows the difference between the two ranking functions.
## Query-4 Rank products within each catgeory
SELECT
    CategoryID,
    ProductID,
    ProductName,
    UnitPrice,
    RANK() OVER (
        PARTITION BY CategoryID
        ORDER BY UnitPrice DESC
    ) AS Category_Rank
FROM Products;
## Note: Ranking restarts for each category
## Query-5 Number products within each category
SELECT
    CategoryID,
    ProductID,
    ProductName,
    UnitPrice,
    ROW_NUMBER() OVER (
        PARTITION BY CategoryID
        ORDER BY UnitPrice DESC
    ) AS Product_Number
FROM Products;
## note: Each category gets its own sequential numbering.
## Query-6 Find the top 3 products in each category
WITH RankedProducts AS (
    SELECT
        CategoryID,
        ProductID,
        ProductName,
        UnitPrice,
        RANK() OVER (
            PARTITION BY CategoryID
            ORDER BY UnitPrice DESC
        ) AS Product_Rank
    FROM Products
)
SELECT *
FROM RankedProducts
WHERE Product_Rank <= 3;
## note: Identifies the three highest-priced products in each category.
## Query-7 Rank employees by number of orders
SELECT
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    COUNT(o.OrderID) AS Total_Orders,
    RANK() OVER (
        ORDER BY COUNT(o.OrderID) DESC
    ) AS Order_Rank
FROM Employee e
LEFT JOIN Orders o
    ON e.EmployeeID = o.EmployeeID
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName;
    ## note: Shows which employess handled the most orders.
    ## Query-8 Rank customers by number of orders
    SELECT
    c.CustomerID,
    c.CompanyName,
    COUNT(o.OrderID) AS Total_Orders,
    RANK() OVER (
        ORDER BY COUNT(o.OrderID) DESC
    ) AS Customer_Rank
FROM categories c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CompanyName;
    ## note: Identifies the most active customers.
    ## Query-9 Monthky order count
    SELECT
    YEAR(OrderDate) AS Order_Year,
    MONTH(OrderDate) AS Order_Month,
    COUNT(OrderID) AS Total_Orders
FROM Orders
GROUP BY
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY
    Order_Year,
    Order_Month;
    ## note: Creates the monthly order trend that will be used with LAG().
    ## Query-10 Compare monthly orders with previous month
    WITH MonthlyOrders AS (
    SELECT
        YEAR(OrderDate) AS Order_Year,
        MONTH(OrderDate) AS Order_Month,
        COUNT(OrderID) AS Total_Orders
    FROM Orders
    GROUP BY
        YEAR(OrderDate),
        MONTH(OrderDate)
)
SELECT
    Order_Year,
    Order_Month,
    Total_Orders,
    LAG(Total_Orders) OVER (
        ORDER BY Order_Year, Order_Month
    ) AS Previous_Month_Orders
FROM MonthlyOrders
ORDER BY
    Order_Year,
    Order_Month;
    ## note: LAG() retrieves the previous month's order count.
    ## Query-11 Calculate month-over -month change
    WITH MonthlyOrders AS (
    SELECT
        YEAR(OrderDate) AS Order_Year,
        MONTH(OrderDate) AS Order_Month,
        COUNT(OrderID) AS Total_Orders
    FROM Orders
    GROUP BY
        YEAR(OrderDate),
        MONTH(OrderDate)
),
OrderTrend AS (
    SELECT
        Order_Year,
        Order_Month,
        Total_Orders,
        LAG(Total_Orders) OVER (
            ORDER BY Order_Year, Order_Month
        ) AS Previous_Month_Orders
    FROM MonthlyOrders
)
SELECT
    Order_Year,
    Order_Month,
    Total_Orders,
    Previous_Month_Orders,
    Total_Orders - Previous_Month_Orders AS Month_Over_Month_Change
FROM OrderTrend
ORDER BY
    Order_Year,
    Order_Month;
    ## note: Shows whether orders increased or decreased compared with previous month.
    ## Query-12 Compare each employee's orders with the previous employee.
    WITH EmployeeOrders AS (
    SELECT
        e.EmployeeID,
        CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
        COUNT(o.OrderID) AS Total_Orders
    FROM Employee e
    LEFT JOIN Orders o
        ON e.EmployeeID = o.EmployeeID
    GROUP BY
        e.EmployeeID,
        e.FirstName,
        e.LastName
)
SELECT
    EmployeeID,
    EmployeeName,
    Total_Orders,
    LAG(Total_Orders) OVER (
        ORDER BY Total_Orders DESC
    ) AS Previous_Employee_Orders
FROM EmployeeOrders
ORDER BY Total_Orders DESC;
## note: Uses LAG() to compare an employee's order count with the employee immediately above them in a ranking.