--DDL(data definition language) is used for database management and modification of its structures.
-- Alter command-modifies database structures.
--Create command-creates a new database object.
--DML(data manipulation language)- it is used to manage and manipulate data within data object.
--Insert command-adds a new record to a table.
--Delete command-removes a record from the table.

select * from sys.databases;
create database employees_db;

use employees_db;
GO
create schema employees1;

select * from employees_db.information_schema.tables
create table employees_db.employees1.employees(
employee_id INT identity(1,1) primary key,
employee_name varchar(50),
employee_salary decimal(10,2)
)
select * from employees_db.employees1.employees;

insert into employees_db.employees1.employees
(employee_name,employee_salary)
values
('Kamran','3000')
DBCC checkident ('employees_db.employees1.employees',reseed,0);
update employees_db.employees1.employees
set employee_salary = 4000.00
where employee_id = 1;
delete from employees_db.employees1.employees 
where employee_id = 2;

--Delete- is used for removing specific rows in the table but keeps its structure and schema untouched

--Truncate-is applied to remove all rows in the table but does not touch to its structure

--Drop-removes the whole table and its structure as well

ALTER TABLE employees1.employees
add department varchar(50);
 ALTER TABLE employees1.employees
 ALTER COLUMN employee_name varchar(100);
 GO

select * from sys.databases;

create database company_db;
create schema company_schema;

select * from company_db.information_schema.tables

create table company_schema.Departments(
department_id INT identity (1,1) primary key,
department_name varchar(100),
employee_id INT references company_schema.employees(employee_id) on delete set null on update cascade,
location varchar(100),
)
use company_db;
create table company_schema.employees(
employee_id INT identity (1,1) primary key,
hire_date date,
position varchar(100),
employee_salary decimal(10,2),
)
drop table company_schema.departments;
GO
create table company_schema.departments (
department_id INT identity(1,1) primary key,
department_name varchar(100),
employee_id INT,
location varchar(100),
foreign key (employee_id) references company_schema.employees(employee_id)
on delete set null
on update cascade
)
select * from company_db.information_schema.tables
 alter table company_schema.employees
 add employee_salary decimal(10,2);
 alter table company_schema.departments
 add employee_salary decimal(10,2);

 insert into company_schema.employees
 (hire_date,position,employee_salary)
 values
 ('2022-02-02','Operations lead','9000')
 insert into company_schema.departments
 (department_name,employee_id,location)
 values
 ('Marketing','5','Houston')
 select * from company_schema.Departments;
 update company_schema.departments
 set department_name = 'Management'
where employee_salary > 5000
delete from company_schema.employees;
select * from company_schema.employees;
-- both varchar and nvarchar are used to store string data but there are some differences
--varchar uses less storage than nvarchar
--varchar supports only English language&Latin based countries while nvarchar is multilingual datas.

alter table company_schema.employees
alter column employee_salary float;
alter table company_schema.departments
drop column department_name;

select * from information_schema.columns


create table company_schema.Cars (
car_id int identity(1,1) primary key,
car_price decimal(10,2),
car_color varchar(50),
)
insert into company_schema.cars
(car_price,car_color)
values
('21346.45','white')
 drop table company_schema.departments;

 create database customer_db;
 create schema operations;
 select * from customer_db.information_schema.tables
 create table operations.customers (
 customer_id int identity(1,1) primary key,
 customer_name varchar(100),
 age int not null check (age < 18),
 phone_number varchar(30)
 )
 select * from operations.customers;
 create table company_schema.salary_history (
 serial_id int identity(1,1) primary key,
 employee_id int not null,
 salary decimal(10,2),
 increase_date date not null,
 FOREIGN KEY (employee_id) REFERENCES company_schema.employees(employee_id) ON DELETE CASCADE
 )

DELETE FROM company_schema.employees
WHERE employee_id NOT IN (
    SELECT DISTINCT employee_id 
    FROM company_schema.salary_history
    WHERE increase_date > DATEADD(YEAR, -2, GETDATE())
	)
	select * from company_schema.employees;
create procedure company_schema.InsertEmployee
exec company_schema.Insertemployee
employee_id =123,
@first_name = 'Kamran',
@last_name = 'Matnazarov',
@age = 21,
@position = 'data analyst',
@hire_date = '2023-05-25',

select * from information_schema.routines
insert into company_schema.employees 
(hire_date,position,employee_salary,JoinDate)
values
('2023-05-03','Data analyst','6000','2023-05-03')

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'employees' AND TABLE_SCHEMA = 'company_schema';

