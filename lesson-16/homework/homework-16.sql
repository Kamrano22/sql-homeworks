------EASY LEVEL TASKS----------------

--TASK-1
create view vwStaff 
as 
select StaffID,Position,Department,Salary
from Staff

--TASK-2

create view vwItemPrices
as 
select ProductName,Price 
from Items
group by ProductName,Price;

--TASK-3

CREATE table  #TempPurchases (
PurchaseID int primary key,
PurchaseDate date,
TotalCost decimal (12,2)
)
insert into  #TempPurchases values(1,'2025-04-01',250000),
(2,'2025-04-01',300000),
(3,'2025-03-01',2000000);


--task-4
select * from Sales

declare @currentRevenue  table 
(TotalAmount decimal(12,2),SaleDate date)

insert  @currentRevenue

select TotalAmount,SaleDate 
from Sales;

select* from @currentRevenue
where YEAR(SaleDate) = YEAR(GETDATE())
    AND MONTH(SaleDate) = MONTH(GETDATE())

--task-5
--Write a scalar function named fnSquare that accepts a numeric input and returns its square.

CREATE FUNCTION dbo.fnSquare
(
    @inputNumber NUMERIC(18,0)
)
RETURNS NUMERIC(18,0)
AS
BEGIN
    RETURN @inputNumber * @inputNumber;
END;

SELECT dbo.fnSquare(5) AS 'SquareOf5';


--task-6



create proc spGetClients 
as 
begin 
select ClientName,ClientID from Clients
end


--TASK-8
CREATE table #StaffInfo (
Staff_ID int primary key,
StaffName varchar(20),
Position varchar(50),
Department varchar(50)
)

insert into #StaffInfo values (1,'Mir Ali','Sales Manager','Sales'),
(2,'Aziz','CEO','Management'),
(3,'Azizbek','Sales Manager','Sales'),
(4,'Kamran','Supervisor','Operations');

--task-9

CREATE FUNCTION dbo.fnEvenOdd
(
    @number INT
)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @result VARCHAR(10)

    IF @number % 2 = 0
        SET @result = 'Even'
    ELSE
        SET @result = 'Odd'

    RETURN @result
END
SELECT dbo.fnEvenOdd(15) AS Result
--task-10


CREATE PROCEDURE spMonthlyRevenue
AS
BEGIN
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM-dd') AS SaleDate,
        SUM(Quantity * UnitPrice) AS TotalRevenue
    FROM 
        Sales 
    WHERE 
        YEAR(SaleDate) = 2024
        AND MONTH(SaleDate) = 6  -- June is month 6
    GROUP BY 
        SaleDate
    ORDER BY 
        SaleDate;
END


--TASK-11

select * from vwRecentItemSales 
-- total sales per item for the last month

CREATE VIEW vwRecentItemSales 
AS
SELECT 
    p.ProductID,
    p.ProductName,  -- Added product name for better readability
    SUM(s.Quantity * p.Price) AS TotalSales,
    COUNT(*) AS NumberOfTransactions
FROM 
    Products p
JOIN 
    Sales s ON p.ProductID = s.ProductID
WHERE 
    s.SaleDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY 
    p.ProductID,
    p.ProductName;

	select * from Sales
	select * from Products
	--task-12

DECLARE @currentDate DATE = GETDATE();

PRINT 'The current date is: ' + CONVERT(VARCHAR(10), @currentDate, 120);

	--TASK-13

	--items with quantities greater than 100 from the Items table

CREATE VIEW vwHighQuantityItems
AS
SELECT 
    ProductName,
    StockQuantity
FROM 
    Items
WHERE 
    StockQuantity > 100;
	

	--TASK-14
	
	CREATE TABLE #OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
	CustomerName varchar(50),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL
	)
	INSERT INTO #OrderDetails (CustomerName, OrderID, ProductID, Quantity)
VALUES
-- Order #1001 (John Smith)
('John Smith', 1001, 5, 2),   -- 2 Coffee Mugs
('John Smith', 1001, 12, 1),  -- 1 Water Bottle

