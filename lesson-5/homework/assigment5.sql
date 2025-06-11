-- ##Easy-Level Tasks
1. Write a query that uses an alias to rename the ProductName column as Name in the Products table.
select productname as Name from Products;
2.Write a query that uses an alias to rename the Customers table as Client for easier reference.
select * from Customers as Client
3.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
select ProductName from Products
 union
 select ProductName from products_discounted;
4.Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT;
select  ProductName from Products
intersect
select ProductName from products_discounted;
5.Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT
select distinct firstname , lastname ,country from customers;
6.Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
Select *, case when Price>1000  then 'High' else
 'Low' end as  PriceCategory from Products;
7.Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
select *, iff(StockQuantity > 100, 'Yes', 'No') as  StockStatus FROM Products_Discounted;

  --  #Medium-Level Tasks
8. select ProductName from Products
union
select ProductName from Products_Discounted;
9.Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
select * from Products
except
select * from products_discounted;
10.Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
SELECT *, IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory FROM Products;
11. Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.

           select * from employees
where ( case when Age<25 then 1 else 0 end=1 )or (case when Salary>60000 then 1 else 0 end=1) ;

12.Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
update Employees
set Salary = case When  DepartmentName = 'HR' OR EmployeeID = 5 THEN Salary * 1.1 ELSE Salary END;
--      ##Hard-Level Tasks

13 Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table);
select * , case when SaleAmount>500 then 'Top Tier'
when SaleAmount between 200 and 500  then 'Mid Tier'
else 'Low Tier'  end  as Tier from sales;
14.Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table.
select distinct CustomerID from orders except select distinct CustomerID from Sales;

15 .Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased.
Use orders table.
Result set should show customerid, quantity and discount percentage.
The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%

SELECT CustomerID, Quantity, case when Quantity = 1 then  '3%'
                                when Quantity in (2, 3) then '5%'
                                else '7%' end as  discountPercentage  from Orders;

