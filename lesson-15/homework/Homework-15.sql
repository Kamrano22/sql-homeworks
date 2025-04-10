-----------------------EASY LEVEL TASKS---------------------------------------

--employees whose salary is above the average salary. 

--task-1-

SELECT EmployeeID
FROM (
    SELECT EmployeeID, Salary
    FROM Employees
) AS EmployeeStatus
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

--task-2--
--employees who have the same salary as another employee(CTE)

with CTE as (
select Salary
from Employees1
group by Salary 
having count(*) > 1
) 
select EmployeeID,Salary 
from Employees1
where Salary in( select Salary from CTE);

--task-3--

--number of employees in each department.

with cte as (
select d.DepartmentName,count(EmployeeID) as EmployeeCount
from Employees e 
join Departments d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentName) 

select DepartmentName,EmployeeCount
from CTE;


--task-4--

-- employees whose salary is below the average salary. (Derived Table)



SELECT EmployeeID,Salary
FROM (
    SELECT EmployeeID, Salary
    FROM Employees
) AS EmployeeSalary
WHERE Salary < (SELECT AVG(Salary) FROM Employees);
 
 --task-5--
 --List products that have been sold at least twice.

WITH CTE AS (
    SELECT p.ProductName, s.ProductID
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY p.ProductName, s.ProductID
    HAVING COUNT(*) >= 2
)

SELECT c.ProductName, s.SalesID,c.ProductID
FROM Sales s
JOIN CTE c ON s.ProductID = c.ProductID;


--task-6--

--employees who made a single sale of more than $2000. (Derived Table) 



SELECT Employees.EmployeeID,Employees.SalesAmount 
FROM (
    SELECT e.EmployeeID, s.SalesAmount
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, s.SalesAmount
    HAVING COUNT(s.SalesID) = 1
) AS Employees
WHERE Employees.SalesAmount > 2000;

--task-7--
--Retrieve the most expensive product



SELECT ProductName, Price
FROM (
    SELECT TOP 1 ProductName, Price
    FROM Products
    ORDER BY Price DESC
) AS Productstatus;

--task-8--

--total sales made by each employee

select * from Employees
select * from Sales

with cte as (
select e.EmployeeID,sum(s.SalesAmount) as totalSales
from Employees e
join Sales s   on e.EmployeeID = s.EmployeeID
group by e.EmployeeID
) 
select EmployeeID,totalsales
from cte;

--task-9--
--employees who have sold a "Laptop"
select * from Employees
select * from Sales
select *from Products

WITH CTE AS (
    SELECT e.EmployeeID, s.SalesID, p.ProductName
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.EmployeeID
    JOIN Products p ON s.ProductID = p.ProductID
    GROUP BY e.EmployeeID, s.SalesID, p.ProductName
)
SELECT DISTINCT EmployeeID,ProductName
FROM CTE
WHERE ProductName = 'Laptop';

--task-10--

-- highest-paid employee in each department. 

select * from Employees
select * from Departments

SELECT EmployeeID, DepartmentName, HighestSalary
FROM (
    SELECT e.EmployeeID, d.DepartmentName, MAX(e.Salary) AS HighestSalary
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    GROUP BY e.EmployeeID, d.DepartmentName
) AS TopEmployees
WHERE HighestSalary = (
    SELECT MAX(Salary)
    FROM Employees
    WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = TopEmployees.DepartmentName)
);

------------------------------------MEDIUM LEVEL TASK------------------------------------------------
--task-11--
--.Find departments with no employees. 

select * from Employees
select * from Departments

with cte as (
    select d.DepartmentName, d.DepartmentID, count(e.EmployeeID) as EmployeeCount
    from Departments d
    left join Employees e on e.DepartmentID = d.DepartmentID
    group by d.DepartmentName, d.DepartmentID
)
select DepartmentName, DepartmentID
from cte
where EmployeeCount = 0;

--task-12--

--Find employees who have made the same total sales as another employee



with cte as (
    select e.EmployeeID, sum(s.SalesAmount) as TotalSales
    from Employees e
    join Sales s on e.EmployeeID = s.EmployeeID
    group by e.EmployeeID
)
select c1.EmployeeID, c1.TotalSales
from cte c1
join cte c2 on c1.TotalSales = c2.TotalSales
where c1.EmployeeID <> c2.EmployeeID
order by c1.TotalSales;

