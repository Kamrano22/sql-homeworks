--Level-1

--Find Employees with Minimum Salary

select name as emp_name,salary 
from employees 
where salary = (select min(salary)as MinimumSalary from employees);




--Find Products Above Average Price



select product_name,price
from products
where price > (select avg(price) as averageprice from products);


--Level-2

--Find Employees in Sales Department

SELECT e.name, d.department_name
FROM employees1 e 
JOIN departments d ON e.id = d.id
WHERE d.id IN (
    SELECT id 
    FROM departments 
    WHERE department_name = 'Sales'
);



--Retrieve customers who have not placed any orders.

select * from customers
select * from orders

SELECT c.name,c.customer_id
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id
);


--Level-3

--Find Products with Max Price in Each Category



SELECT 
    ProductName,
    CategoryID,
    price
FROM Products p
WHERE price = (
    SELECT MAX(price)
    FROM Products
    WHERE CategoryID = p.CategoryID
);






--Find Employees in Department with Highest Average Salary





SELECT e.name, e.salary, e.department_id
FROM employees2 e
join departments1 d on e.id=d.id 
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE e.id = d.id  -- Correlation
);


--Level-4

--Find Employees Earning Above Department Average


SELECT 
    e.id,
    e.name,
    e.department_id,
    e.salary,
    (SELECT AVG(salary) FROM employees3 WHERE department_id = e.department_id) AS dept_avg_salary
FROM employees3 e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees3
    WHERE department_id = e.department_id  -- Correlation
);



--Find Students with Highest Grade per Course

select * from students 
select * from grades 

SELECT 
    g.course_id,
    g.student_id,
    s.name,
    g.grade
FROM grades g
JOIN students s ON s.student_id = g.student_id
JOIN (
    SELECT course_id, MAX(grade) AS max_grade
    FROM grades
    GROUP BY course_id
) max_grades ON g.course_id = max_grades.course_id AND g.grade = max_grades.max_grade;

--Level-5

--Find Third-Highest Price per Category

select * from products2

SELECT 
    product_name,
    category_id,
    price
FROM (
    SELECT 
        product_name,
        category_id,
        price,
        RANK() OVER (PARTITION BY category_id ORDER BY price DESC) as price_rank
    FROM products2
) ranked_products
WHERE price_rank = 3;

--Find Employees Between Company Average and Department Max Salary


select * from employees4 

SELECT id, Name, salary, department_id
FROM (
    SELECT *,
           AVG(salary) OVER () AS CompanyAvgSalary,
           MAX(salary) OVER (PARTITION BY department_id) AS DeptMaxSalary
    FROM employees4
) AS sub
WHERE Salary BETWEEN CompanyAvgSalary AND DeptMaxSalary;




