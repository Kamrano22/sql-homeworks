-----------Easy-level tasks----------------
--TASK1---
 select product_name as Name
 from products;
 --TASK2---
 select customer_name as Client
 from products;
 --Task3--
create table products_discontinued (
product_id int primary key,
ProductName varchar(200),
ProductPrice decimal(10,2),
CustomerName varchar(200)
)
insert into products_discontinued (product_id,ProductName,ProductPrice,CustomerName)
values (1,'bicycle',250000,'Anvar')

select product_name from products
Union
select ProductName from products_discontinued;

--Task4--
select product_id from products
intersect                                      ------here i used product_id to find the intersection between two tables
select product_id from products_discontinued;
---Task5--
alter table orders
add  order_name varchar(200),order_amount varchar(200),location varchar(200);

insert into orders (order_id,order_date,order_name,order_amount,location)
values (5,'2025-02-25','yoga_mat',2,'NewYork');

select order_id,order_name,location from orders
union all
select product_id,product_name,city from products;

--Task6--
create table sales (
sales_id int primary key,
customer_name varchar(200),
customer_country varchar(150)
)

insert into sales (sales_id,customer_name,customer_country)
values(10,'Al-Muntari','Qatar')

select distinct
customer_name,
customer_country
from sales;

---task7--
select product_price,
case
when product_price > 100000 then 'High'
when product_price <= 100000 then 'Low'

END AS price_category

from products;

---Task8---
create table employee1 (
employee_id int primary key,
employee_name varchar(200),
employee_department varchar(200),
country varchar(200)
)
insert into employee1 (employee_id,employee_name,employee_department,country)
values(6,'Asadbek','Marketing','Qatar')

select country ,COUNT(*) as employee_count
from employee1
 where employee_department = 'HR'
 group by country;
 --task9--
 select category ,count(product_id) as product_count
from products
group by category;
--task10--
select 
stock,
IIF (stock >= 100, 'Yes','No') as stock_count
from products;
----------------------MEDIUM-level task--------------------
--task 11

create table customer (
customer_id int primary key,
customer_name varchar(200),
customer_age int
)
insert into customer (customer_id,customer_name,customer_age)
values(5,'Anvar',21)

select 
order_id,
order_date,
order_name,
order_amount,
location,
customer_name as clientName,
customer_age
from orders as orders
inner join customer as customer 
on order_id = customer_id;

--task12--

 create table out_of_stock (
 out_of_stock_id int primary key,
 product_id int not null,
 product_name varchar(200)
 )

 insert into out_of_stock (out_of_stock_id,product_id,product_name)
 values(105,5,'smartwatch')

 select product_name from products
 union
 select product_name from out_of_stock;
 --Task13--

 select product_id,product_name,product_price,customer_name from products
 except
 select product_id,ProductName,ProductPrice,CustomerName from products_discontinued;
 
 ---task14--
 alter table customer
 add order_placed int;

select * from customer;
insert into customer (customer_id,customer_name,customer_age,order_placed)
values(9,'Mir Ali',21,9)

select 
isnull(order_placed,4) as order_placed
from customer;

select 
order_placed,
iif(order_placed > 5,'Eligible','Not Eligible') as category
from customer;

---Task15----
select 
product_price,
iif(product_price > 100, 'Expensive','Affordable') as category
from products;
---Task16--
select order_placed ,count(customer_id) as orderplaced
from customer
group by order_placed;

---task17--
select * from employees
where age < 25 or employee_salary > 6000;
--task18-
alter table sales
add total_sales decimal(12,2);

insert into sales(sales_id,customer_name,customer_country,total_sales)
values(14,'Shixnazar','Uzbekistan',400000);

select 
isnull(total_sales,100000) as total_sales
from sales;

select total_sales, count(sales_id) as salesamount
from sales
where total_sales is not null   --ignore null values
group by total_sales;

--task19---
select
customer_id,
customer_name,
customer_age,
order_placed,
order_id,
order_name,
order_amount,
location,
customerID,
order_date as orderdate
from customer as order
left join order as order
on customer_id = order_id;

--task20--
IF EXISTS (SELECT 1 FROM employees WHERE department = 'HR')
BEGIN
    UPDATE employees
    SET employee_salary = employee_salary * 1.10
    WHERE department = 'HR';
END;
select * from employees;

----HARD-LEVEL tasks-----------------
--task21--
select* from sales;


create table returns (
product_id int primary key,
product_name varchar(200),
total_returns decimal(12,2),
location varchar(150)
)

insert into returns (product_id,product_name,total_returns,location)
values(4,'bicycle',5000,'Urgench')

select sales_id,customer_name,customer_country,sum(total_sales) as total_sales,sum(0)as total_returns
from sales
group by sales_id,customer_name,customer_country

Union all

select product_id,product_name,location, sum(0) as total_sales,sum(total_returns) as total_returns
from returns
group by product_id,product_name,location;

--task22---
select productName from products_discontinued
intersect
select product_name from products;
--task23---
select total_sales as Sales,

case

when total_sales >10000 then 'Top Tier'
when total_sales between 5000 and 10000 then 'Mid Tier'
when total_sales < 5000 then 'Low Tier'
end as category
from sales; 

---task25---

create table invoice (
invoice_id int primary key,
customer_id int,
invoice_date date
)

insert into invoice (invoice_id,customer_id,invoice_date)
values(4,104,'2025-03-10')

 select customer_id,customer_name
 from customer
 where customer_id in(select customer_id from customer  except select customer_id from invoice);



--Task26--
 alter table sales
 add customer_id int,
 product_id int,
 region varchar(200);

 insert into sales (sales_id,customer_name,customer_id,product_id,region)
 values(20,'Sevara',110,210,'Urgench')

 select * from sales;

 select 
 customer_id,
 product_id,
 region,
 sum(total_sales) as total_sales
 from sales
 group by customer_id,product_id,region;

 --task27---
create table sales1 (
sales_id int primary key,
quantity int
)

insert into sales1 (sales_id,quantity)
values(120,30)

select 
quantity,
case 
when quantity > 100 then '50%'
when quantity between 50 and 90 then '15%'
when quantity between 20 and 49 then '5%'
end as Discount
from sales1;

--task28--

select product_name from products
union all
select productName from products_discontinued;

select product_name from  products  
inner join products_discontinued 
on products.product_id =products_discontinued.product_id;

select * from products_discontinued;
--task29--
select 
product_id,
product_name,
stock,
iif(stock > 0,'Available','Out of Stock') as stockstatus
from products;
---task 30---

create table VIP_customers (
customer_id int primary key,
customer_name varchar(200)
)

insert into VIP_customers (customer_id,customer_name)
values(38,'Asadbek')

select customer_id,customer_name from customer
except
select customer_id,customer_name
from VIP_customers;