--task-13--

--Find the total revenue generated per product category.

with cte as (
    select p.CategoryID, sum(s.SalesAmount) as Revenue
    from Products p
    join Sales s on p.ProductID = s.ProductID
    group by p.CategoryID
)
select CategoryID, Revenue
from cte;


--tasl-14--

--top 3 highest-paid employees per department. (Derived Table)


select EmployeeID, DepartmentName, MaxSalary
from (
    select e.EmployeeID, d.DepartmentName, e.Salary as MaxSalary, e.DepartmentID
    from Employees e
    join Departments d on e.DepartmentID = d.DepartmentID
) as Employees
where MaxSalary in (
    select top 3 e.Salary
    from Employees e
    where e.DepartmentID = Employees.DepartmentID
    order by e.Salary desc
)
order by DepartmentName, MaxSalary desc;

--task-15--

--employees who have the highest number of sales transactions. 

select * from Sales1
select * from Employees

SELECT EmployeeID, Transactions
FROM (
    SELECT s.EmployeeID, COUNT(s.TransactionID) AS Transactions
    FROM Sales1 s
    JOIN Employees e ON s.EmployeeID = e.EmployeeID
    GROUP BY s.EmployeeID
) AS TransactionCounts
ORDER BY Transactions DESC;

--task-16--

-- employees who sold more than 3 different products.

WITH cte AS (
    SELECT e.EmployeeID, COUNT(DISTINCT p.ProductID) AS ProductCount
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    JOIN Employees e ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID
)
SELECT EmployeeID, ProductCount
FROM cte
WHERE ProductCount > 3;

--task-17--

--department with the highest total salary

SELECT TOP 1 DepartmentName, HighestSalary
FROM (
    SELECT d.DepartmentName, SUM(e.Salary) AS HighestSalary
    FROM Departments d
    JOIN Employees e ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
) AS Department
ORDER BY HighestSalary DESC;

--task-18--

--employees who made sales higher than their department's average sales. (Derived Table)



SELECT DepartmentName, EmployeeID, Sales
FROM (
    SELECT d.DepartmentName, e.EmployeeID, AVG(s.SalesAmount) AS Sales
    FROM Sales s
    JOIN Employees e ON e.EmployeeID = s.EmployeeID
    JOIN Departments d ON d.DepartmentID = e.DepartmentID
    GROUP BY d.DepartmentName, e.EmployeeID
) AS EmployeeSales
WHERE Sales > (
    SELECT AVG(salesAmount)
    FROM Sales s
    JOIN Employees e ON e.EmployeeID = s.EmployeeID
    JOIN Departments d ON d.DepartmentID = e.DepartmentID
    WHERE d.DepartmentName = EmployeeSales.DepartmentName
);


-----------------------------------------DIFFICULT LEVEL TASKS-----------------------------

-- employees whose total sales exceed their own salary.
--task-19--


SELECT e.EmployeeID, e.Salary, TotalSales.Sales
FROM Employees e
JOIN (
    SELECT s.EmployeeID, SUM(s.SalesAmount) AS Sales
    FROM Sales s
    GROUP BY s.EmployeeID
) AS TotalSales ON e.EmployeeID = TotalSales.EmployeeID
WHERE TotalSales.Sales > e.Salary;

--task-20--

--department with the most sales transactions


select top 1  DepartmentName,TransactionCount from (

select d.DepartmentName,count(s.TransactionID) as TransactionCount
from Departments d 
join Sales2 s on s.DepartmentID = d.DepartmentID 
group by d.DepartmentName
) as DepartmentTransaction

--task-21--


--top-selling employee for each product. 

select * from Employees
select * from Products
select * from Sales

SELECT e.EmployeeID, d.DepartmentName, MAX(SalesAmount) AS HighestSales
FROM (
    SELECT e.EmployeeID, s.SalesID, p.ProductID, SUM(s.SalesAmount) AS SalesAmount
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    JOIN Employees e ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, s.SalesID, p.ProductID
) AS EmployeeRecords
JOIN Employees e ON e.EmployeeID = EmployeeRecords.EmployeeID
JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY e.EmployeeID, d.DepartmentName;