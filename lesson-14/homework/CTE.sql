select * from sales
select * from Employees

-------EASY LEVEL TASKS----------------
--TASK-1--
SELECT * 
FROM (
    SELECT 
        SUM(s.SalesAmount) AS TotalSales,
        e.FirstName
    FROM Sales s
    JOIN Employees e ON s.SalesID = e.EmployeeID
    GROUP BY e.FirstName
) AS table1;

--TASK-2--

WITH EmployeesCTE AS (
    SELECT 
        EmployeeID,
        AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY EmployeeID
)

SELECT * 
FROM EmployeesCTE;

--TASK-3--

SELECT * 
FROM (
    SELECT 
        p.ProductName, 
        MAX(s.SalesAmount) AS MaxSales
    FROM Products p 
    JOIN Sales s 
        ON p.ProductID = s.ProductID
    GROUP BY p.ProductName
) AS ProductMaxSales;

--TASK-4--

--Use a CTE to get the names of employees who have made more than 5 sales.

WITH EmployeesCTE AS (
    SELECT e.FirstName, COUNT(s.SalesID) AS TotalSales
    FROM Employees1 e
    JOIN Sales1 s
        ON e.EmployeeID = s.EmployeeID
    GROUP BY e.FirstName
    HAVING COUNT(s.SalesID) >= 5
)
SELECT * FROM EmployeesCTE;
--TASK-5--
-- top 5 customers by salesamount

select * from (
SELECT TOP 5 c.CustomerName, SUM(s.SalesAmount) AS TotalSales
FROM Sales s
JOIN Customers c 
    ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalSales DESC
) as table1;

--TASK-6--

--products with sales greater than 500 

WITH SalesCTE AS (
    SELECT p.ProductName, SUM(s.SalesAmount) AS TotalSales
    FROM Products p
    JOIN Sales2 s
        ON p.ProductID = s.ProductID
    GROUP BY p.ProductName
    HAVING SUM(s.SalesAmount) > 500
)
SELECT * 
FROM SalesCTE
ORDER BY TotalSales DESC; 

--TASK-7--



-- total numbers of order per customer

select * from (
select c.CustomerName,count(o.OrderID) as OrderCount
from Customers c
join Orders o
on c.CustomerID = o.CustomerID
group by c.CustomerName
) as Sales;

--TASK-8--
-- employees whose salaries are higher than average salary

WITH AverageSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT e.FirstName, e.Salary
FROM Employees e
JOIN AverageSalaryCTE a
ON e.Salary > a.AvgSalary;

--TASK-9--

--TOTAL NUMBER OF products sold


SELECT SUM(ProductCount) AS TotalProductsSold
FROM (
    SELECT COUNT(s.ProductID) AS ProductCount
    FROM Sales2 s
    GROUP BY s.ProductID
) AS SoldProducts;

--TASK-10--
--Employees with no sales

WITH EmployeeCTE AS (
    SELECT e.EmployeeID, e.FirstName
    FROM Employees e
    LEFT JOIN Sales1 s ON e.EmployeeID = s.EmployeeID
    WHERE s.SalesID IS NULL
)
SELECT * FROM EmployeeCTE;

--TASK-11--

SELECT * FROM (
SELECT r.RegionName, SUM(s.SalesAmount) AS TotalRevenue
FROM Regions r
JOIN Sales3 s ON r.RegionID = s.RegionID
GROUP BY r.RegionName
) AS RegionRevenue

--TASK-12--
select * from Employees1

WITH EmployeeCTE AS (
    SELECT FirstName, HireDate
    FROM Employees1
    WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5
)
SELECT * FROM EmployeeCTE;

--TASK-13--

SELECT * 
FROM (
    SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
    FROM Customers c
    JOIN Orders o 
    ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
) AS OrderCountSubquery
WHERE OrderCount > 5

--TASK-14--

WITH SalaryCTE AS (
    SELECT e.FirstName, SUM(s.SalesAmount) AS HighestSales, d.DepartmentName
    FROM Sales1 s
    JOIN Employees e ON s.EmployeeID = e.EmployeeID
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    GROUP BY e.FirstName, d.DepartmentName
)

SELECT * 
FROM SalaryCTE
WHERE DepartmentName = 'Sales'  -- Replace 'SpecificDepartment' with the desired department name
ORDER BY HighestSales DESC;

--TASK-15--



SELECT * 
FROM (
    SELECT c.CustomerName, AVG(o.OrderAmount) AS AverageOrderAmount
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
) AS OrderAmount;

--TASK-16--

WITH Departmentcte AS (
    SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
)

SELECT * 
FROM Departmentcte;

--TASK-17--
select * from OrderItems
select * from Products

SELECT p.ProductID, p.ProductName, dt.TotalSales
FROM (
    SELECT oi.ProductID, SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
    FROM Orders o
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    WHERE o.OrderDate BETWEEN DATEADD(QUARTER, -1, GETDATE()) AND GETDATE()
    GROUP BY oi.ProductID
) AS dt
JOIN Products p ON dt.ProductID = p.ProductID  -- Join the Products table in the outer query
ORDER BY dt.TotalSales DESC;


--TASK-18--



WITH EmployeesCTE AS (
    SELECT FirstName, LastName, Salary
    FROM Employees
)
SELECT * 
FROM EmployeesCTE
WHERE Salary > 1000;

--TASK-19-

SELECT * 
FROM (
    SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
) AS OrderCount;