-- Order #1002 (Sarah Johnson)
('Sarah Johnson', 1002, 3, 5),   -- 5 Notebooks
('Sarah Johnson', 1002, 7, 2),    -- 2 Staplers
('Sarah Johnson', 1002, 19, 3),   -- 3 Notepads

-- Order #1003 (Michael Brown)
('Michael Brown', 1003, 1, 1),    -- 1 Wireless Mouse
('Michael Brown', 1003, 2, 1),     -- 1 Mechanical Keyboard

-- Order #1004 (Emily Davis)
('Emily Davis', 1004, 6, 1),      -- 1 Bluetooth Speaker
('Emily Davis', 1004, 9, 2),       -- 2 Wireless Chargers

-- Order #1005 (David Wilson)
('David Wilson', 1005, 4, 1),     -- 1 Desk Lamp
('David Wilson', 1005, 8, 1),      -- 1 Backpack
('David Wilson', 1005, 11, 1),     -- 1 Desk Organizer

-- Order #1006 (Jessica Lee)
('Jessica Lee', 1006, 14, 10),    -- 10 Paper Clips boxes
('Jessica Lee', 1006, 16, 1),      -- 1 External SSD

-- Order #1007 (Robert Taylor)
('Robert Taylor', 1007, 10, 5),    -- 5 Whiteboard Markers
('Robert Taylor', 1007, 13, 2),     -- 2 HDMI Cables

-- Order #1008 (Jennifer Clark)
('Jennifer Clark', 1008, 15, 1),   -- 1 Monitor Stand
('Jennifer Clark', 1008, 17, 1),    -- 1 Desk Chair

-- Order #1009 (Thomas Martinez)
('Thomas Martinez', 1009, 18, 2),  -- 2 USB Flash Drives

-- Order #1010 (Lisa Anderson)
('Lisa Anderson', 1010, 20, 1);  

select * from #OrderDetails
select * from Products

select o.CustomerName,p.ProductName,o.OrderID
from #OrderDetails o 
join Products p on o.ProductID = p.ProductID;


--task-15
EXEC spStaffDetails @StaffID = 10;

create proc spStaffDetails 
@StaffID int
as 
begin

select FirstName+''+LastName as StaffName,Department from Staff 

end


--task-16

--Write a simple function fnAddNumbers that takes two numeric parameters and returns their sum.

CREATE FUNCTION dbo.fnAddNumbers
(
    @number1 NUMERIC(15,2),
    @number2 NUMERIC(15,2)
)
RETURNS NUMERIC(15,2)
AS
BEGIN
    DECLARE @sum NUMERIC(15,2)
    SET @sum = @number1 + @number2
    RETURN @sum
END;

SELECT dbo.fnAddNumbers(10.25, 20.75) AS Result



--task-17

CREATE TABLE #NewItemPrices (
 ProductID INT PRIMARY KEY,
NewPrice DECIMAL(10,2) NOT NULL
);

INSERT INTO #NewItemPrices (ProductID, NewPrice)
VALUES
    (1, 27.99),   -- Wireless Mouse price increase
    (3, 3.99),    -- Notebook price increase
    (5, 11.99),   -- Coffee Mug price decrease
    (7, 7.99),    -- Stapler price decrease
    (12, 19.99);  

	MERGE INTO Items AS target
USING #NewItemPrices AS source
ON (target.ItemID = source.ProductID)
WHEN MATCHED THEN
    UPDATE SET 
        target.Price = source.NewPrice;


	--TASK-18

	--staff names along with their salaries.
	create view  vwStaffSalaries 
	as 
	select 
	FirstName,Salary
	from Staff
	group by FirstName,Salary;


	--task-19

	select * from Clients
	

	select * from ClientPurchases


	CREATE PROCEDURE spClient1Purchases
