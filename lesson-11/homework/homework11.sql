
--TASK1----Basic Inner Join----
SELECT e.Name,d.DepartmentName
from Departments d
inner join Employees e
on d.DepartmentID = e.DepartmentID;
----TASK2----LEFT JOIN-----

select s.StudentName,c.ClassName
from Students s 
left join Classes c 
on s.ClassID = c.ClassID;

----TASK3--------RIGHT JOIN-------

                                                   --all customers and their orders, including customers who haven’t placed any orders.

select c.CustomerID,c.CustomerName,o.OrderID
from Orders o 
Right join Customers c 
on o.CustomerID = c.CustomerID;
--TASK4---------FULL OUTER JOIN----------
SELECT * FROM SALES
SELECT * FROM PRODUCTS                       -- a list of all products and their sales, including products with no sales and sales with invalid product references.


SELECT s.SaleID,p.ProductName,s.ProductID
from Sales s 
full outer join Products p
on s.ProductID = p.ProductID

---TASK5----Self join------
use homework
                                                                   --names of employees along with the names of their managers
SELECT e1.Name AS Employee, e2.Name AS Manager
FROM Employees e1
LEFT JOIN Employees e2
ON e1.ManagerID = e2.EmployeeID;

---TASK6-----CROSS JOIN-------

                                                                  --all possible combinations of colors and sizes
select * from Colors 
cross join Sizes

--TASK7---- 

SELECT m.Title, m.ReleaseYear, a.Name AS ActorName
FROM Movies m
INNER JOIN Actors a 
ON m.MovieID = a.MovieID 
WHERE m.ReleaseYear > 2015;

--TASK8-- MULTIPLE JOINS----
use company_db;

SELECT c.CustomerName, o.OrderDate, d.ProductID
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails d ON o.OrderID = d.OrderID;
---TASK9-------JOIN with Aggregation-----

 use homework

SELECT p.ProductName, SUM(s.Quantity * p.Price) AS Total_Revenue
FROM Products p
INNER JOIN Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductName;


