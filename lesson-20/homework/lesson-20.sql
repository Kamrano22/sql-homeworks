--1.Find customers who purchased at least one item in March 2024 using EXISTS



SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND s2.SaleDate >= '2024-03-01'
      AND s2.SaleDate < '2024-04-01'
);


--2.Find the product with the highest total sales revenue using a subquery.



SELECT TOP 1 s.Product
FROM #Sales s
GROUP BY s.Product
ORDER BY SUM(s.Price * s.Quantity) DESC;


--3.Find the second highest sale amount using a subquery

WITH RankedProducts AS (
    SELECT 
        Product,
        SUM(Price * Quantity) AS TotalRevenue,
        DENSE_RANK() OVER (ORDER BY SUM(Price * Quantity) DESC) AS RevenueRank
    FROM #Sales
    GROUP BY Product
)
SELECT Product, TotalRevenue
FROM RankedProducts
WHERE RevenueRank = 2;


--4.Find the total quantity of products sold per month using a subquery


WITH cte AS (
    SELECT 
        Product,
        SUM(Quantity) AS ProductCount,
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth
    FROM #Sales
    GROUP BY Product, FORMAT(SaleDate, 'yyyy-MM')
)

SELECT Product, ProductCount, SaleMonth
FROM cte
ORDER BY SaleMonth, Product;


--5.Find customers who bought same products as another customer using EXISTS */



SELECT DISTINCT s.CustomerName, s.Product
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s.Product = s2.Product
      AND s.CustomerName <> s2.CustomerName
);


--6.Return how many fruits does each person have in individual fruit level

select * from Fruits

select Name,Fruit,count(Fruit) as FruitCount 
from Fruits 
group by Name,Fruit;

--7.Return older people in the family with younger ones


select * from Family

SELECT p.ChildID AS Child, p.ParentID AS Parent
FROM Family p
JOIN Family c
  ON p.ParentID = c.ChildID
WHERE p.ParentID != c.ParentID;


--8.For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas*/



  select  distinct CustomerID
  from #Orders o 
  where o.DeliveryState='TX'
  and o.CustomerID in (
  select distinct CustomerID
  from #Orders where DeliveryState='CA'
  );

  --9.-- Insert the names of residents if they are missing



select * from #residents


UPDATE #residents
SET address = 'city=Lisboa country=Portugal name=Diogo age=26'
WHERE address = 'city=Lisboa country=Portugal age=26';

update #residents
set address='city=Milan country=Italy name=Theo age=28'
where address='city=Milan country=Italy age=28';


update #residents
set address='city=Tashkent country=Uzbekistan name=Rajabboy age=22'
where address='city=Tashkent country=Uzbekistan age=22';

--10.--Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest --and the most expensive routes


select * from #Routes


WITH RouteOptions AS (
    SELECT 
        r1.DepartureCity AS StartCity,
        r1.ArrivalCity AS MidCity,
        r2.ArrivalCity AS EndCity,
        r1.Cost + r2.Cost AS TotalCost
    FROM #Routes r1
    JOIN #Routes r2
        ON r1.ArrivalCity = r2.DepartureCity
    WHERE r1.DepartureCity = 'Tashkent'
      AND r2.ArrivalCity = 'Khorezm'
)

SELECT *
FROM RouteOptions
WHERE TotalCost = (SELECT MIN(TotalCost) FROM RouteOptions)
   OR TotalCost = (SELECT MAX(TotalCost) FROM RouteOptions);


   --11.  --Rank products based on their order of insertion.

SELECT ID, Vals,
  RANK() OVER (ORDER BY ID) AS ProductRank
FROM #RankingPuzzle;

select * from #RankingPuzzle

--12.-You have to return Ids, what number of the letter would be next if inserted, --the maximum length of the consecutive occurence of the same digit

select * from #Consecutives