AS
BEGIN
    SELECT 
        c.ClientName,
        cp.PurchaseID,
        cp.TotalAmount,
        cp.PurchaseDate
    FROM 
        Clients c
    JOIN 
        ClientPurchases cp ON c.ClientID = cp.ClientID
    WHERE 
        c.ClientID = 1
    ORDER BY 
        cp.PurchaseDate DESC;
END


--task20

CREATE FUNCTION dbo.fnStringLength
(
    @word VARCHAR(20)
)
RETURNS INT
AS
BEGIN
    DECLARE @length INT
    SET @length = LEN(@word)
    RETURN @length
END;

select dbo.fnStringLength ('Xorazmshox') as length

------------------------------------------MEDIUM LEVEL TASKS-------------------------
--task-1
-- purchases made by a specific client, including the purchase dates.

create view vwClientOrderHistory
as 
select c.FullName,p.PurchaseDate,p.PurchaseID
from Clients c
join Purchases p  on c.ClientID =p.ClientID
group by  c.FullName,p.PurchaseDate,p.PurchaseID;


select * from vwClientOrderHistory

--task-2

--item sales data for the current year

create table #YearlyItemSales (
ItemID int primary key,
SalesDate date,
SalesAmount int
);

insert into #YearlyItemSales values(1,'2025-04-10',50),
(2,'2025-04-05',100),
(3,'2025-03-01',45),
(4,'2025-03-15',30);

select * from #YearlyItemSales

--task-3


--task-5

DECLARE @avgItemSale TABLE 
(
    ItemID INT,
    SalesAmount DECIMAL(12,2)
);

INSERT INTO @avgItemSale (ItemID, SalesAmount)
SELECT 
    ItemID, 
    AVG(TotalAmount) AS AverageSaleAmount
FROM Purchases
GROUP BY ItemID;

SELECT * FROM @avgItemSale;


--stores the average sale amount for a particular item.


--task-6



CREATE PROCEDURE spDeleteOldPurchases
    @CutoffDate DATE  -- input date parameter
AS
BEGIN
    -- Delete purchases older than the cutoff date
    DELETE FROM Purchases
    WHERE PurchaseDate < @CutoffDate;
    PRINT CAST(@@ROWCOUNT AS VARCHAR) + ' purchase(s) deleted.';
END;

EXEC spDeleteOldPurchases @CutoffDate = '2024-01-01';


--task-7
select * from Purchases

CREATE FUNCTION fnCalcDiscount (@TotalAmount DECIMAL(12,2))
RETURNS TABLE
AS
RETURN (
    SELECT 
        @TotalAmount AS TotalAmount,
        -- Compute discount percentage based on the TotalAmount
        CASE 
            WHEN @TotalAmount >= 100 THEN @TotalAmount * 0.20
            WHEN @TotalAmount BETWEEN 50 AND 99.99 THEN @TotalAmount * 0.15
            WHEN @TotalAmount < 50 THEN @TotalAmount * 0.10
        END AS DiscountAmount
);

SELECT * 
FROM dbo.fnCalcDiscount(50);



--task-9

CREATE TABLE #SalaryUpdates (
    StaffID INT,
    NewSalary DECIMAL(10,2)
);

INSERT INTO #SalaryUpdates (StaffID, NewSalary) VALUES
(1, 3500.00),
(2, 4200.00),
(3, 3900.00);

MERGE INTO Staff AS Target
USING #SalaryUpdates AS Source
ON Target.StaffID = Source.StaffID
WHEN MATCHED THEN
    UPDATE SET Target.Salary = Source.NewSalary;

 --task-10
--total revenue per staff member by joining the Staff and Sales
 select * from Staff

select * from Revenue

create view vwStaffRevenue
as 
select sum(r.RevenueAmount) as TotalRevenue ,s.FirstName,s.StaffID
from Staff s
join Revenue r on s.StaffID = r.EmployeeID
group by s.StaffID,s.FirstName;


select * from vwStaffRevenue

--task-11

--Write a function fnWeekdayName that takes a date as input and returns the corresponding weekday.

