---BEGINNER LEVEL-----

--TASK-1

select left('Database',4)

--TASK-2
 
 SELECT charindex('SQl','I love SQl Server')

 --TASK-3

 select replace('Hello World','World','SQL') as replaced

 --TASK-4

 select len ( 'Microsoft SQL') as Wordlength

 --TASK-5

 select right('Database',3)

 --TASK-6

select 
len ('apple') - Len(replace('apple','a','')) as count_a_Apple,
len ('banana') - Len(replace('banana','a','')) as count_a_Banana,
len ('apple') - Len(replace('grape','a','')) as count_a_Grape;

--TASK-7
select right('abcdefg',LEN('abcdefg')-5) as result;    -- first option

select right('aabcdefg',2);                  -- second option

--TASK-8

SELECT SUBSTRING('SQL is powerful', CHARINDEX(' ', 'SQL is powerful') + 1, 
                 CHARINDEX(' ', 'SQL is powerful', CHARINDEX(' ', 'SQL is powerful') + 1) - CHARINDEX(' ', 'SQL is powerful') - 1) AS SecondWord_1;

--TASK-9

select round(15.6789,2)


--TASK-10

select abs(-345.67)

-------------------MEDIUM LEVEL TASKS----------------

--TASK-11

SELECT SUBSTRING('ABCDEFGHI', LEN('ABCDEFGHI') / 2 - 1, 3) AS MiddleCharacters;

--TASK-12

SELECT STUFF('Microsoft', 1, 3, 'XXX') AS ReplacedString;  

--TASK-13

SELECT CHARINDEX(' ', 'SQL Server 2025') AS FirstSpacePosition;

--TASK-14

SELECT CONCAT('FirstName','','LastName') as Fname1

--TASK-15

SELECT 
    SUBSTRING(
        'The database is very efficient',
        CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient') + 1) + 1,
        CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient') + 1) + 1) - CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient') + 1) - 1
    ) AS ThirdWord;

	--TASK-16
SELECT 
  
    SUBSTRING('INV1234', PATINDEX('%[0-9]%', 'INV1234'), LEN('INV1234') - PATINDEX('%[0-9]%', 'INV1234') + 1) AS NumericPart1,
    
    SUBSTRING('ORD5678', PATINDEX('%[0-9]%', 'ORD5678'), LEN('ORD5678') - PATINDEX('%[0-9]%', 'ORD5678') + 1) AS NumericPart2;

	--TASK-17

	SELECT ROUND(CAST(99.5 AS DECIMAL(12,2)),0) AS RoundedNumber;

	--TASK-18
	SELECT DATEDIFF(DAY,'2025-01-01','2025-03-15') AS DayDifference

	--TASK-19
SELECT FORMAT(cast('2025-06-10' as date), 'MMMM') AS MonthName;

--TASK-20

SELECT DATEPART(WEEK,'2025-04-22')

----------------------------ADVANCED LEVEL TASKS-----------------------

--TASK-21
SELECT SUBSTRING('user1@gmail.com',CHARINDEX('@','user1@gmail.com') + 1,LEN('user1@gmail.com'))AS DOMAIN

SELECT SUBSTRING('admin@company.org',
CHARINDEX('@','admin@company.org'
) + 1,LEN('admin@company.org'
))AS 

--TASK-22
SELECT CHARINDEX('e','experience')       -- this query finds the first occurence of 'e' in a string

SELECT LEN('experience') - CHARINDEX('e', REVERSE('experience')) + 1 AS LastOccurrence;         --this finds tha last occurence of 'e' in a string

--TASK-23

select rand() * 500 as RandomDecimalNumber

--task-24

SELECT FORMAT(9876543, 'N0') AS FormattedNumber;

--TASK-25

SELECT 
    LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS FirstName
FROM 
    Customers;

	--TASK-26
SELECT CONCAT_WS(' -', 'SQL', 'Server', 'is', 'great');

--TASK-27

select format(54,'00000')

--TASK-28
SELECT MAX(LEN(value)) AS LongestWordLength
FROM STRING_SPLIT('SQL is fast and efficient', ' ');

--TASK-29

SELECT REPLACE(
'Error: Connection failed','Error:',' ') 

--TASK-30
SELECT DATEDIFF(MINUTE,'08:15:00', '09:45:00') AS MINUTES

