

select * from Dates


--In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. Please check out sample input and expected output.
select id,Dt,format(Dt,'MM') as Formated
from Dates;


--In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max values of vals columns for each Id and RId.


select * from Mytabel


WITH MaxVals AS (
    SELECT 
        Id,
        rId,
        MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rId
)
SELECT
    (SELECT COUNT(DISTINCT Id) FROM MyTabel) AS Distinct_Ids,
    (SELECT COUNT(DISTINCT rId) FROM MyTabel) AS rID,
    (SELECT SUM(MaxVal) FROM MaxVals) AS TotalOfMaxVals;



	--In this puzzle you have to get records with at least 6 characters and maximum 10 characters. 




	select *from TestFixLengths


	CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');


select Id,Vals
from TestFixLengths
where len(Vals) between 6 and 10;


--In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value


 select * from TestMaximum 


WITH cte AS (
    SELECT 
        Id,
        Item,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals DESC) AS rn
    FROM TestMaximum
)
SELECT 
    Id,
    Item,
    Vals AS MaxValue
FROM cte
WHERE rn = 1;

 -- In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and then Sum the data using Id only.

 select * from SumOfMax

WITH MaxValues AS (
    SELECT 
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxOfVals
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
)
SELECT 
    Id,
    SUM(MaxOfVals) AS SumOfMax
FROM MaxValues
GROUP BY Id;


--In this puzzle you have to find difference between a and b column between each row and if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. 

select * from TheZeroPuzzle

SELECT 
    id,
    a,
    b,
    IIF(a - b <> 0, CAST(a - b AS VARCHAR(20)), '') AS result
FROM TheZeroPuzzle;





--What is the total revenue generated from all sales?


SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;

--What is the average unit price of products?

select Product,avg(UnitPrice) as AveragePrice
from Sales
group by Product;


--How many sales transactions were recorded?

SELECT COUNT(SaleID) AS TransactionCount
FROM Sales;

--What is the highest number of units sold in a single transaction?

select max(QuantitySold) as UnitsSold,SaleDate
from Sales
group by SaleDate
order by UnitsSold desc




--How many products were sold in each category?

select count(QuantitySold),Category                                    --this is the first option 
from Sales
group by Category

SELECT DISTINCT Category, 
       COUNT(QuantitySold) OVER (PARTITION BY Category) AS CategoryCount                         --this is the second option
FROM Sales




--What is the total revenue for each region?


select Distinct Region,
sum(QuantitySold* UnitPrice) over (partition by Region) as TotalRevenue
from Sales



--What is the total quantity sold per month?


SELECT 
  FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
  SUM(QuantitySold) AS TotalQuantity
FROM Sales
GROUP BY FORMAT(SaleDate, 'yyyy-MM')
ORDER BY SaleMonth;




--Which product generated the highest total revenue?

select Product,
sum(QuantitySold*UnitPrice) over (partition by Product) as RevenueperProduct
from Sales
order by RevenueperProduct desc



--Compute the running total of revenue ordered by sale date.

select SaleDate,
sum(UnitPrice*QuantitySold) over (order by SaleDate) TotalRevenue
from Sales
order by TotalRevenue desc

--How much does each category contribute to total sales revenue?

SELECT 
  Category,
  SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
  SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER () AS RevenuePercentage
FROM Sales
GROUP BY Category;

--Show all sales along with the corresponding customer names



select c.CustomerName,s.SaleID,s.SaleDate
from Customers c 
join Sales s on c.CustomerId=s.CustomerID;







--List customers who have not made any purchases

SELECT c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON s.CustomerID = c.CustomerID
WHERE s.SaleID IS NULL;



--Compute total revenue generated from each customer

SELECT 
  c.CustomerName,
  SUM(s.QuantitySold * s.UnitPrice) OVER (PARTITION BY c.CustomerName) AS TotalRevenue
FROM Customers c 
JOIN Sales s ON c.CustomerID = s.CustomerID;


--Find the customer who has contributed the most revenue

SELECT 
  c.CustomerName,
  SUM(s.QuantitySold * s.UnitPrice) AS Revenue,
  SUM(s.QuantitySold * s.UnitPrice) * 100.0 / SUM(SUM(s.QuantitySold * s.UnitPrice)) OVER () AS RevenuePercentage
FROM Sales s 
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;










--Calculate the total sales per customer per month

select * from Sales
select * from Customers

SELECT 
  c.CustomerName,
  FORMAT(s.SaleDate, 'yyyy-MM') AS SaleMonth,
  SUM(s.QuantitySold * s.UnitPrice) OVER (PARTITION BY c.CustomerName, FORMAT(s.SaleDate, 'yyyy-MM')) AS MonthlyRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;


--List all products that have been sold at least once



SELECT p.ProductName, SUM(s.QuantitySold) AS TotalQuantitySold
FROM Products p 
JOIN Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductName
HAVING SUM(s.QuantitySold) >= 1;



--Find the most expensive product in the Products table



with cte as (

select ProductName,
CostPrice,
rank() over (order by CostPrice desc) as ranks
from Products
)
select * from cte 
where ranks =1






--Show each sale with its corresponding cost price from the Products table



select  s.SaleID,s.SaleDate,p.ProductName,sum(s.UnitPrice*s.QuantitySold) 
from Products p 
join Sales s on p.ProductID=s.ProductID
group by s.SaleID,s.SaleDate,p.ProductName;                               -- the first option


SELECT 
  s.SaleID,
  s.SaleDate,
  p.ProductName,
  p.CostPrice,
  s.QuantitySold,
  s.UnitPrice,
  s.QuantitySold * s.UnitPrice AS SaleRevenue
FROM Sales  s  
JOIN Products p ON s.ProductID = p.ProductID;                                      -- the second option


--Find all products where the selling price is higher than the average selling price in their category

select * from Products
select * from Sales


select p.ProductName,p.CostPrice as SellingPrice
from Products p
where p.CostPrice > ( select avg(p2.CostPrice) as AveragePrice from Products p2);


