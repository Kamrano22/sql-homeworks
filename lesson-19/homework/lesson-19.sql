select * from #Employees

--1.
--1. Employees with Salary Greater than Average Salary

select FirstName,
EmployeeID
from #Employees 
where Salary > (select avg(Salary) as AverageSalary from #Employees);

--2.a query to check if there are any employees in Department 1 using the EXISTS clause

select * from #Departments
select * from #Employees


SELECT DISTINCT e.FirstName, d.DepartmentName
FROM #Employees e
JOIN #Departments d ON d.DepartmentID = e.DepartmentID
WHERE EXISTS (
    SELECT 1
    FROM #Employees e2
    WHERE e2.DepartmentID = 1 AND e2.EmployeeID = e.EmployeeID
);



--3.query to return employees who work at the same department with Rachel Collins

select * from #Employees


SELECT e.FirstName, e.LastName, e.DepartmentID
FROM #Employees e
WHERE e.DepartmentID = (
    SELECT e2.DepartmentID
    FROM #Employees e2
    WHERE e2.FirstName = 'Rachel' AND e2.LastName = 'Collins'
);

select e.FirstName,e.LastName,e.Salary
from #Employees e 
where e.Salary = (select e2.Salary from #Employees e2 
where e2.FirstName = 'Rachel' and e2.LastName= 'Collins');

--4.employees who were hired after the last hired person for the department 2

select * from #Employees

SELECT e.FirstName, e.LastName, e.HireDate, e.DepartmentID
FROM #Employees e
WHERE e.HireDate > (
    SELECT MAX(e2.HireDate)
    FROM #Employees e2
    WHERE e2.DepartmentID = 2
);


--5.employees whose salary is higher than the average salary of their respective department

select * From #Employees
select * from #Departments
---first option
select e.FirstName,e.LastName,e.Salary,e.DepartmentID
from #Employees e 
where Salary > (select avg(e2.Salary) as AverageSalary  from #Employees e2  where  e2.DepartmentID = e.DepartmentID);


--second option
SELECT  Distinct e.FirstName, e.LastName, e.Salary, e.DepartmentID
FROM #Employees e
JOIN #Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM #Employees e2
    WHERE e2.DepartmentID = e.DepartmentID
);


--6. query to get the count of employees in each department using a subquery. Return the result right after each employee

select * from #Employees
select * from #Departments

SELECT Distinct
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    COUNT(*) OVER (PARTITION BY d.DepartmentName) AS EmployeeCount 
FROM #Employees e 
JOIN #Departments d ON e.DepartmentID = d.DepartmentID;

--7.Find the person who gets the minimum salary

select * from #Employees

SELECT 
    e.FirstName,
    e.LastName,
    e.Salary
FROM #Employees e
WHERE e.Salary = (SELECT MIN(e2.Salary) FROM #Employees e2);


--8.all employees who work in departments where the average salary is greater than $65,000

select * from #Employees
select * from #Departments

SELECT Distinct e.FirstName,
       e.LastName,
       d.DepartmentName,
       e.Salary
FROM #Employees e
JOIN #Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 65000
  AND e.Salary > (
      SELECT AVG(e2.Salary)
      FROM #Employees e2
      WHERE e2.DepartmentID = e.DepartmentID
  );


  --9.employees who were hired in the last 3 years from the last hire_date


  select * from #Employees

  SELECT FirstName, LastName, HireDate
FROM #Employees
WHERE HireDate >= (
    SELECT DATEADD(YEAR, -3, MAX(HireDate))
    FROM #Employees
);

--10. is anyone earning more than or equal to $80000, return all employees from that department




SELECT distinct e.FirstName, e.LastName, e.Salary, d.DepartmentName
FROM #Employees e
JOIN #Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary >= (
    SELECT MIN(e2.Salary) 
    FROM #Employees e2
    WHERE e2.Salary >= 80000
);


--11.Return the employees who earn the most in each department



SELECT distinct e.FirstName, e.LastName, e.Salary, d.DepartmentName
FROM #Employees e
JOIN #Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (
    SELECT MAX(e2.Salary)
    FROM #Employees e2
    WHERE e2.DepartmentID = e.DepartmentID
);


--12.names of the latest hired employee in each deparmtent. Return Departmentname, Firstname, Lastname, and hire date


select Distinct e.FirstName,e.LastName,d.DepartmentName,e.HireDate
from #Employees e 
join #Departments d on e.DepartmentID=d.DepartmentID
where e.HireDate =(select max(e2.HireDate) as LastHireDate from #Employees e2 where e2.DepartmentID=e.DepartmentID);

--13.average salary for employees in each department based on its location. Return the Location, DepartmentName, and AverageSalary



SELECT DISTINCT 
    d.Location,
    d.DepartmentName,
    (
        SELECT AVG(e2.Salary)
        FROM #Employees e2
        WHERE e2.DepartmentID = d.DepartmentID
    ) AS AverageSalary
FROM #Departments d
JOIN #Employees e ON e.DepartmentID = d.DepartmentID
ORDER BY d.Location, d.DepartmentName;



--14.Check if there is anyone who gets the same as the average salary. If so, return everyone from that department



SELECT distinct
    e.FirstName,
    e.LastName,
    e.Salary,
    d.DepartmentName
FROM #Employees e
JOIN #Departments d ON e.DepartmentID = d.DepartmentID  
WHERE e.DepartmentID IN (
    SELECT e2.DepartmentID
    FROM #Employees e2
    WHERE e2.Salary = (
        SELECT AVG(e3.Salary)
        FROM #Employees e3
        WHERE e3.DepartmentID = e2.DepartmentID
    )
);

--15.List all departments that have fewer employees than the overall average number of employees per department.




SELECT 
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM #Departments d
JOIN #Employees e ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) < (
    SELECT AVG(EmployeeCount) 
    FROM (
        SELECT COUNT(e2.EmployeeID) AS EmployeeCount
        FROM #Employees e2
        GROUP BY e2.DepartmentID
    ) AS DepartmentCounts
);

