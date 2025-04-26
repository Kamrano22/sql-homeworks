--Compute Running Total Sales per Customer




SELECT distinct customer_name, 
       total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_name ORDER BY customer_id) AS running_total
FROM sales_data;



--Count the Number of Orders per Product Category

SELECT sale_id, 
       product_name, 
       product_category,
       COUNT(sale_id) OVER (PARTITION BY product_category) AS order_count_per_category
FROM sales_data;



--Find the Maximum Total Amount per Product Category


SELECT product_category, 
       MAX(total_amount) AS max_total_amount_per_category                     -- this is the first option for the task without window function
FROM sales_data
GROUP BY product_category;


SELECT distinct product_name, 
       product_category, 
       total_amount,
       MAX(total_amount) OVER (PARTITION BY product_category) AS max_total_amount_per_category                   --this isthe second option forthe task using window function
FROM sales_data;
--Find the Minimum Price of Products per Product Category



select product_name,product_category,unit_price,
min (unit_price) over (partition by product_category order by unit_price)                            
from sales_data;                                                                                     --first option for the task with window function



SELECT product_category, 
       MIN(unit_price) AS min_unit_price_per_category                                         -- second option without window function
FROM sales_data
GROUP BY product_category;



--Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)



SELECT total_amount, 
       order_date, 
       product_category,
       AVG(total_amount) OVER (
           PARTITION BY product_category 
           ORDER BY order_date 
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS moving_avg_sales
FROM sales_data;



--Find the Total Sales per Region


SELECT total_amount, 
       region,
       SUM(total_amount) OVER (PARTITION BY region) AS total_sales_per_region                       --first option for the task with window function
FROM sales_data;




SELECT 
    region,                                                                                          --second option for the task without window function
    SUM(total_amount) AS total_sales_per_region
FROM sales_data
GROUP BY region;


--Compute the Rank of Customers Based on Their Total Purchase Amount


SELECT customer_name, 
       SUM(total_amount) AS total_purchase_amount,
       RANK() OVER (ORDER BY SUM(total_amount) DESC) AS purchase_rank
FROM sales_data
GROUP BY customer_name;


--Calculate the Difference Between Current and Previous Sale Amount per Customer


WITH cte AS (
    SELECT 
        customer_name, 
        order_date, 
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_name ORDER BY order_date) AS previous_sale
    FROM sales_data
)
SELECT 
    customer_name, 
    order_date, 
    total_amount,
    previous_sale,
    total_amount - previous_sale AS difference_from_previous_sale
FROM cte;





--Find the Top 3 Most Expensive Products in Each Category



WITH ranked_products AS (
    SELECT 
        product_name,
        product_category,
        unit_price,
        ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rank
    FROM sales_data
)
SELECT 
    product_name,
    product_category,
    unit_price
FROM ranked_products
WHERE rank <= 3
ORDER BY product_category, rank;




--Compute the Cumulative Sum of Sales Per Region by Order Date

SELECT 
    total_amount, 
    region, 
    order_date,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;


--Compute Cumulative Revenue per Product Category



SELECT 
    product_name, 
    product_category, 
    total_amount,
    SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data;

--Here you need to find out the sum of previous values. Please go through the sample input and expected output.

select * from sales_data

WITH CTE AS (
    SELECT 
        sale_id, 
        product_name, 
        product_category, 
        total_amount,
        LAG(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS previous_value
    FROM sales_data
)
SELECT 
    sale_id, 
    product_name, 
    product_category, 
    total_amount,
    previous_value,
    SUM(previous_value) OVER (PARTITION BY product_category ORDER BY sale_id) AS sum_previous_values
FROM CTE;




--Sum of Previous Values to Current Value




SELECT 
    value,
    SUM(value) OVER (ORDER BY value) AS cumulative_sum
FROM OneColumn;



--Generate row numbers for the given data. The condition is that the first row number for every partition should be odd number.For more details please check the sample input and expected output.



SELECT 
    ID,
    Vals,
    (ROW_NUMBER() OVER (ORDER BY ID) * 2) - 1 AS Row_Num
FROM Row_nums;




--Find customers who have purchased items from more than one product_category


SELECT customer_name
FROM Sales_data
GROUP BY customer_name
HAVING COUNT(DISTINCT product_category) > 1;




--Find Customers with Above-Average Spending in Their Region



SELECT 
    s.customer_name, 
    s.total_amount, 
    s.region
FROM Sales_data s
WHERE s.total_amount > (
    SELECT AVG(s2.total_amount)
    FROM Sales_data s2
    WHERE s.region = s2.region
);




--Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank (dense ranking).


select customer_name,region,total_amount,
dense_rank() over ( partition by region order by total_amount) as Rank
from Sales_data;

--Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.


select customer_id,total_amount,order_date,
sum(total_amount) over (partition by customer_id order by order_date)as cumulative_sum
from Sales_data;


--Calculate the sales growth rate (growth_rate) for each month compared to the previous month.




--Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)



WITH cte AS (
    SELECT 
        customer_name, 
        total_amount, 
        order_date,
        LAST_VALUE(total_amount) OVER (PARTITION BY customer_name ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Value
    FROM Sales_data
)

SELECT 
    customer_name,
    total_amount,
    order_date,
    Last_Value
FROM cte
WHERE total_amount > Last_Value;


--Identify Products that prices are above the average product price


select * from Sales_data


select s.product_name,s.unit_price
from Sales_data s
where s.unit_price > (select avg(s2.unit_price) as AveragePrice  from Sales_data s2 );


select * from MyData
--In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. For more details please see the sample input and expected output.

SELECT 
id,
    grp,
    val1,
    val2,
    SUM(val1 + val2) OVER (PARTITION BY id) AS group_sum
FROM MyData;




--Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values



select * from TheSumPuzzle

WITH QuantityCounts AS (
    SELECT 
        ID,
        COUNT(DISTINCT Quantity) AS Distinct_Quantity_Count
    FROM TheSumPuzzle
    GROUP BY ID
)
SELECT 
    t.ID,
    t.Cost,
    t.Quantity,
    SUM(t.Cost) OVER (PARTITION BY t.ID) AS Total_Cost,
    CASE 
        WHEN qc.Distinct_Quantity_Count > 1 
        THEN SUM(t.Quantity) OVER (PARTITION BY t.ID)
        ELSE MAX(t.Quantity) OVER (PARTITION BY t.ID)
    END AS Total_Quantity
FROM TheSumPuzzle t
JOIN QuantityCounts qc ON t.ID = qc.ID;



--You have to write a query that will give us sum of tyze for each Z. Detailed logic is given below


SELECT Level, TyZe,Result,
       SUM(TyZe) OVER (PARTITION BY Level) AS Results
FROM testSuXVI
WHERE Result = 'Z';


--In this puzzle you need to generate row numbers for the given data. The condition is that the first row number for every partition should be even number.


select * from Row_Nums

SELECT 
    ID, 
    Vals,
    (DENSE_RANK() OVER (ORDER BY ID) * 2) + 
    (ROW_NUMBER() OVER (PARTITION BY ID ORDER BY Vals) - 1) AS Changed
FROM Row_Nums
ORDER BY ID, Vals;
