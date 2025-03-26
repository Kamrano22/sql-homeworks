-- EASY LEVEL TASKS --------
--task1----------------------
select * from Customers c
inner join Orders o 
on c.CustomerID = o.CustomerID and o.OrderDate > '2023-01-15';
--task2------------------------------------
SELECT e.EmployeeID, e.Name,d.DepartmentName
FROM Employees e
JOIN Departments d
ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');
--task3-----------------------------------
select p.* ,o.*
from(select * from Products  where Price >100) as p
join Orders o
on p.ProductID = o.ProductID
where p.Price > 100;
--task4----------------------------------------

select * from Temp_Orders t
 inner join Orders o
on t.OrderID = o.OrderID
--task5-------------------------------

select d.DepartmentName,s.SaleID,s.Amount,s.SalesPerson
from Departments d
cross apply 
( 
select top 5 *
from Sales s
where s.DepartmentID = d.DepartmentID
Order by s.Amount  desc
) as s;
--task6------------------------
select * from Customers c
inner join Orders o 
on c.CustomerID = o.CustomerID
where year (o.OrderDate )= '2023' and c.LoyaltyStatus = 'Gold';
--task7-------------------------------------------------
select c.CustomerName,c.CustomerID,o.Quantity as OrderCount
from Customers c
left join (SELECT CustomerID, COUNT(*) as Quantity FROM Orders GROUP BY CustomerID) o 
on c.CustomerID = o.CustomerID;
--task8---------------------
select p.Name,s.SupplierName
from Products p
inner join Suppliers s  on p.ProductID = s.ProductID
where s.SupplierName in ('Supplier A','Supplier B')
--task9--------------------
use L10

SELECT e.EmployeeName, e.Position, o.RecentOrderDate
FROM Employees e
OUTER APPLY 
(
    SELECT MAX(OrderDate) AS RecentOrderDate
    FROM Orders 
    WHERE e.EmployeeID = Orders.EmployeeID  --  Correct Reference
) o;
--task10--------------------------------
use L9

SELECT d.DepartmentID, d.DepartmentName, e.EmployeeID, e.EmployeeName, e.Position
FROM Departments d
CROSS APPLY GetEmployeesByDepartment(d.DepartmentID) e;

--------MEDIUM LEVEL TASKS---------------------
--task11----
select c.CustomerName,c.ContactNumber,c.Email,o.OrderAmount
from Customers c
inner join Orders o on c.CustomerID = o.CustomerID and o.OrderAmount >5000;
---task12------
SELECT p.ProductName, p.DiscountRate, s.TotalAmount
FROM Products p
INNER JOIN Sales s 
    ON p.ProductID = s.ProductID  -- Correct join condition
WHERE YEAR(s.SaleDate) = 2022 OR p.DiscountRate > 0.20;
---task13---
SELECT p.ProductName, p.Price, s.TotalSales
FROM Products p
JOIN (SELECT ProductID, SUM(TotalAmount) AS TotalSales FROM Sales GROUP BY ProductID) AS s
ON p.ProductID = s.ProductID;
--task14----------------------------
use company_db

select tp.ProductName,p.ProductName,p.Price
from Temp_Products tp
left join Products p on tp.ProductID = p.ProductID
--task15------

SELECT e.EmployeeID, e.EmployeeName, e.Position, s.SaleID, s.SaleAmount, s.SaleDate
FROM Employees e
CROSS APPLY GetEmployeeSales(e.EmployeeID) s;

--task16----
use L9

select e.EmployeeName,e.Salary,d.DepartmentName
from Employees e
inner join Departments d
on e.DepartmentID = d.DepartmentID and d.DepartmentName = 'HR' and e.Salary > 5000;

--task17-----
select p.PaymentStatus,p.PaidAmount,o.OrderID
from Orders o 
left join Payments p on o.OrderID = p.OrderID ;

--task18---------------------------

select * from Customers
select * from Orders 

SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderAmount, o.OrderDate
FROM Customers c
OUTER APPLY 
(
    SELECT TOP 1 o.OrderID, o.OrderAmount, o.OrderDate 
    FROM Orders o
    WHERE c.CustomerID = o.CustomerID
    ORDER BY o.OrderDate DESC
) o;
--task19---------------------------------------
use homework
 select * from Products 
 select * from Sales

 select p.ProductName,p.Rating,p.Price,s.SaleDate,s.Quantity,s.TotalAmount
 from Products p 
 inner join Sales s
 on p.ProductID = s.ProductID and  Year(s.SaleDate)=2023 and p.Rating > 4.0
 --task20---------------

SELECT d.DepartmentName, e.Position, e.EmployeeName
FROM Employees e
INNER JOIN Departments d 
ON d.DepartmentID = e.DepartmentID 
   OR d.DepartmentName = 'Sales'
WHERE e.Position LIKE '%Manager%'; 

--HARD LEVEL TASKS------------------------------------
--TASK21--------------------
use exams_db

select * from Customers 
select * from Orders

SELECT 
    c.city, 
    SUM(o.order_amount) AS total_order_amount, 
    c.customer_id, 
    COUNT(o.order_id) AS order_count
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id 
WHERE c.city = 'New York'
GROUP BY c.city, c.customer_id
HAVING COUNT(o.order_id) > 10;
--task22-----
use L9

SELECT 
    p.ProductName, 
    p.Category, 
    p.DiscountRate, 
    s.Quantity
FROM Products p
INNER JOIN Sales s 
    ON p.ProductID = s.ProductID
WHERE p.Category = 'Electronics' OR p.DiscountRate > 0.15;

--task23-----
use exams_db

SELECT 
    c.CategoryID, 
    c.CategoryName, 
    p.ProductCount
FROM Categories c
JOIN (
    SELECT CategoryID, COUNT(*) AS ProductCount
    FROM Products
    GROUP BY CategoryID
) p ON c.CategoryID = p.CategoryID;
--task24----
 select * from Temp_Employees
 select * from Employees

SELECT 
    te.Status, 
    e.Salary, 
    e.Department
FROM Temp_Employees te
INNER JOIN Employees e 
    ON te.EmployeeID = e.EmployeeID 
    AND e.Salary > 4000 
    AND e.Department = 'IT'
	---task25-----
	select * from Departments


CREATE FUNCTION dbo.fn_GetEmployeeCount(@DepartmentID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT COUNT(*) AS EmployeeCount
    FROM Employees
    WHERE DepartmentID = @DepartmentID
);
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    e.EmployeeCount
FROM Departments d
CROSS APPLY dbo.fn_GetEmployeeCount(d.DepartmentID) e;

--task26-----
select * from Customers 
select * from Orders

SELECT o.order_id, c.name, c.state
FROM Customers c 
INNER JOIN Orders o 
    ON c.customer_id = o.customer_id 
    AND c.state = 'CA' 
    AND o.order_amount > 100;
	--task27----
	use L9
	select * from Employees
	select * from Departments

SELECT e.EmployeeID, e.EmployeeName, e.Position, d.DepartmentName
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentId = d.DepartmentID
WHERE d.DepartmentName IN ('HR', 'Finance') 
   OR e.Position = 'Executive';
   --task28----

   select * from Customers

CREATE FUNCTION dbo.fn_GetCustomerOrders (@CustomerID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT OrderID
    FROM Orders
    WHERE CustomerID = @CustomerID
);

SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM Customers c
OUTER APPLY dbo.fn_GetCustomerOrders(c.CustomerID) o;

--task29---

select * from sales
select * from Products

select s.SaleID,p.ProductName,p.Price,s.Quantity
from Sales s
inner join Products p
on s.ProductID = p.ProductID 
where s.Quantity > 100 and p.Price > 50;

--task30----
select e.EmployeeID,e.EmployeeName,e.Salary,d.DepartmentName
from Employees e
inner join Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales','Marketing') and e.Salary > 6000;