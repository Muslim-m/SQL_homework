--          ##Easy-Level Tasks (10)
 1.Write a query to select the top 5 employees from the Employees table.
  select top 5 * from  Employees;
 2. Use SELECT DISTINCT to select unique Category values from the Products table.
select distinct Category  from Products;
3. Write a query that filters the Products table to show products with Price > 100.
Select * from Products
where Price>100;
4.Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
Select * from Customers
 Where FirstName LIKE 'A%'
5.Order the results of a Products table by Price in ascending order.
   Select * from Products
    Order by Price ASC
6.Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
SELECT * FROM Employees WHERE Salary >= 60000 AND DepartmentName = 'HR';

7.Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
  Select ISNULL(Email, 'noemail@example.com') As Email
  from Employees;
8.Write a query that shows all products with Price BETWEEN 50 AND 100.
 Select * from Products
  Where Price Between 50 AND 100;
9.Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName
FROM Products;
10.After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
SELECT DISTINCT Category, ProductName
FROM Products
         Order by ProductName DESC;



-- ##Medium-Level Tasks (10)
#11Write a query to select the top 10 products from the Products table, ordered by Price DESC.
 Select Top 10 * from Products
  Order by Price DESC;
#12 Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
SELECT COALESCE(FirstName, LastName) AS Name FROM Employees;

#13 Write a query that selects distinct Category and Price from the Products table.
Select distinct Category ,Price  from Products;
#14 Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
SELECT * FROM Employees WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';

#15 Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
#16 Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
 Select * from Products
 Where Price<=1000 and Stock>50
  Order by Stock ASC;
#17Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
   Select * from Products
   Where ProductName LIKE '%e%'
 #18 Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
SELECT * FROM Employees WHERE DepartmentName IN ('HR', 'IT', 'Finance');

#19 Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
Select * from Customers
 Order by City  ASC , PostalCode  DESC;






--  ##Hard-Level Tasks

##20Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SalesAmount DESC.

SELECT TOP(5) *
FROM Sales
ORDER BY SalesAmount DESC;

#21 Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
  For 21 task , i provide two answers , i find a solution this question according to basic approach
   SELECT FirstName + ' ' + LastName AS FullName
FROM Employees;
Also , i searched advanced  way to solve this question , I have read about CONCAT funtion and completed task , using CONCAT funtion 
  SELECT CONCAT(COALESCE(FirstName, ''), ' ', COALESCE(LastName, '')) AS FullName FROM Employees;

#22Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
 Select distinct Category, ProductName,Price from Products
Where Price >50
 #23 Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
 Select * from Products
 Where Price<0.1*(Select avg(price) from Products);
#24 Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
Select * from Employees
Where Age<30 and  DepartmentName IN ('HR', 'IT');
#25 Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
SELECT *
FROM Customers
WHERE Email LIKE '%@gmail.com';
#26 Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE DepartmentName = 'Sales'
);
#27Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)

SELECT * FROM Orders WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
