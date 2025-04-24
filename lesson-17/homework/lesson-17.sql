--Easy Tasks

--1.Write a simple subquery to list all items in the Items table where the price is greater than the average price of all items.



SELECT ProductName, Price
FROM Items
WHERE Price > (SELECT AVG(Price) FROM Items);    -- this query shows product names which have Price > than average Price of products


--2.Create a query using an independent subquery to find staff members who have worked in a division that employs more than 10 people.



SELECT Fullname
FROM staff
WHERE division IN (
    SELECT division                                       --this table did not show any values because there were no employees who have worked in adivsion where there are 10 people
    FROM staff
    GROUP BY division
    HAVING COUNT(*) > 10
);

--3.Write a query that uses a correlated subquery to list all staff members whose salary exceeds the average salary in their respective division.




SELECT FullName, Salary, Division
FROM Staff s
WHERE Salary > (
    SELECT AVG(Salary)                                        --here are  employees whose salaries are greater than average salary of all employees
    FROM Staff
    WHERE Division = s.Division
); 



--4.Use a subquery to find all clients who have made a purchase in the Purchases table.



SELECT FullName, PurchaseID
FROM (
    SELECT p.PurchaseID, p.ClientID, c.FullName
    FROM Purchases p
    JOIN Clients c ON p.ClientID = c.ClientID
) AS sub;


--5.write a query that uses the EXISTS operator to retrieve all purchases that include at least one detail in the PurchaseDetails table.






SELECT p.PurchaseID, p.ClientID
FROM Purchases p
WHERE EXISTS (
    SELECT 1
    FROM PurchaseDetail pd                           
    WHERE pd.PurchaseID = p.PurchaseID
);

--6.create a subquery to list all items that have been sold more than 100 times according to the PurchaseDetails table.


	SELECT Product
FROM (
    SELECT Product, SUM(Quantity) AS TotalSold
    FROM PurchaseDetail
    GROUP BY Product
) AS ProductSales
WHERE TotalSold > 100;


--7.Use a subquery to list all staff members who earn more than the overall company’s average salary.

select * from Staff

select Fullname,StaffID,Salary
from Staff 
where Salary > (select avg(Salary) as AverageSalary from Staff);


--8.Write a subquery to find all vendors that supply items with a price below $50.

select * from Vendors
select * from Products

SELECT v.VendorName, p.ProductName, p.Price
FROM Products p
JOIN Vendors v ON v.VendorID = p.VendorID
WHERE p.Price IN (
    SELECT Price FROM Products WHERE Price < 50
);


--9.Use a subquery to determine the maximum item price in the Items table.




select ProductName,Price
from Items 
where Price = (select max(Price) from Items);

--10.Write a query using an independent subquery to find the highest total purchase value in the Purchases table.




SELECT PurchaseID, Product, Amount
FROM Purchases
WHERE Amount = (
    SELECT MAX(Amount) FROM Purchases
);

--11.Write a subquery to list clients who have never made a purchase.



SELECT FullName
FROM Clients c
WHERE NOT EXISTS (
    SELECT 1 FROM Purchases p WHERE p.ClientID = c.ClientID
);


--12.Use a subquery to list all items that belong to the category "Electronics."

Select * from Items

SELECT ProductName, Category
FROM Items
WHERE Category IN (
    SELECT Category FROM Items WHERE Category = 'Electronics'
);

select ProductName,Category
from Items 
where Category in(select Category from Items where Category='Furniture')

--13.Use a subquery to find clients who have purchased items from a specific category.

SELECT c.FullName
FROM Clients1 c
WHERE c.ClientID IN (
    SELECT p.ClientID
    FROM Purchases2 p
    JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
    JOIN Items i ON pd.ItemID = i.ItemID
    WHERE i.Category = 'Electronics'
);

select c.FullName
from Clients1 c 
where c.ClientID in ( select p.ClientID from Purchases2 p
join PurchaseDetails pd on p.PurchaseID=pd.PurchaseID
join Items i on pd.ItemID=i.ItemID
where i.Category='Furniture'
);




select * from Clients1
select * from Purchases2
select * from PurchaseDetails