--16.Retrieve the names of employees who do not work in the department with the highest average salary.




SELECT distinct e.FirstName, e.LastName,e.Salary
FROM #Employees e
WHERE e.DepartmentID <> (
    SELECT TOP 1 e2.DepartmentID
    FROM #Employees e2
    GROUP BY e2.DepartmentID
    ORDER BY AVG(e2.Salary) DESC
);


--17.Create a query that returns the names of departments that do have employees using the EXISTS clause

select * from #Employees
select * from #Departments


SELECT distinct d.DepartmentName
FROM #Departments d
WHERE EXISTS (
    SELECT 1
    FROM #Employees e
    WHERE e.DepartmentID = d.DepartmentID
);

--18.Return departments which have more seniors than juniors. Juniors are those who have work experience less than 3 years, seniors more than 3 years. Consider the latest hire_date to calculate the years of experience




SELECT d.DepartmentName
FROM #Departments d
JOIN #Employees e ON e.DepartmentID = d.DepartmentID
WHERE (
    SELECT COUNT(*) 
    FROM #Employees e2
    WHERE e2.DepartmentID = d.DepartmentID 
    AND DATEDIFF(YEAR, e2.HireDate, GETDATE()) > 3  -- Seniors: Experience > 3 years
) > (
    SELECT COUNT(*) 
    FROM #Employees e2
    WHERE e2.DepartmentID = d.DepartmentID 
    AND DATEDIFF(YEAR, e2.HireDate, GETDATE()) < 3  -- Juniors: Experience < 3 years
)
GROUP BY d.DepartmentName;

--19.Return employees of the department with the most number of people




SELECT distinct e.FirstName, e.LastName, d.DepartmentName
FROM #Employees e
JOIN #Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID = (
    SELECT TOP 1 e2.DepartmentID
    FROM #Employees e2
    GROUP BY e2.DepartmentID
    ORDER BY COUNT(e2.EmployeeID) DESC
);


--20.For each department, find the difference between the highest and lowest salaries */


select * from #Employees
select * from #Departments


SELECT DISTINCT d.DepartmentName,
       (SELECT MAX(e1.Salary) - MIN(e1.Salary)
        FROM #Employees e1
        WHERE e1.DepartmentID = d.DepartmentID) AS SalaryDifference
FROM #Departments d
WHERE (SELECT MAX(e1.Salary) - MIN(e1.Salary)
        FROM #Employees e1
        WHERE e1.DepartmentID = d.DepartmentID) IS NOT NULL;

--21. Find all project names that have no employees assigned as leads. Return the ProjectName.


SELECT p.ProjectName
FROM Projects p
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeProject ep
    WHERE ep.ProjectID = p.ProjectID
    AND ep.Role = 'Lead'
)


--22.Retrieve names of employees who earn more than the average salary of all employees involved in the projects they are working on. Return FirstName, LastName, Salary


SELECT e.FirstName, e.LastName, e.Salary
FROM Employees e
JOIN EmployeeProject ep ON e.EmployeeID = ep.EmployeeID
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employees e2
    JOIN EmployeeProject ep2 ON e2.EmployeeID = ep2.EmployeeID
    WHERE ep2.ProjectID = ep.ProjectID
);


--23.List all projects where there is only one member is assigned





SELECT p.ProjectName
FROM Projects p
WHERE (SELECT COUNT(ep.EmployeeID)
       FROM EmployeeProject ep
       WHERE ep.ProjectID = p.ProjectID) = 1;

	   --24.Find the project with the highest budget and show the difference of it with other projects


SELECT 
    ProjectName,
    Budget,
    (SELECT MAX(Budget) FROM Projects) - Budget AS BudgetDifference
FROM Projects;


--25.Identify projects where the total salary of employees assigned as leads exceeds the average salary of all lead employees across all projects */

	   select * from Employees
select * from Projects
select * from EmployeeProject




SELECT 
    p.ProjectName
FROM Employees e
JOIN EmployeeProject ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects p ON ep.ProjectID = p.ProjectID
WHERE ep.Role = 'Lead'
GROUP BY p.ProjectName
HAVING SUM(e.Salary) > (
    SELECT AVG(e2.Salary)
    FROM Employees e2
    JOIN EmployeeProject ep2 ON e2.EmployeeID = ep2.EmployeeID
    WHERE ep2.Role = 'Lead'
);

