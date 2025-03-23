 ----easy level tasks-----------
 --task1---
 SELECT employeeId, employee_name, employee_salary, department_name
FROM Employees 
INNER JOIN Departments 
ON employees.department_id = departments.department_id
WHERE employee_salary > 5000;
--task2--
SELECT o.OrderID, o.CustomerID, o.OrderDate, c.CustomerName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2023;

--task3---
select e.employee_name,e.department_id,e.employee_salary,d.department_name 
from Employees e
left outer join Departments d
on e.department_id = d.department_id;

---task4---
select p.ProductId,p.ProductName,p.Price,s.SupplierName
from Products p
right outer join Suppliers s
on p.SupplierID = s.SupplierID

---task5---
select o.OrderID,o.CustomerID,o.OrderDate,o.Quantity,p.PaymentMethod
from orders o
full outer join Payments p
on o.OrderId = p.OrderId
---task6-----
SELECT 
    e.EmployeeID, 
    e.EmployeeName AS Employee, 
    e.Position, 
    m.EmployeeName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

----task7----
SELECT 
    p.ProductID,
    p.ProductName,
    s.SaleID,
    s.SaleAmount  -- ✅ Corrected column name
FROM Products p
JOIN Sales s  
ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 100

---task8---
SELECT 
    c.CourseID,
    c.CourseName,
    s.StudentID,
    s.StudentName
FROM Courses c
INNER JOIN Students s
ON c.CourseID = s.CourseID
WHERE c.CourseName = 'Math';
--task9---
SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.ProductID, 
    o.OrderDate
FROM Customers c
INNER JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;
--task10--
select * from Employees
select * from Departments

SELECT 
    e.EmployeeID, 
    e.EmployeeName, 
    e.JobTitle, 
    e.Salary, 
    d.department_name
FROM Employees e
INNER JOIN Departments d 
ON e.department_id = d.department_id
WHERE d.department_name = 'HR';
------Medium Level tasks------
--task11---
 use exams_db

 SELECT e.EmployeeID, e.EmployeeName, e.JobTitle, e.Salary, e.DepartmentID, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.DepartmentID IN (
    SELECT DepartmentID
    FROM Employees
    GROUP BY DepartmentID
    HAVING COUNT(EmployeeID) > 10
);
--task12--

SELECT 
    p.ProductName,
    p.SupplierID,
	s.SaleAmount,
    p.Price
FROM Products p
LEFT OUTER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleAmount = 0; 

SELECT * FROM Sales;
---task13----

select 
c.CustomerName,
c.Country,
o.OrderDate,
o.Quantity,
o.OrderID
from Customers c 
right outer join Orders o  on c.CustomerID = o.CustomerID
where o.Quantity >= 1;

--task14--
use lesson1
select * from employees
select * from departments

SELECT 
    d.DepartmentID,
    d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d  
ON e.DepartmentID = d.DepartmentID
WHERE e.EmployeeID IS NULL;
---task15---
use homework
select * from Employees

SELECT 
    e1.EmployeeID AS Employee1_ID,
    e1.EmployeeName AS Employee1_Name,
    e2.EmployeeID AS Employee2_ID,
    e2.EmployeeName AS Employee2_Name,
    e1.ManagerID
FROM Employees e1
JOIN Employees e2 
ON e1.ManagerID = e2.ManagerID 
AND e1.EmployeeID <> e2.EmployeeID 
ORDER BY e1.ManagerID, e1.EmployeeID;

--task16----

use L8
SELECT 
    o.OrderID,
    o.ProductID,
    o.OrderDate,
    o.Quantity,
    c.CustomerName,
    c.Country
FROM Customers c 
LEFT OUTER JOIN Orders o  
ON o.CustomerID = c.CustomerID 
AND YEAR(o.OrderDate) = 2022;

select * from Orders
select * from  Customers

---task17---
select * from  information_schema.tables;
select 
e.EmployeeID,
e.EmployeeName,
e.JobTitle,
e.Salary
from Employees e
inner join Departments d on e.department_id = d.department_id
where e.Salary > 5000;


select * from Employees
select * from Departments

--task18---
select 
e.EmployeeID,
e.EmployeeName,
e.JobTitle,
d.department_name,
e.Salary
from Employees e 
inner join Departments d  on  e.department_id = d.department_id
where d.department_name = 'IT'
--task19--

SELECT 
    p.PaymentId,
    p.PaymentDate,
    p.PaymentMethod,
    p.Amount,
    o.CustomerID,
    o.Quantity
FROM Payments p
FULL OUTER JOIN Orders o ON p.OrderId = o.OrderID
WHERE p.OrderId IS NOT NULL
--task20--

select * from Products1
select * from Orders

SELECT p.*
FROM Products p
LEFT OUTER JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;
---------------------------------------------Hard Level tasks----------------------
--task21--

select * from Employees
select * from Departments

SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.JobTitle,
    e.Salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id  -- Correct JOIN condition
WHERE e.Salary > (
    SELECT AVG(e2.Salary)  
    FROM Employees e2  
    WHERE e2.department_id = e.department_id  -- Corrected reference
);

--task22--
use homework
select * from Payments
select * from Orders

SELECT o.OrderID, o.CustomerID, o.OrderDate, o.TotalAmount
FROM Orders o
LEFT OUTER JOIN Payments p ON o.OrderID = p.OrderID
WHERE o.OrderDate < '2020-01-01' 
AND p.PaymentID IS NULL;
--task23---
use L8

select * from Orders
cross join  Products
where Orders.Quantity > 100;
--task 24----
use portfolio

select * from Employees
select * from Departments

select 
e.emp_name,
e.hire_date
from Employees e
join Departments d on e.department_id = d.department_id  AND DATEDIFF(YEAR, e.hire_date, GETDATE()) > 5;
--task25--
use CompanyDB

SELECT e.employee_id, e.emp_name, e.hire_date, d.dept_name, e.salary
FROM Employees e
INNER JOIN Departments d								-- this table returns values when they have their department name
ON e.department_id = d.department_id;

SELECT e.employee_id, e.emp_name, e.hire_date, d.dept_name, e.salary
FROM Employees e
LEFT JOIN Departments d 
ON e.department_id = d.department_id;                -- This table will return employees even without departments

--task26---
use CompanyDB

select * from Products
cross join Suppliers
where Products.category = 'Category A';

--task27---

select * from Orders
select * from Customers

SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 10;

--task28---
select * from Courses
select* from Students

SELECT c.course_id, c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollment e ON c.course_id = e.course_id  -- Make sure Enrollment table exists
GROUP BY c.course_id, c.course_name
ORDER BY student_count DESC;
--task29---
use portfolio;
select
e.emp_name,
e.employee_id,
d.dept_name
from Employees e
left join Departments d on e.department_id = d.department_id
where d.dept_name = 'Marketing';

--task30---
use CompanyDB
select * from information_schema.tables
select * from Employees
select * from Departments

select 
e.emp_name,
e.salary,
e.employee_id
from Departments d 
inner join Employees e on e.department_id = d.department_id      --- in this task i showed employees with salary small or equal to 60000;
where e.salary <= 60000;


select * from Employees
select * from Departments