WITH ConsecutiveCounts AS (
    SELECT 
        ID,
        Digit,
        ROW_NUMBER() OVER (PARTITION BY Digit ORDER BY ID) 
        - ROW_NUMBER() OVER (PARTITION BY Digit ORDER BY ID) AS ConsecutiveGroup
    FROM #Sequence
),
MaxConsecutive AS (
    SELECT 
        Digit,
        MAX(COUNT(*)) AS MaxConsecutive
    FROM ConsecutiveCounts
    GROUP BY Digit
)
SELECT 
    s.Digit,
    COUNT(*) OVER (PARTITION BY s.Digit ORDER BY s.ID) + 1 AS NextPosition,
    mc.MaxConsecutive
FROM #Sequence s
JOIN MaxConsecutive mc ON s.Digit = mc.Digit;


--13.--Find employees whose sales were higher than the average sales in their department





select e.EmployeeName,e.Department,e.SalesAmount
from #EmployeeSales e
where e.SalesAmount > ( select avg(e2.SalesAmount) from #EmployeeSales e2 where e.Department=e2.Department);


--14. Find employees who had the highest sales in any given month using EXISTS


select * from #EmployeeSales


SELECT EmployeeName, SalesAmount, SalesMonth
FROM #EmployeeSales s
WHERE SalesAmount = (
    SELECT MAX(SalesAmount)
    FROM #EmployeeSales
    WHERE SalesMonth = s.SalesMonth
);

--15.Find employees who made sales in every month using NOT EXISTS -- Insert Sample Data


select * from #EmployeeSales


SELECT DISTINCT s.EmployeeName
FROM #EmployeeSales s
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth FROM #EmployeeSales
    ) AS all_months                
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es
        WHERE es.EmployeeName = s.EmployeeName
          AND es.SalesMonth = all_months.SalesMonth
    )
)


--16.Retrieve the names of products that are more expensive than the average price of all products.



select Name,Price
from Products p 
where p.Price > (select avg(p2.Price) as AveragePrice from Products p2);


-- 17. Find the products that have a stock count lower than the highest stock count.


select * from Products

SELECT p.Name, p.Stock
FROM Products p
WHERE p.Stock < (
    SELECT MAX(p2.Stock)
    FROM Products p2
    WHERE p2.Name = p.Name
);



--18. Get the names of products that belong to the same category as 'Laptop'.



SELECT p.Name, p.Category
FROM Products p
WHERE p.Category = (
    SELECT p2.Category
    FROM Products p2
    WHERE p2.Name = 'Laptop'
);


--19. Retrieve products whose price is greater than the lowest price in the Electronics category.



select p.Name,p.Price,p.Category
from Products p 
where p.Price > (select min(p2.Price) as LowestPrice from Products p2 where p2.Category='Elelctronics');                 -- the query is not returning value because there is no any product whose price is greater than the lowest price of the product in Electronics category.

--20. Find the products that have a higher price than the average price of their respective category.



select * from Products

SELECT p1.Name, p1.Price, p1.Category
FROM Products p1
WHERE p1.Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category = p1.Category
);

--21. Find the products that have been ordered at least once.



SELECT DISTINCT o.ProductID
FROM Orders o
WHERE o.ProductID IN (
    SELECT ProductID
    FROM Orders
    GROUP BY ProductID
    HAVING COUNT(OrderID) >= 1
);

--22.Retrieve the names of products that have been ordered more than the average quantity ordered.

SELECT p.Name, o.Quantity
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > (
    SELECT AVG(Quantity)
    FROM Orders
);

--23.Find the products that have never been ordered.

select * from Orders
select * from Products


SELECT p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID                                       -- Products in these tables all are ordered at keeast once and there are now products that have never been ordered that's why there are no values
);    



--24.Retrieve the product with the highest total quantity ordered.



select p.Name,o.Quantity
from Products p
join Orders o on o.ProductID=p.ProductID
where o.Quantity =( select max(Quantity) as highestQuantity from Orders);


--25.Find the products that have been ordered more times than the average number of orders placed.




select * from Orders
select * from Products


SELECT p.Name, COUNT(o.OrderID) AS OrderCount
FROM Products p
JOIN Orders o ON o.ProductID = p.ProductID
GROUP BY p.Name
HAVING COUNT(o.OrderID) > (
    SELECT AVG(OrderCount)
    FROM (
        SELECT COUNT(OrderID) AS OrderCount
        FROM Orders
        GROUP BY ProductID
    ) AS avg_orders
);