create procedure company_schema.InsertEmployee
@hire_date date,
@position varchar(100),
@employees_salary decimal(10,2),
@JoinDate date,

insert into     company_schema.employees (hire_date,position,employees_salary,JoinDate)
values    (@hire_date,@position,@employee_salary,@JoinDate)

SELECT * FROM INFORMATION_SCHEMA.ROUTINES 

 create procedure company_schema.InsertEmployee
 @hire_date date,
 @position varchar(100),
 @employee_salary decimal(10,2),
 @JoinDate date
 AS        -- required before defining the procedure body
 BEGIN      -- required when multiple statements are used
 insert into company_schema.employees(hire_date,position,employee_salary,JoinDate)
 values  (@hire_date,@position,@employee_salary,@JoinDate);
 Print 'Employee inserted successfully!';
 END
 SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'InsertEmployee';
 exec company_schema.InsertEmployee
 @hire_date = '2023-05-03',
 @position = 'Data Analyst',
 @employee_salary = 6000,
 @JoinDate = '2023-05-03';
 SELECT * FROM company_schema.employees ORDER BY employee_id DESC;
 ALTER PROCEDURE company_schema.InsertEmployee
    @hire_date DATE,
    @position VARCHAR(100),
    @employee_salary DECIMAL(10,2),
    @JoinDate DATE  
AS  
BEGIN  
    -- Check if the employee already exists
    IF NOT EXISTS (
        SELECT 1 FROM company_schema.employees
        WHERE hire_date = @hire_date 
        AND position = @position 
        AND employee_salary = @employee_salary 
        AND JoinDate = @JoinDate
    )
    BEGIN
        INSERT INTO company_schema.employees (hire_date, position, employee_salary, JoinDate)
        VALUES (@hire_date, @position, @employee_salary, @JoinDate);

        PRINT 'Employee inserted successfully!';
    END
    ELSE
    BEGIN
        PRINT 'Duplicate entry: Employee already exists!';
    END
END;
EXEC company_schema.InsertEmployee 
    @hire_date = '2022-05-25',
    @position = 'HR specialist',
    @employee_salary = 6000,
    @JoinDate = '2022-05-25';
	SELECT * FROM company_schema.employees ORDER BY employee_id DESC;
SELECT * INTO company_schema.Employees_Backup
FROM company_schema.employees
WHERE 1 = 0;
SELECT * FROM company_schema.Employees_Backup;

MERGE INTO company_schema.employees AS target
USING company_schema.New_Employees AS source
ON target.employee_id = source.employee_id  

WHEN MATCHED THEN
    UPDATE SET
        target.hire_date = source.hire_date,
        target.position = source.position,
        target.employee_salary = source.employee_salary,
        target.JoinDate = source.JoinDate

WHEN NOT MATCHED THEN
    INSERT (employee_id, hire_date, position, employee_salary, JoinDate)
    VALUES (source.employee_id, source.hire_date, source.position, source.employee_salary, source.JoinDate);

	IF EXISTS (SELECT name FROM sys.databases WHERE name = 'company_db')
BEGIN
    ALTER DATABASE CompanyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;  -- Close active connections
    DROP DATABASE CompanyDB;
    PRINT 'company_db dropped successfully!';
END
ELSE
    PRINT 'company_db does not exist.';

-- Recreate the database
CREATE DATABASE CompanyDB;
PRINT 'company_db created successfully!';
CREATE DATABASE company_db;
PRINT 'Database company_db created successfully!';
SELECT name FROM sys.databases WHERE name = 'company_db';
CREATE TABLE StaffMembers (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    hire_date DATE,
    position VARCHAR(100),
    employee_salary DECIMAL(10,2),
    JoinDate DATE
);
PRINT 'Table StaffMembers created successfully!';
-- Check if the database exists
SELECT name FROM sys.databases WHERE name = 'company_db';

-- Check if the table exists
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo';

--Referential operations called CASCADE DELETE and CASCADE UPDATE are applied to foreign keys in SQL Server to automatically handle modifications to parent-child relationships across tables.
-- Cascade delete is common in  One-to-Many relationships: when a parent is deleted, the associated child records are also deleted.
--When primary keys in the parent table might change (rare scenario).
delete from company_schema.employees;
SELECT * 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '%employees%';

create table company_schema.employees (
employee_id int Identity(1,1) primary key,   -- primary key
email varchar(150) unique,   --unique constraint
employee_name varchar(200),
hire_date date,
)
