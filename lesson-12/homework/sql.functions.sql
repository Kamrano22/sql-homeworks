--EASY QUESTIONS-------
--TASK-1-----
select ascii('A')    --the result is 65

--TASK-2----
select LEN('Hello World')     --the length is 11 

--TASK-3-----
select reverse('OpenAI') 

--TASK-4---
-- --In SQL Server, we can use the REPLICATE function to add spaces before a string. To add 5 spaces before a string, I  used this function below

SELECT REPLICATE(' ', 5) + 'Hello' AS Result;   

--TASK-5----
--In SQL Server, we can remove leading spaces from a string using the LTRIM function.

SELECT LTRIM('   SQL Server') AS Result;  

--TASK-6----
SELECT UPPER('sql')

--TASK-7----
--left  extracts first 3 rows from the left-side of the string

SELECT LEFT('Database', 3) AS Result;

--TASK-8----

SELECT RIGHT( 'Technology',4)

--TASK-9----

SELECT SUBSTRING( 'Programming',3,6)

--TASK-10---

SELECT CONCAT('SQL','','SERVER')

--TASK-11----
SELECT replace( 'apple pie','apple','orange')


--TASK-12----

SELECT CHARINDEX( 'SQL','LearnSQL')

--TASK-13---
 -- WE can use the CHARINDEX function in SQL Server to check if a string contains a specific substring.

 SELECT CHARINDEX('er', 'Server') AS Position;     --The result says that from the 2 character er exists in this word

 --TASK-14---

 SELECT CONCAT_WS(' ','apple','orange','banana')     --to seperate them i just used concat_ws function


 --TASK-15----

 SELECT POWER(2,3)        --THE RESULT OF this function is eight because 2 in the third level is 8


 --TASK-16----

 SELECT SQRT(16)                 --SQUARE root of 16 is 4

 --TASK-17----

 -- here we can either use select sysdatetime or select current_timestamp

 SELECT SYSDATETIME()

 select   current_timestamp;


 --TASK-18--------

 SELECT GETUTCDATE()

 --TASK-19---

SELECT DAY('2025-02-03') AS DayOfMonth;

--TASK-20---
SELECT DATEADD(DAY,10,'2025-02-03') 

--------------------------MEDIUM QUESTIONS------------------

--TASK-1---

SELECT CHAR(65)                  --THE CHARACTER OF 65 IS 'A'

--TASK-2---

-- LTRIM- Removes leading spaces (spaces at the beginning of a string).

--RTRIM - Removes trailing spaces (spaces at the end of a string).

--TASK-3----

SELECT CHARINDEX('SQL','Learn SQL basics')      --the position of SQL is 7

--TASK-4-------

SELECT CONCAT_WS(' ','SQL','Server')

--TASK-5---

SELECT STUFF('test',1,4,'exam');

--TASK-6----

SELECT SQUARE(7);

--TASK-7---

SELECT LEFT( 'International',5);

--TASK-8---

SELECT RIGHT('Database',2);

--TASK-9-----
SELECT  Patindex('%n%', 'Learn SQL')            --THE RESULT IS 5.It is where n character stays


--TASK-10---

SELECT DATEDIFF(day,'2025-01-01','2025-02-03');   --the difference in days is 33 

--TASK-11----
select month('2025-02-03') as [Month];

--TASK-12---

SELECT DATEPART(YEAR,'2025-02-03') AS [YEAR];

--TASK-13--

 SELECT CAST(GETDATE() AS TIME) AS CurrentTime;   -- USING THIS FUNCTION IS ENOUGH FOR THE REQUIREMENT

 --TASK-14---

 -- the SYSDATETIME() function in SQL Server returns the current date and time, including the hours, minutes, seconds, and fractional seconds (milliseconds or nanoseconds depending on the precision).


 SELECT SYSDATETIME() AS CurrentDateTime;


 --task-15---

 --to  find the next occurrence of 'Wednesday' from today's date using Dateadd()  I wil use the function date add(day 
  
 select dateadd(week,1,'2025-04-02')           -- I took the upcoming wednesday and added just 1 week to get the next occurence ow wednesday

 --TASK-16----

 SELECT DATEDIFF(year,'2025-04-01 01:50:05.837','2025-03-31 20:50:31.690')
  SELECT DATEDIFF(HOUR,'2025-04-01 01:50:05.837','2025-03-31 20:50:31.690')


--TASK-17---

SELECT ABS(-15);

--TASK-18---

SELECT CEILING(4.57);

--TASK-19---

SELECT Current_Timestamp

--TASK-20---

SELECT DateName(DAY,'2025-02-03') as [Day];

-----------------DIFFICULT QUESTIONS-----------

--TASK-1--
SELECT REPLACE(REVERSE('SQL Server'), ' ', '') AS ReversedString;

--TASK-2---

SELECT STRING_AGG(City, ', ') AS AllCities
FROM Cities;

--TASK-3---

SELECT 
    CHARINDEX('SQL', 'SQL Server') AS Position_SQL,
    CHARINDEX('Server', 'SQL Server') AS Position_Server;

	--TASK-4--

	SELECT POWER(5,3)

	--TASK-5---
	SELECT value
FROM STRING_SPLIT('apple;orange;banana', ';');

--TASK-6---

SELECT TRIM(' SQL ')

--TASK-7---

SELECT DATEDIFF(HOUR,'2025-04-01 02:34:37.560','2025-03-31 21:34:50.080') AS [HOURS]

--TASK-8---
SELECT 
    (DATEPART(YEAR, '2025-02-03') - DATEPART(YEAR, '2023-05-01')) * 12 
    + (DATEPART(MONTH, '2025-02-03') - DATEPART(MONTH, '2023-05-01')) AS MonthsDifference;

	--TASK-9---

	SELECT CHARINDEX('SQL','Learn SQL Server')

	--TASK-10--

	SELECT VALUE
	FROM STRING_SPLIT('apple,orange,banana',',');

	--TASK-11--

	SELECT DATEDIFF(DAY,'2025-04-01','2025-01-01');


	--TASK-12---
	SELECT LEFT('Data Science',4)

	--TASK-13---


	SELECT CEILING(SQRT(225))

--TASK-14---

SELECT CONCAT_WS('|','MUHAMMAD','YUSUF')


--TASK-15---

SELECT PATINDEX('%[0-9]%', 'abc123xyz') AS FirstDigitPosition;


--TASK-16----
SELECT CHARINDEX('SQL','SQL Server SQL',2)

--TASK-17---

SELECT DATEPART(YEAR,GETDATE());

--TASK-18---


SELECT DATEADD(DAY, -100, GETDATE());

--TASK-19---

SELECT DATENAME(WEEKDAY, '2025-02-03') AS DayName;

--TASK-20--

SELECT POWER(25,2)




