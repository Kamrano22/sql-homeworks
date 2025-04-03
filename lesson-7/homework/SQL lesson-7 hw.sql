select * from INFORMATION_SCHEMA.columns;
--EASY LEVEL TASKS
--TASK1----------------------------
select min(ListPrice) as minPrice 
from Production.Product
--TASK2--------------------------
select max(employee_salary) as maxPrice
from employees1.employees;
--TASK3------------------------------
SELECT count(*) as RowsQnt
from Sales.Customer;
--TASK4-----------------------------
select count(distinct product_category) as category  ---there are 4 unique product categories in this table
from products;
--TASK5-------------------------------
select
SELECT SUM(SalesAmount) AS TotalSales
FROM sales;
--Task6------------------------------
select avg(employee_age) as AvgAge   -- the average age of employees eqals to 33
from employees;
--Task7------------------------------------
SELECT employee_department, COUNT(*) AS EmpDepartment
FROM employees1                                        --quantity of employees in each department
GROUP BY employee_department;
--Task8--------------------------------------------
SELECT product_category,
       MIN(product_price) AS minPrice,
       MAX(product_price) AS maxPrice      --this shows the minimum and maximum price of product_categories
FROM category
GROUP BY product_category;
--Task9--------------------------------------------
select region,
sum(sales_amount) as TotalSales
from sales
group by region;
--Task10----------------------------------------
SELECT employee_department AS department, 
       COUNT(employee_name) AS EmpCount
FROM employees
GROUP BY employee_department
HAVING COUNT(employee_name) > 5;
---------------MEDIUM LEVEL TASKS--------------------
--TASK11--------------------
select product_category,
avg(salesamount) avgsales,
sum(salesamount) totalsales
from sales
group by product_category;
--TASK12---------------------
select 
count(*) as employeeQnt
from HumanResources.Employee
where JobTitle = 'Marketing Specialist' 
---Task13--
select employee_department,
max(employee_salary) as Maxsalary,
min(employee_salary) as Minsalary
from employees
group by employee_department;
--TASK14---------------
select employee_department,
avg(employee_salary) as avgsalary
from employees
group by employee_department;

--TASK15----------------------------
select employee_department,
count(*) as employeeQnt,
avg(employee_salary) as avgsalary
from employees
group by employee_department

--TASK16-----------------
SELECT product_category, AVG(product_price) AS avg_price
FROM category
GROUP BY product_category
HAVING  AVG(product_price) > 100;
----TASK17----------
select distinct product_id,
count(units_sold) as unitssold
from products
where units_sold > 100
group by product_id;

---TASK18------------------
select sales_date,
sum(salesamount) as totalsales
from sales
group by sales_date
----TASK19-------------------
select region,
count(customer_name)as customers
from orders
group by region;
----TASK20-----
select * from department

SELECT employee_department, SUM(salary_expenses) AS total_salary
FROM department
GROUP BY employee_department
HAVING SUM(salary_expenses) > 100000;
---------------------------HARD LEVEL TASKS--------------
-----TASK21----
select product_category,
avg(salesamount) as sales
from products
group by product_category
having avg(salesamount) > 200;
---	TASK22-------
SELECT 
    employee_name,
    SUM(salesamount) AS Totalsales
FROM sales
GROUP BY employee_name
HAVING SUM(salesamount) > 5000;
----TASK23------
select employee_department,
sum(employee_salary) as salary,
avg(employee_salary) as avgsalary
from employees
group by employee_department
having avg(employee_salary) > 6000
-----TASK24-------
select customer_name,
min(order_value) as minvalue,
max(order_value) as maxvalue
from customers
group by customer_name 
having sum(order_value) >50;
----TASK25------------
select region,
sum(salesamount) as totalsales,
count(distinct product_sold) as ditinct_products_sold
from sales
group by region
having count(product_sold) >10;
----TASK26---------------
select 
product_category,
min(order_quantity) as minorder_quantity,
max(order_quantity) as  maxorder_quantity
from products
group by product_category;

---TASK27-----
SELECT Region, 
       [2022] AS Sales_2022, 
       [2023] AS Sales_2023, 
       [2024] AS Sales_2024
FROM (
    SELECT SalesYear, Region, SalesAmount
    FROM Sales
) AS SourceTable
PIVOT (
    SUM(SalesAmount)
    FOR SalesYear IN ([2022], [2023], [2024])
) AS PivotTable;
----TASK28-------------
SELECT SalesYear, Region, 'Q1' AS Quarter, SalesAmount / 4 AS SalesAmount FROM Sales
UNION ALL
SELECT SalesYear, Region, 'Q2' AS Quarter, SalesAmount / 4 AS SalesAmount FROM Sales
UNION ALL
SELECT SalesYear, Region, 'Q3' AS Quarter, SalesAmount / 4 AS SalesAmount FROM Sales
UNION ALL
SELECT SalesYear, Region, 'Q4' AS Quarter, SalesAmount / 4 AS SalesAmount FROM Sales;

-----TASK29-------------
SELECT product_category, 
       SUM(order_quantity) AS total_orders
FROM products
GROUP BY product_category
HAVING SUM(order_quantity) > 50;
----TASK30-------
SELECT EmployeeName, 
       ISNULL([Q1], 0) AS Q1_Sales, 
       ISNULL([Q2], 0) AS Q2_Sales, 
       ISNULL([Q3], 0) AS Q3_Sales, 
       ISNULL([Q4], 0) AS Q4_Sales
FROM (
    -- Step 1: Select raw data
    SELECT EmployeeName, Quarter, SalesAmount
    FROM EmployeeSales
) AS SourceTable
PIVOT (
    -- Step 2: Aggregate SalesAmount by Quarter
    SUM(SalesAmount)
    FOR Quarter IN ([Q1], [Q2], [Q3], [Q4])
) AS PivotTable;