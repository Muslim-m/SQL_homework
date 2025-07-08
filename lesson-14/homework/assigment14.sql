--Lesson-14: Date and time Functions,Practice
1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)

SELECT *,
       SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1) AS FirstName,
       SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)) AS Surname
FROM TestMultipleColumns;

2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)

SELECT *
FROM TestPercent
WHERE strs  LIKE '%\%%' ESCAPE '\';


3.In this puzzle you will have to split a string based on dot(.).(Splitter)
WITH SplitCTE AS (
    SELECT
        Id,
        CAST('' AS VARCHAR(100)) AS Part,
        Vals + '.' AS Remaining,
        CHARINDEX('.', Vals + '.') AS DotPos
    FROM Splitter

    UNION ALL

    SELECT
        Id,
        LTRIM(RTRIM(LEFT(Remaining, DotPos - 1))) AS Part,
        STUFF(Remaining, 1, DotPos, '') AS Remaining,
        CHARINDEX('.', STUFF(Remaining, 1, DotPos, '')) AS DotPos
    FROM SplitCTE
    WHERE Remaining <> ''
)
SELECT
    Id,
    Part
FROM SplitCTE
WHERE Part <> ''
ORDER BY Id;

4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
SELECT @String = REPLACE(@String, n, 'X')
FROM (SELECT TOP 10 n = NUMBER - 1
      FROM master..spt_values
      WHERE TYPE = 'P' AND NUMBER BETWEEN 1 AND 10) AS Numbers
CROSS APPLY (SELECT @String = '1234ABC123456XYZ1234567890ADS') AS Init;
SELECT @String AS Result;

5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)

SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

6.Write a SQL query to count the spaces present in the string.(CountSpaces)

SELECT texts,
       LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

7.write a SQL query that finds out employees who earn more than their managers.(Employee)
SELECT e.Name AS EmployeeName
FROM Employee AS e
INNER JOIN Employee AS m
    ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;


8.Find the employees who have been with the company for more than 10 years, but less than 15 years.
Display their Employee ID, First Name, Last Name, Hire Date,
and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
SELECT
    EMPLOYEE_ID AS EmployeeID,
    FIRST_NAME AS FirstName,
    LAST_NAME AS LastName,
    HIRE_DATE AS HireDate,
    DATEDIFF(MONTH, HIRE_DATE, GETDATE()) / 12.0 AS YearsOfService
FROM Employees
WHERE
    DATEDIFF(MONTH, HIRE_DATE, GETDATE()) / 12.0 > 10
    AND DATEDIFF(MONTH, HIRE_DATE, GETDATE()) / 12.0 < 15;


--Medium Tasks

1. Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
select 'rtcfvty34redt' AS mixed_string,
--I am going to provide solotion in both psql , sql server , first solution   is in  psql  while second solution is in sql server
SELECT
  'rtcfvty34redt' AS mixed_string,
  REGEXP_REPLACE('rtcfvty34redt', '[0-9]', '', 'g') AS letters_only,
  REGEXP_REPLACE('rtcfvty34redt', '[^0-9]', '', 'g') AS digits_only;

SELECT
    'rtcfvty34redt' AS mixed_string,

    -- Remove digits to keep only letters
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    'rtcfvty34redt', '0',''),'1',''),'2',''),'3',''),'4',''),
    '5',''),'6',''),'7',''),'8',''),'9','') AS letters_only,

    -- Remove letters to keep only digits
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    'rtcfvty34redt', 'a',''),'b',''),'c',''),'d',''),'e',''),
    'f',''),'g',''),'h',''),'i',''),'j',''),'k',''),'l',''),'m',''),'n',''),'o',''),
    'p',''),'q',''),'r',''),'s',''),'t',''),'u',''),'v',''),'w',''),'x',''),'y',''),
    'z','') AS digits_only;


2.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
SELECT w1.Id
FROM weather w1
JOIN weather w2
    ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;