CREATE FUNCTION fnWeekdayName (@date DATE)
RETURNS VARCHAR(20)
AS 
BEGIN 
    DECLARE @dayName VARCHAR(20);

    SET @dayName = DATENAME(WEEKDAY, @date);

    RETURN @dayName;
END;

SELECT dbo.fnWeekdayName('2025-04-10') as WeekName;

--task-12
select StaffID,FirstName,LastName,Position,Department
into #TempStaff
from Staff;

select * from #TempStaff

--task-13
--client's total number of purchases.
select * from Purchases

DECLARE @ClientPurchaseCount TABLE (
    ClientID INT,
    PurchaseCount INT
);

INSERT INTO @ClientPurchaseCount (ClientID, PurchaseCount)
SELECT ClientID, COUNT(PurchaseID)
FROM Purchases
GROUP BY ClientID;

SELECT * FROM @ClientPurchaseCount;

--task-14

CREATE PROCEDURE spClientDetails
    @ClientID INT
AS
BEGIN
    -- Select client details
    SELECT *
    FROM Clients
    WHERE ClientID = @ClientID;

    -- Select purchase history for that client
    SELECT *
    FROM Purchases
    WHERE ClientID = @ClientID;
END;

EXEC spClientDetails @ClientID = 3;

--task-16
create proc  spMultiply
@number1 numeric(12,2),
@number2 numeric(12,2)
as 
begin
declare @product int 
set @product= @number1 * @number2
return @product
end;

SELECT (2 * 15) AS Product;

--task-18
--staff and purchase data to show which staff members have fulfilled the most orders.


go 
CREATE VIEW vwTopPerformingStaff 
AS 
SELECT TOP 10
    s.StaffID,
    COUNT(p.PurchaseID) AS OrderCount,
    SUM(p.TotalAmount) AS TotalSalesAmount  
FROM 
    Staff s
JOIN 
    Purchases p ON s.StaffID = p.StaffID
GROUP BY 
    s.StaffID
ORDER BY 
    TotalSalesAmount DESC; 

select * from vwTopPerformingStaff 


--task-19

select * from Clients

create table #ClientDataTemp(
ClientID int primary key,
FullName varchar(50),
Email varchar(50),
Phone varchar(20)
);

INSERT INTO #ClientDataTemp (ClientID, FullName, Email, Phone)
VALUES 
(1, 'Mir Ali', 'mir.ali@email.com', '998901234570'),
(2, 'Kamron Valiyev', 'kamron.valiyev@email.com', '998901234562'),
(3, 'Umid Karimov', 'umid.karimov@email.com', '998901234563'),
(4, 'Rustam Tursunov', 'rustam.tursunov@email.com', '998901234564'),
(5, 'Anvar Saidov', 'anvar.saidov@email.com', '998901234565'),
(6, 'Nilufar Mamatova', 'nilufar.mamatova@email.com', '998901234566'),
(7, 'Zarina Rasulova', 'zarina.rasulova@email.com', '998901234567'),
(8, 'Jasur Akhmedov', 'jasur.akhmedov@email.com', '998901234568'),
(9, 'Shahzod Juraev', 'shahzod.juraev@email.com', '998901234569'),
(10, 'Malika Kadirova', 'malika.kadirova@email.com', '998901234570');

MERGE INTO Clients AS Target
USING #ClientDataTemp AS Source
ON Target.ClientID = Source.ClientID

WHEN MATCHED THEN
    UPDATE SET 
        Target.FullName = Source.FullName,
        Target.Email = Source.Email,
        Target.Phone = Source.Phone

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ClientID, FullName, Email, Phone)
    VALUES (Source.ClientID, Source.FullName, Source.Email, Source.Phone);

	select * from Clients


	--task-20
	select * from Purchases
	--top 5 best-selling items.


CREATE PROCEDURE spTopItems
AS
BEGIN
    SELECT TOP 5 
        ItemID,
        SUM(Quantity) AS TotalSold
    FROM Purchases
    GROUP BY ItemID
    ORDER BY TotalSold DESC;
END;

spTopItems 

	
