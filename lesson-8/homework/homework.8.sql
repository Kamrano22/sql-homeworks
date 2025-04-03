----EASY LEVEL TASKS---------

--TASK-1--

select count(ProductID) as ProductCount,Category
from Products
group by Category;

--TASK-2--

select ProductName,avg(Price) as AveragePrice
from Products 
where Category = 'Electronics'
group by ProductName;

--TASK-3----

SELECT * 
FROM Customers
WHERE City LIKE 'L%';


--TASK-4---

select * from Products
where ProductName like '%er'; 

--TASK-5---

SELECT * FROM CUSTOMERS

select * from Customers
where Country like '%A';

--TASK-6---
SELECT max(Price) as HighestPrice 
from Products;

--TASK-7----

select StockQuantity,
iif(StockQuantity < 30,'Low','Sufficient' ) as StockCount
from Products;

--TASK-8---
SELECT * FROM CUSTOMERS

SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

--TASK-9--

SELECT MIN(ORDERCOUNT) AS MinimumCount,
max(OrderCount) as MaxCount
from Orders;

-----------------------MEDIUM LEVEL TASKS-----

--TASK-10--

SELECT  o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023

EXCEPT

SELECT  i.CustomerID
FROM Invoices i
WHERE YEAR(i.InvoiceDate) = 2023;

--TASK-11----

SELECT ProductName
FROM Products

UNION ALL

SELECT ProductName
FROM Products_Discounted;


--TASK-12---

SELECT DISTINCT ProductName
from Products
union 
select distinct ProductName
from Products_Discounted;

--TASK-13---


select avg(OrderAmount) as OrderAmount,OrderDate
from Orders1
group by OrderDate ;

--TASK-14----
SELECT * FROM Products

SELECT Price,
       CASE 
           WHEN Price > 500 THEN 'High'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           WHEN Price < 100 THEN 'Low'
       END AS PriceCategory
FROM Products;

---TASK-15---

SELECT Distinct City
FROM Customers
GROUP BY City
ORDER BY City ASC;

--TASK-16----
select * from Sales

select ProductID,sum(Price * Quantity) as TotalSales
from Sales
group by ProductID;

--TASK-17----

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

--TASK-18---

SELECT * FROM PRODUCTS
SELECT * FROM PRODUCTS_DISCOUNTED

SELECT ProductID from Products 
intersect
select ProductID from Products_Discounted;

--TASK-19---

SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

--TASK-20---

SELECT Products.ProductID, Products.ProductName
FROM Products
GROUP BY Products.ProductID, Products.ProductName
HAVING Products.ProductID NOT IN (SELECT ProductID FROM Products_Discounted);

--TASK-21---
SELECT * FROM SALES
SELECT * FROM PRODUCTS

SELECT p.ProductName, COUNT(s.SaleID) AS NumberOfSales
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY NumberOfSales DESC;

--TASK-22--

SELECT TOP 5 ProductID, SUM(OrderQuantity) AS TotalOrderQuantity
FROM Orders
GROUP BY ProductID
ORDER BY TotalOrderQuantity desc ;



