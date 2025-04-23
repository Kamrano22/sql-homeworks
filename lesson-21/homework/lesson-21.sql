

--1.Write a query to assign a row number to each sale based on the SaleDate.

SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleDate,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

select * from ProductSales


--2.Write a query to rank products based on the total quantity sold (use DENSE_RANK())

SELECT 
    ProductName,
    SUM(SaleAmount) AS TotalSales,
    DENSE_RANK() OVER (ORDER BY SUM(SaleAmount) DESC) AS RankByTotalSales
FROM ProductSales
GROUP BY ProductName;



--3.Write a query to identify the top sale for each customer based on the SaleAmount.



SELECT CustomerID, SaleID, ProductName, SaleAmount
FROM (
    SELECT 
        CustomerID,
        SaleID,
        ProductName,
        SaleAmount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS RankBySaleAmount
    FROM ProductSales
) AS ranked
WHERE RankBySaleAmount = 1;


--4.Write a query to display each sale's amount along with the next sale amount in the order of SaleDate using the LEAD() function



select SaleID,ProductName,SaleAmount,
lead(SaleAmount) over ( order by SaleDate) 
from ProductSales;

--5.Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate using the LAG() function


select SaleID,ProductName,SaleAmount,SaleDate,
lag(SaleAmount) over ( order by SaleDate) SaleDate
from ProductSales;


--6.Write a query to rank each sale amount within each product category.


SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleDate,
    RANK() OVER (PARTITION BY ProductName ORDER BY SaleAmount DESC) AS RankByCategory
FROM ProductSales;



--7.Write a query to identify sales amounts that are greater than the previous sale's amount

select * from ProductSales

WITH SalesWithPrevious AS (
    SELECT 
        SaleID,
        ProductName,
        SaleAmount,
        SaleDate,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
)
SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleDate,
    PreviousSaleAmount
FROM SalesWithPrevious
WHERE SaleAmount > PreviousSaleAmount;

--8.Write a query to calculate the difference in sale amount from the previous sale for every product


with cte as ( 
select SaleID,ProductName,SaleAmount,SaleDate,
lag(SaleAmount) over (order by SaleDate) as PreviousSaleAmount
from ProductSales
)

SELECT 
    ProductName,
    SaleAmount,
    SaleDate,
    PreviousSaleAmount,
    PreviousSaleAmount - SaleAmount AS Difference
FROM cte;



--9.Write a query to compare the current sale amount with the next sale amount in terms of percentage change.


with cte as (
select SaleID,ProductName,SaleAmount,SaleDate,
lead(SaleAmount) over (order by SaleDate) as NextSaleAmount
from ProductSales
)
SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleDate,
    NextSaleAmount,
    CASE 
        WHEN SaleAmount = 0 THEN NULL  -- to avoid division by zero
        ELSE ROUND(((NextSaleAmount - SaleAmount) * 100.0) / SaleAmount, 2)
    END AS PercentageChange
FROM cte;


--10.Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.



select * from ProductSales


WITH cte AS (
    SELECT 
        SaleID,
        ProductName,
        SaleAmount,
        SaleDate,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
)
SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleDate,
    PreviousSaleAmount,
    CASE 
        WHEN PreviousSaleAmount = 0 THEN NULL  -- avoid divide-by-zero
        WHEN PreviousSaleAmount IS NULL THEN NULL  -- first sale, no ratio
        ELSE ROUND(SaleAmount * 1.0 / PreviousSaleAmount, 2)
    END AS SaleRatio
FROM cte;

--11.Write a query to calculate the difference in sale amount from the very first sale of that product.


WITH cte AS (
    SELECT 
        SaleID,
        ProductName,
        SaleAmount,
        SaleDate,
        FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS First_Value
    FROM ProductSales
)
SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleDate,
    First_Value,
    SaleAmount - First_Value AS DifferenceFromFirstSale
FROM cte;

--12.Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).


WITH ProductSalesWithLag AS (
    SELECT 
        ProductName,
        SaleID,
        SaleAmount,
        SaleDate,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
        LAG(SaleDate) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleDate
    FROM ProductSales
),
SalesWithStatus AS (
    SELECT 
        *,
        CASE 
            WHEN PreviousSaleAmount IS NULL THEN 'First Sale' -- No previous sale to compare
            WHEN SaleAmount > PreviousSaleAmount THEN 'Increasing'
            ELSE 'Decreasing or Equal'
        END AS TrendStatus
    FROM ProductSalesWithLag
),
ProductTrendAnalysis AS (
    SELECT
        ProductName,
        COUNT(*) AS TotalSales,
        SUM(CASE WHEN TrendStatus = 'Increasing' THEN 1 ELSE 0 END) AS IncreasingCount,
        SUM(CASE WHEN TrendStatus = 'Decreasing or Equal' THEN 1 ELSE 0 END) AS NonIncreasingCount,
        MIN(SaleDate) AS FirstSaleDate,
        MAX(SaleDate) AS LastSaleDate
    FROM SalesWithStatus
    GROUP BY ProductName
)
SELECT 
    ProductName,
    TotalSales,
    IncreasingCount,
    NonIncreasingCount,
    FirstSaleDate,
    LastSaleDate,
    CASE 
        WHEN NonIncreasingCount = 0 THEN 'Always Increasing'
        WHEN IncreasingCount = 0 THEN 'Always Decreasing or Flat'
        WHEN IncreasingCount > NonIncreasingCount THEN 'Mostly Increasing'
        ELSE 'Mixed Trend'
    END AS OverallTrend