--TASK-20--
select * from Orders2
select * from Employees
select * from OrderItems


WITH SalesCTE AS (
    SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
    FROM Employees e
    JOIN Orders2 o ON e.EmployeeID = o.EmployeeID
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    WHERE o.OrderDate >= DATEADD(MONTH, -1, GETDATE())  -- Last month
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
SELECT * 
FROM SalesCTE;

-----MEDIUM LEVEL TASKS----------------

--TASK-2--
with numbers as (
select 1 as n
UNION ALL
SELECT n+1 as n
FROM numbers
where n<10
)
Select * from numbers;

--TASK-3--

--average sales per region

SELECT * 
FROM (
    SELECT r.RegionName, AVG(s.SalesAmount) AS AverageSales
    FROM Regions1 r
    JOIN Sales3 s
    ON r.RegionID = s.RegionID
    GROUP BY r.RegionName
) AS RegionAverage;

--TASK-4--
select * from Employees
select * from Sales1

WITH RankCte AS (
    SELECT 
        EmployeeID,
        SalesAmount,
        CASE 
            WHEN SalesAmount > 2500 THEN 'Top'
            WHEN SalesAmount BETWEEN 2000 AND 2500 THEN 'Middle'
            WHEN SalesAmount < 2000 THEN 'Low'
        END AS Status
    FROM Sales1
)
SELECT * 
FROM RankCte;

--TASK-5--

--top 5 employees by the number of orders

SELECT TOP 5 *
FROM (
    SELECT e.EmployeeID, e.FirstName, COUNT(o.OrderID) AS OrderCount
    FROM Employees e
    JOIN Orders2 o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName
) AS EmployeeOrderCount
ORDER BY OrderCount DESC; 

--TASK-8--
select * from Sales1
select * from Employees

--Create a derived table to find the employees who have made the highest sales in each department.

select * from (
select e.FirstName,e.LastName,max(s.SalesAmount) as HighestSales
from Sales1 s
join Employees e 
on s.EmployeeID= e.EmployeeID
group by e.FirstName,e.LastName,e.DepartmentID
) as DepartmentSale;

--TASK-9--


--TASK-10--

--Use a CTE to find employees who have not sold anything in the last year.
WITH cte AS (
    -- Calculate the total sales per employee
    SELECT 
        e.EmployeeID,
        SUM(s.SalesAmount) AS TotalSales
    FROM Employees e
    LEFT JOIN Sales1 s ON s.EmployeeID = e.EmployeeID
    WHERE s.SalesAmount IS NOT NULL
    GROUP BY e.EmployeeID
)
-- Select employees who have not sold anything in the last year
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees e
LEFT JOIN cte c ON e.EmployeeID = c.EmployeeID
LEFT JOIN Sales1 s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING (c.TotalSales IS NULL)  -- No sales at all
   OR (DATEDIFF(YEAR, MAX(s.SaleDate), GETDATE()) >= 1);  

   select * from Sales1

   --TASK-11--
   select * from Sales1
   select * from Regions2
   --Write a query using a derived table to calculate the total sales per region and year.

SELECT * 
FROM (
    SELECT 
        r.RegionName, 
        YEAR(s.SaleDate) AS SalesYear,
        SUM(s.SalesAmount) AS TotalSales
    FROM Sales1 s
    JOIN Regions2 r ON s.RegionID = r.RegionID
    GROUP BY r.RegionName, YEAR(s.SaleDate)
) AS Sales;

--TASK-12--

WITH Factorial AS (
    -- Base case: factorial of 1 is 1
    SELECT 1 AS n, 1 AS fact
    
    UNION ALL
    
    -- Recursive case: multiply the current n by the factorial of (n-1)
    SELECT n + 1, fact * (n + 1)
    FROM Factorial
    WHERE n < 5  -- Stop recursion at 5
)
-- Select the factorial of 5
SELECT fact
FROM Factorial
WHERE n = 5;

--task-13--
select * from Customers
select * from Orders
--Write a query using a derived table to find customers with more than 10 orders.

SELECT * 
FROM (
    SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
    FROM Customers c
    JOIN Orders o 
    ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
) AS table2
WHERE table2.OrderCount > 10;


--task-15--
--Use a CTE to rank products based on total sales in the last year.


WITH cte AS (
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales,
        CASE
            WHEN SUM(SalesAmount) > 2500 THEN 'Top'
            WHEN SUM(SalesAmount) BETWEEN 2000 AND 2500 THEN 'Middle'
            WHEN SUM(SalesAmount) < 2000 THEN 'Low'
        END AS Ranks
    FROM Sales
    WHERE SalesDate >= DATEADD(YEAR, -1, GETDATE())  -- Filter sales for the last year
    GROUP BY ProductID
)
SELECT * 
FROM cte;

--task-16--
select * from Sales2
select * from Products2

--Write a query using a derived table to find the sales per product category.

select * from (
select p.Category,sum(s.SalesAmount) as TotalSales
from Sales2 s
join Products2 p 
on s.ProductID = p.ProductID
group by p.Category
) as Category;

--task-17--

--Use a CTE to find the employees who achieved the highest sales growth compared to last year.

select * from Employees1
select * from Sales1

with cte as (
select e.EmployeeID,max(s.SalesAmount) as highestSales
from Employees1 e 
join Sales1 s
on e.EmployeeID = s.EmployeeID
group by e.EmployeeID
) 
select * from cte 
where datediff(year,getdate,-1)
