--#Easy-Level Tasks (10)
1.Write a query to find the minimum (MIN) price of a product in the Products table;
select Min(price) as MinPrice from products;
2.Write a query to find the maximum (MAX) Salary from the Employees table.
select Max(Salary) as MaxSalary from Employees;
3.Write a query to count the number of rows in the Customers table.
select Count(*) as Totalrows from Customers;
4.Write a query to count the number of unique product categories from the Products table.
select count(distinct category) as  UniqueCategories  from products;
5.Write a query to find the total sales amount for the product with id 7 in the Sales table.
select sum(saleamount) as total_sales from sales
where productid=7;
6.Write a query to calculate the average age of employees in the Employees table.
select avg(age) as avg_age from employees;
7.Write a query to count the number of employees in each department.
SELECT departmentname, COUNT(*) AS EmployeeCount FROM Employees GROUP BY departmentname;
8.Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
select category, min(price) as MinPrice , max(price) as MaxPrice from Products
group by category;
9.Write a query to calculate the total sales per Customer in the Sales table.
select  customerid,sum(saleamount) as TotalSales  from sales
group by customerid;
10.Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName)
SELECT DeptID, COUNT(*) AS EmployeeCount FROM Employees GROUP BY DeptID HAVING COUNT(*) > 5;
--#Medium-Level Tasks (9)
11.Write a query to calculate the total sales and average sales for each product category from the Sales table.
SELECT p.category, SUM(s.saleamount) AS TotalSales, AVG(s.saleamount) AS AvgSales
FROM Sales s JOIN Products p ON s.productid = p.productid
GROUP BY p.category;
12.Write a query to count the number of employees from the Department HR.
SELECT departmentname, COUNT(*) AS EmployeeCount FROM Employees
WHERE departmentname = 'HR' GROUP BY departmentname;
13.Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT DeptID, MIN(salary) AS MinSalary, MAX(salary) AS MaxSalary FROM Employees GROUP BY DeptID;
14.Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
SELECT DeptID, AVG(salary) AS AvgSalary FROM Employees GROUP BY DeptID;
15.Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
SELECT DeptID, AVG(salary) AS AvgSalary, COUNT(*) AS EmployeeCount FROM Employees GROUP BY DeptID;

16 Write a query to filter product categories with an average price greater than 400.
select  category , avg(price) Avgprice from Products
group by  category
having avg(price)>400;
17 Write a query that calculates the total sales for each year in the Sales table.
SELECT YEAR(saledate) AS SaleYear, SUM(saleamount) AS TotalSales FROM Sales GROUP BY YEAR(saledate);
18.Write a query to show the list of customers who placed at least 3 orders.
select customerid , count(*) as Ordercount from sales
group by customerid
having Count(*)>=3;

19.Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).;
SELECT DeptID, AVG(salary) AS AvgSalary FROM Employees GROUP BY DeptID HAVING AVG(salary) > 60000;
-- #Hard-Level Tasks (6)
20.Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.
select category, avg(price) as AvgPrice from products
group by category
having avg(price)>150;
21.Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
SELECT customerid, SUM(saleamount) AS TotalSales FROM Sales
GROUP BY customerid HAVING SUM(saleamount) > 1500;
22.Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
SELECT DeptID, SUM(salary) AS TotalSalary, AVG(salary) AS AvgSalary FROM Employees
GROUP BY DeptID HAVING AVG(salary) > 65000;
23.Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).
WITH CustomerMin AS (
    SELECT CustomerID, MIN(TotalDue) AS LeastPurchase
    FROM Sales.Orders
    GROUP BY CustomerID
)
SELECT
    s.CustomerID,
    SUM(s.TotalDue) AS TotalAmountOver50Freight,
    cm.LeastPurchase
FROM Sales.Orders s
JOIN CustomerMin cm ON s.CustomerID = cm.CustomerID
WHERE s.Freight > 50
GROUP BY s.CustomerID, cm.LeastPurchase;
24.Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)
SELECT
    YEAR(orderdate) AS SaleYear,
    MONTH(orderdate) AS SaleMonth,
    SUM(totalamount) AS TotalSales,
    COUNT(DISTINCT productid) AS UniqueProducts
FROM Orders
GROUP BY YEAR(orderdate), MONTH(orderdate)
HAVING COUNT(DISTINCT productid) >= 2;
25.Write a query to find the MIN and MAX order quantity per Year. From orders table. Necessary tables:
SELECT YEAR(orderdate) AS OrderYear, MIN(quantity) AS MinQuantity, MAX(quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(orderdate);

