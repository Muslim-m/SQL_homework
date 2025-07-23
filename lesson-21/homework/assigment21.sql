                              --Lesson 21 WINDOW FUNCTIONS
--1.Write a query to assign a row number to each sale based on the SaleDate.
select * ,
       row_number() over (order by saledate ) from productsales;
--2.Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.

WITH TotalQuantity AS (
    SELECT ProductName, SUM(Quantity) AS Total_Quantity
    FROM ProductSales
    GROUP BY ProductName
)
SELECT ProductName, Total_Quantity,
       DENSE_RANK() OVER (ORDER BY Total_Quantity DESC) AS Rank
FROM TotalQuantity;
--3.Write a query to identify the top sale for each customer based on the SaleAmount.
SELECT *
FROM (
    SELECT SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) dt
WHERE rn = 1;
--4.Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.


select * ,
       lead(saleamount) over(order by saledate) as NextSaleAmount from productsales
--5 Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.

SELECT *,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales;
--6.Write a query to identify sales amounts that are greater than the previous sale's amount

WITH cte AS (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS previous_amount
    FROM ProductSales
)
SELECT *
FROM cte
WHERE previous_amount IS NOT NULL AND SaleAmount > previous_amount;

--7.Write a query to calculate the difference in sale amount from the previous sale for every product
WITH cte AS (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS previous_amount
    FROM ProductSales
)
SELECT *,
       COALESCE(SaleAmount - previous_amount, 0) AS Difference
FROM cte;
--8.Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
WITH cte AS (
    SELECT *,
           LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS next_saleamount
    FROM ProductSales
)
SELECT *,
       CASE
           WHEN SaleAmount = 0 THEN NULL
           ELSE ((next_saleamount - SaleAmount) / SaleAmount) * 100
       END AS percentage_change
FROM cte
WHERE next_saleamount IS NOT NULL;

--9.Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.

WITH cte AS (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS previousSaleAmount
    FROM ProductSales
)
SELECT SaleID, ProductName, SaleDate, SaleAmount, previousSaleAmount,
       CASE
           WHEN previousSaleAmount IS NULL OR previousSaleAmount = 0 THEN 0
           ELSE SaleAmount / previousSaleAmount
       END AS ratio
FROM cte;

--10.Write a query to calculate the difference in sale amount from the very first sale of that product.
WITH cte AS (
  SELECT *,
         FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FirstSaleAmount
  FROM ProductSales
)
SELECT
  SaleID,
  ProductName,
  SaleDate,
  SaleAmount,
  SaleAmount - FirstSaleAmount AS DifferenceFromFirst
FROM cte
ORDER BY ProductName, SaleDate;



--11 Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
WITH SalesWithLag AS (
  SELECT *,
         LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS prev_amount
  FROM ProductSales
),
FlagBreaks AS (
  SELECT *,
         CASE
           WHEN prev_amount IS NULL OR SaleAmount <= prev_amount THEN 1
           ELSE 0
         END AS is_break
  FROM SalesWithLag
),
Grouped AS (
  SELECT *,
         SUM(is_break) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS grp
  FROM FlagBreaks
)
SELECT ProductName, SaleDate, SaleAmount
FROM Grouped
WHERE grp IN (
  SELECT grp
  FROM Grouped
  GROUP BY ProductName, grp
  HAVING COUNT(*) >= 3  -- Minimum length of continuous increasing trend
)
ORDER BY ProductName, SaleDate;

--12.Write a query to calculate a "closing balance"(running total)
-- for sales amounts which adds the current sale amount to a running total of previous sales.
SELECT *,
       SUM(SaleAmount) OVER (ORDER BY SaleDate) AS RunningTotal
FROM ProductSales;

--13.Write a query to calculate the moving average of sales amounts over the last 3 sales

SELECT *,
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage
FROM ProductSales;
--14 Write a query to show the difference between each sale amount and the average sale amount.
WITH cte AS (
    SELECT *,
           AVG(SaleAmount) OVER () AS avg_amount
    FROM ProductSales
)
SELECT SaleID, ProductName, SaleDate, SaleAmount,
       SaleAmount - avg_amount AS Difference
FROM cte;
--15.Find Employees Who Have the Same Salary Rank
SELECT EmployeeID, Name, Department, Salary
FROM (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank,
           COUNT(*) OVER (PARTITION BY Salary) AS SalaryCount
    FROM Employees1
) dt
WHERE SalaryCount > 1;
--16Identify the Top 2 Highest Salaries in Each Department
with cte as (
select department,salary ,
row_number() over (partition by department order by salary desc) as Top_2_salary  from employees1 )
select * from cte
where Top_2_salary<=2;

--17.Find the Lowest-Paid Employee in Each Department
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees1
)
SELECT EmployeeID, Name, Department, Salary
FROM cte
WHERE rn = 1;
--18Calculate the Running Total of Salaries in Each Department
SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees1;


--19.Find the Total Salary of Each Department Without GROUP BY

SELECT DISTINCT Department,
       SUM(Salary) OVER (PARTITION BY Department) AS Total_Salary
FROM Employees1;
--20.Calculate the Average Salary in Each Department Without GROUP BY
select  distinct  department ,
       avg(salary) over (partition by department) as avg_salary from employees1;
--21.Find the Difference Between an Employee’s Salary and Their Department’s Average;


select * from Employees1;
select department , avg(salary) from employees1
group by department;
select  name , salary-avg(salary) over(partition by department) as Difference  from employees1;


--22.Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
SELECT Name, Salary,
       ROUND(AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS MovingAvgSalary
FROM Employees1;


--23.Find the Sum of Salaries for the Last 3 Hired Employees
with cte as (
select * ,
       row_number() over (order by hiredate desc ) as rn  from employees1 )
select sum(salary) as LasT_3_hired_employee from cte
where rn<=3


