3.Write an SQL query that reports the first login date for each player.(Activity)

select player_id , min(event_date) as  FirstLoginDate  from activity
group by player_id
order by  player_id  ;
4.Your task is to return the third item from that list.(fruits)

SELECT *,
       PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS ThirdItem
FROM fruits;


5. Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
SELECT
    Id,
    SUBSTRING(Vals, n, 1) AS Character
FROM Splitter
CROSS APPLY (
    SELECT TOP (LEN(Vals)) n = NUMBER
    FROM master..spt_values
    WHERE TYPE = 'P' AND NUMBER > 0
) AS Numbers
ORDER BY Id, n;




 6.You are given two tables: p1 and p2. Join these tables on the id column.
  The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)

select p1.id,
       case when p1.code=0 then p2.code  else p1.code end  as code
from p1
inner join p2
on p1.id=p2.id


7.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:



SELECT
    EMPLOYEE_ID AS emp_id,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS emp_name,
    HIRE_DATE AS hire_date,
    DATEDIFF(MONTH, HIRE_DATE, GETDATE()) / 12.0 AS years_worked,
    CASE
        WHEN DATEDIFF(MONTH, HIRE_DATE, GETDATE()) < 12 THEN 'New Hire'
        WHEN DATEDIFF(MONTH, HIRE_DATE, GETDATE()) < 5 * 12 THEN 'Junior'
        WHEN DATEDIFF(MONTH, HIRE_DATE, GETDATE()) < 10 * 12 THEN 'Mid-Level'
        WHEN DATEDIFF(MONTH, HIRE_DATE, GETDATE()) < 20 * 12 THEN 'Senior'
        ELSE 'Veteran'
    END AS employment_stage
FROM Employees;

8.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)


SELECT
    Id,
    VALS,
    CASE
        WHEN PATINDEX('^[0-9]+%', VALS) = 1 THEN
            CAST(SUBSTRING(VALS, 1, PATINDEX('%[^0-9]%', VALS + ' ') - 1) AS INT)
        ELSE NULL
    END AS extracted_integer
FROM GetIntegers;


--    #Difficult Tasks

1.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)


SELECT
    Id,
    CONCAT(PARSENAME(REPLACE(Vals, ',', '.'), 2), ',',
           PARSENAME(REPLACE(Vals, ',', '.'), 3), ',',
           PARSENAME(REPLACE(Vals, ',', '.'), 1)) AS SwappedVals
FROM MultipleVals;

2.Write a SQL query that reports the device that is first logged in for each player.(Activity)

WITH FirstLogin AS (
    SELECT
        player_id,
        device_id,
        event_date,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
    FROM Activity
)
SELECT player_id, device_id, event_date
FROM FirstLogin
WHERE rn = 1;

3.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.
For each week, the total sales will be considered 100%,
and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)

WITH DailySales AS (
    SELECT
        Area,
        Date,
        FinancialWeek,
        FinancialYear,
        DayName,
        DayOfWeek,
        COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0) AS TotalSales
    FROM WeekPercentagePuzzle
),
WeeklyTotals AS (
    SELECT
        Area,
        FinancialWeek,
        FinancialYear,
        SUM(TotalSales) AS WeekTotal
    FROM DailySales
    GROUP BY Area, FinancialWeek, FinancialYear
)
SELECT
    d.Area,
    d.Date,
    d.DayName,
    d.DayOfWeek,
    d.FinancialWeek,
    d.FinancialYear,
    d.TotalSales,
    w.WeekTotal,
    ROUND((d.TotalSales * 100.0) / NULLIF(w.WeekTotal, 0), 2) AS PercentOfWeek
FROM DailySales d
JOIN WeeklyTotals w
  ON d.Area = w.Area
 AND d.FinancialWeek = w.FinancialWeek
 AND d.FinancialYear = w.FinancialYear
ORDER BY d.Area, d.FinancialWeek, d.Date;










