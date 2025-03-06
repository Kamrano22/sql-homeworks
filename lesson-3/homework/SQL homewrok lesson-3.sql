-- BUlk insert is used to quickly insert large amounts of data into a table efficiently.It is much better and faster than regular INSERT command because it minimizes logging and optimizes performance.
-- while Insert command inserts one value each time Bulk insert insert larger datas faster,efficiently which saves more time.

--SQL can import variouse file formats.For example, (1)csv(comma-seperated values).(2)Excel files.(3)JSON(javascript notation).(4)XML(extensile Markup Language).

use customer_db;
select * from information_schema.tables;

create schema sales;
create table products (
product_id int primary key,
product_name varchar(50) unique,
product_price decimal(10,2)
)
select * from products;
insert into products (product_id,product_name,product_price)
values (2,'Dragon Fruit', 25) 


--Null represents the absence of a value(unknown or missing data).It allows (null) values in the column.It is used when a value might not always be available.
--for example  (1)id int primary key,(id can not be null) (2) name varchar(50) can not be null  (3)  email varchar(100)  can be null(left empty)

--Not Null-it ensures that a column should always have a values otherwise it will be error.Always contain a definite value in the column.Used when a value required for each column.
-- employee_id int primary key,  - not null(employee_id must have a value) 
-- employee_name varchar(100),   - not null(employee_name should contain names of employees)

drop table products;

select * from products
where product_price > 25;    -- this query selects products whose prices are higher than 25.00

create table categories (
CategoryID int primary key,
CategoryName varchar(100) unique
)

--The Identity column in SQL server is used to generate auto-incrementing values for a table's primary key or other unique columns.It automatically assigns a sequential numeric value to each new row inserted into the table.
-- id int identity(1,1) primary.This command will put numeric values into the id column.In this case we do not have to put numbers by hand.

select * from information_schema.tables;

create table employees (
employee_id int primary key,
employee_name varchar(100),
employee_department varchar(250),
employee_salary decimal(10,2)
)
select * from employees;

BULK INSERT employees
from 'C:\Users\munnaboy\Desktop\HW-9.csv'
with (
fieldterminator = ',',
rowterminator = '\n',
firstrow = 2
)

SELECT product_id, product_name, product_price
FROM Products
FOR XML AUTO, ROOT('Products');

drop table categories;



create table categories (
CategoryID int primary key,
CategoryName varchar(100) unique
)

drop table products;

create table products (
ProductID int primary key,
ProductName varchar(50) unique,
CategoryID int,
ProductPrice decimal(10,2)
foreign key (CategoryID) references categories(CategoryID)
)

select * from information_schema.tables;

--Differences between Primary key and Unique key--

--Primary key ensures that each row is unique
--Unique key ensures values are unique but allows multiple values
--Primary key does not allow null values
--Unique key allows multiple unique keys
--Primary key is used to uniquely identify a row in a table.
--Unique key used to prevent duplicate values in a column

alter table products
add constraint CHK_ProductPrice check (ProductPrice > 0);
select * from products;

SELECT ProductID, ProductName, CategoryID, ProductPrice
FROM Products
FOR JSON AUTO, ROOT('Products');

select * from products;
alter table products
add Stock Int not null;

select * from categories;
create table sales (
product_id int primary key,
quantity_sold int null,
product_name varchar(50)
)
insert into sales (product_id,quantity_sold,product_name)
values (4,null,'book')
select * from sales;

SELECT product_id, product_name, ISNULL(quantity_sold, 0) AS quantity_sold 
FROM sales;


--Purpose of Foreign key
--Maintains integrity(prevents invalid data from being inserted into child tabel)
--Referential integrity(the child table can only contain values that exist in the parent table)
--supports relational database design(helps structure data in a 1:M or M:M relationships)