


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    ManagerID INT,  -- This can reference EmployeeID if managers are employees
    Location VARCHAR(50),
    Budget DECIMAL(12,2),
    Status VARCHAR(20)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,  -- Increased length & ensured uniqueness
    PhoneNumber VARCHAR(20),  -- Added Phone Number column
    HireDate DATE NOT NULL,
    DepartmentID INT,
    PositionID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

create table Positions (
PositionID int primary key,
PositionName varchar(50),
MinimumSalary decimal(10,2),
MaximumSalary decimal(12,2),
DepartmentID int,
RequiredExperience int
foreign key (DepartmentID) references Departments(DepartmentID)
)

create table Salaries (
SalaryID int primary key,
EmployeeID int,
SalaryAmount decimal(12,2),
Bonus decimal(3,2),
PaymentDate date,
TaxAmount decimal(10,2),
NetSalry decimal(12,2),
foreign key (EmployeeID) references Employees(EmployeeID)
)


create table Attendance (
AttendanceID int primary key,
EmployeeID int,
[Date] date,
Check_in_time time,
Check_out_time time,
Total_Hours_Worked numeric,
OvertimeHours numeric,
[Status] varchar(20),
foreign key (EmployeeID) references Employees (EmployeeID)
)

create table Workshifts (
ShiftID int primary key,
ShiftName varchar(50),
SHiftType VARCHAR(30),
[STATUS] varchar(40)
)

create table Employees_Workshifts (
EmployeeID int,
ShiftID int,
foreign key (EmployeeID) references Employees(EmployeeID),
foreign key (ShiftID) references Workshifts(ShiftID)
)

create table EmployeeShifts (
ID int primary key,
EmployeeID int,
ShiftID int,
AssignedDate date,
[Status] varchar(20)
)

create table Employees_EmployeeShifts (
EmployeeID int,
ID int,
foreign key (EmployeeID) references Employees(EmployeeID),
foreign key (ID) references EmployeeShifts(ID)
)

create table PerformanceReviews(
ReviewID int primary key,
EmployeeID int,
ReviewDate date,
PerformanceScore numeric,
Comments text,
foreign key (EmployeeID) references Employees(EmployeeID)
)