FROM ProductTrendAnalysis
ORDER BY 
    CASE 
        WHEN NonIncreasingCount = 0 THEN 1 -- Always increasing first
        WHEN IncreasingCount > NonIncreasingCount THEN 2 -- Mostly increasing next
        ELSE 3 -- Others last
    END,
    ProductName;


	--13.Write a query to calculate a "closing balance" for sales amounts which adds the current sale amount to a running total of previous sales.


SELECT 
    ProductName,
    SaleAmount,
    SaleDate,
    SUM(SaleAmount) OVER (
        PARTITION BY ProductName 
        ORDER BY SaleDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ClosingBalance
FROM ProductSales
ORDER BY ProductName, SaleDate;


--14.Write a query to calculate the moving average of sales amounts over the last 3 sales.


SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleDate,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName 
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg3Sales
FROM ProductSales
ORDER BY ProductName, SaleDate;



--15.Write a query to show the difference between each sale amount and the average sale amount.

WITH cte AS (
    SELECT 
        ProductName,
        SaleAmount,
        AVG(SaleAmount) OVER (ORDER BY SaleDate) AS AverageSaleAmount
    FROM ProductSales
)
SELECT 
    ProductName,
    SaleAmount,
    AverageSaleAmount,
    SaleAmount - AverageSaleAmount AS Difference
FROM cte;


--16.Find Employees Who Have the Same Salary Rank




WITH SalaryRanks AS (
    SELECT 
        Name,
        Salary,
        RANK() OVER (ORDER BY Salary) AS SalaryRank
    FROM Employees1
)
SELECT 
    s1.Name AS Employee1,
    s2.Name AS Employee2,
    s1.Salary,
    s1.SalaryRank
FROM SalaryRanks s1
JOIN SalaryRanks s2 
    ON s1.SalaryRank = s2.SalaryRank                                --it is not showing any values in the output because there are no matching values to the criteria
    AND s1.Name < s2.Name;



	--17.Identify the Top 2 Highest Salaries in Each Department


SELECT Name, Salary, SalaryOrder
FROM (
    SELECT 
        Name, 
        Salary,
        RANK() OVER (ORDER BY Salary) AS SalaryOrder          -- this is my first option to the query
    FROM Employees1
) AS ranked
WHERE SalaryOrder <= 2;


select top 2 Name,Salary,
rank() over (order by Salary) as SalaryOrder                        -- this is the second option for the task 
from Employees1;


--18.Find the Lowest-Paid Employee in Each Department


WITH DepartmentMinSalaries AS (
    SELECT 
        Name,
        Salary,
        Department,
        MIN(Salary) OVER (PARTITION BY Department) AS MinSalary
    FROM Employees1
)
SELECT Name, Salary, Department
FROM DepartmentMinSalaries
WHERE Salary = MinSalary;


--19.Calculate the Running Total of Salaries in Each Department


select Department,Salary,
sum(Salary) over(partition by Department order by Salary rows between unbounded preceding and current row)
from Employees1;

--20.Find the Total Salary of Each Department Without GROUP BY


WITH cte AS (
    SELECT 
        Department,
        SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
    FROM Employees1
)
SELECT DISTINCT Department, TotalSalary
FROM cte;



--21.Calculate the Average Salary in Each Department Without GROUP BY
select * from Employees1


with cte as (
select Salary,Department,
avg(Salary) over (partition by Department) as SalaryAverage
from Employees1
)

select distinct SalaryAverage,Department
from cte ;


--22.Find the Difference Between an Employee’s Salary and Their Department’s Average

WITH cte AS (
    SELECT 
        Name,
        Salary,
        Department,
        AVG(Salary) OVER (PARTITION BY Department) AS DepartmentAverage
    FROM Employees1
)
SELECT 
    Name,
    Salary,
    DepartmentAverage,
    Salary - DepartmentAverage AS Difference
FROM cte;


--23.Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT 
    Name,
    Salary,
    AVG(Salary) OVER (ORDER BY Salary ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS AverageSalary
FROM Employees1;


--24.Find the Sum of Salaries for the Last 3 Hired Employees */


WITH Last3Hired AS (
    SELECT 
        Name,
        Salary,
        ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RowNum
    FROM Employees1
)
SELECT
    SUM(Salary) AS TotalSalaryForLast3Hired
FROM Last3Hired
WHERE RowNum <= 3;

select * from Employees1
