use TechShop;

-- 1. Write an SQL query to find out which customers have not placed any orders.

SELECT FirstName, LastName, Email
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
    
);

-- 2. SQL query to find the total number of products available for sale:

SELECT COUNT(*) AS TotalProducts
FROM Products;

-- 3. SQL query to calculate the total revenue generated by TechShop:

SELECT SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID;

-- 4. SQL query to calculate the average quantity ordered for products in a specific category:

DECLARE @CategoryName NVARCHAR(255);
SET @CategoryName = 'Haldiram Namkeen';  

SELECT AVG(od.Quantity) AS AverageQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Description LIKE '%' + @CategoryName + '%';

-- 5. SQL query to calculate the total revenue generated by a specific customer:

DECLARE @CustomerID INT;
SET @CustomerID = 3; 

SELECT SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.CustomerID = @CustomerID;

-- 6. SQL query to find the customers who have placed the most orders:

SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY OrderCount DESC;

-- 7. SQL query to find the most popular product category (with the highest total quantity ordered):

SELECT TOP 1 
    CAST(p.Description AS NVARCHAR(MAX)) AS Description, 
    SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY CAST(p.Description AS NVARCHAR(MAX))
ORDER BY TotalQuantityOrdered DESC;

-- 8. SQL query to find the customer who has spent the most money on electronic gadgets:

SELECT TOP 1 c.FirstName, c.LastName, SUM(od.Quantity * p.Price) AS TotalSpending
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Description LIKE '%Dettol Soap%'
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpending DESC;

-- 9. SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers:

SELECT c.FirstName, c.LastName, AVG(o.TotalAmount) AS AverageOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

-- 10. SQL query to find the total number of orders placed by each customer:

SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;