--14.Create a subquery to list all items with a quantity available greater than the average stock level.

select ProductName,StockCount
from Items 
where StockCount > (select avg(StockCount) from Items);

--15.Write a correlated subquery to list all staff who work in the same division as those who have received a bonus.

SELECT s.FullName, s.Division
FROM Staff s
WHERE s.Division IN (
    SELECT b.Division
    FROM Staff b
    JOIN Bonuses bo ON b.StaffID = bo.StaffID
);

--16.Use a correlated subquery to list staff members who earn more than the average salary in their division.


select s.FullName,s.Salary,s.Division
from Staff s
where s.Salary > (select avg(s2.Salary) from Staff s2 where s.Division=s2.Division);


--17.Write a query using the EXISTS operator to list purchases that include an item from the Items table.




SELECT *
FROM Purchases p
WHERE EXISTS (
    SELECT 1
    FROM PurchaseDetails pd
    JOIN Items i ON pd.ItemID = i.ItemID
    WHERE pd.PurchaseID = p.PurchaseID
);


--18.Write a subquery to find the purchase with the highest total value.



SELECT s.PurchaseID, s.Amount
FROM Purchases s
WHERE s.Amount = (SELECT MAX(s2.Amount) FROM Purchases s2);

--19.Use a correlated subquery to list staff who earn more than the average salary of their division and have more than 5 years of service.



SELECT s.FullName, s.Salary, s.Division, s.HireDate
FROM Staff s
WHERE s.Salary > (
    SELECT AVG(s2.Salary)
    FROM Staff s2
    WHERE s2.Division = s.Division
)
AND DATEDIFF(YEAR, s.HireDate, GETDATE()) > 5;

--20.Create a query to list clients who have never purchased an item with a price higher than $100.



SELECT DISTINCT c.FullName
FROM Clients c
WHERE NOT EXISTS (
    SELECT 1
    FROM Purchases p
    JOIN PurchaseDetail pd ON p.PurchaseID = pd.PurchaseID
    WHERE p.ClientID = c.ClientID AND pd.Price > 100
);

-----------------------------------MEDIUM TASKS----------------------------------------------------


--1.Write a correlated subquery to list all staff who earn more than the average salary in their division, excluding the staff member with the highest salary in that division.



SELECT s.FullName, s.Salary, s.Division
FROM Staff s
WHERE s.Salary > (
    SELECT AVG(s2.Salary)
    FROM Staff s2
    WHERE s2.Division = s.Division
)
AND s.Salary < (
    SELECT MAX(s3.Salary)
    FROM Staff s3
    WHERE s3.Division = s.Division
);


--2.Use a subquery to list items that have been purchased by clients who have placed more than 5 orders.




SELECT DISTINCT c.FullName, p.Product
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
WHERE p.PurchaseID IN (
    SELECT pd.PurchaseID
    FROM PurchaseDetails pd
    GROUP BY pd.PurchaseID
    HAVING COUNT(*) > 5
);


--3.Create a query to list all staff who are older than the overall average age and earn more than the average company salary.



select s.FullName,s.Age,s.Salary
from Staff s
where s.Salary > (select avg(s2.Salary) from Staff s2)
and 
s.Age > (select avg(s3.Age) from Staff s3);

--4.Use a correlated subquery to list staff who work in a division that has more than 5 staff members earning over $100,000.


SELECT s.FullName, s.Division, s.Salary
FROM Staff s
WHERE s.Salary > 100000
AND s.Division IN (
    SELECT s2.Division                                     -- the reason there are no values because there are no staff who are earning more than 100,000 and division who have 5 staff
    FROM Staff s2
    GROUP BY s2.Division
    HAVING COUNT(*) > 5
);


--5.Write a subquery to list all items that have not been purchased by any client in the past year.






SELECT i.ProductName
FROM Items i
WHERE NOT EXISTS (
    SELECT 1
    FROM Purchase p
    WHERE p.ItemID=i.ItemID
    AND p.PurchaseDate > DATEADD(year, -1, GETDATE())  -- Purchases in the last year
);





