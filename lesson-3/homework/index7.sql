--#Easy-Level Tasks (10)
1.Write a query to find the minimum (MIN) price of a product in the Products table;
select Min(price) as MinPrice from products;
2.Write a query to find the maximum (MAX) Salary from the Employees table.
select Max(Salary) as MaxSalary from Employees;
3.Write a query to count the number of rows in the Customers table.
select Count(*) as Totalrows from Customers;
4.Write a query to count the number of unique product categories from the Products table.
select distinct category  from products;
5.Write a query to find the total sales amount for the product with id 7 in the Sales table.
select sum(saleamount) as total_sales from sales
where productid=7;
6.Write a query to calculate the average age of employees in the Employees table.
select avg(age) as avg_age from employees;
7.Write a query to count the number of employees in each department.
select  departmentname ,count(departmentname) from employees
group by  departmentname;
8.Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
select category, min(price) as MinPrice , max(price) as MaxPrice from Products
group by category;
9.Write a query to calculate the total sales per Customer in the Sales table.
select  customerid,sum(saleamount) from sales
group by customerid;
10.Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName)
select  departmentname,count(departmentname)  from employees
group by departmentname
having count(departmentname)>5;
--#Medium-Level Tasks (9)
11.Write a query to calculate the total sales and average sales for each product category from the Sales table.
select productid, sum(saleamount) as total_salary ,avg(saleamount) as avg_salary from sales
group by productid;
12.Write a query to count the number of employees from the Department HR.
select departmentname, count(departmentname) as Department from employees
where departmentname='HR'
group by departmentname;
13.Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
select departmentname , min(salary) as Min_salary, max(salary) as Max_salary from employees
group by departmentname
14.Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
select departmentname ,avg(salary) from employees
group by departmentname;
15.Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
 select departmentname, avg(salary) as avgsalary,count(departmentname) as employeecount from employees
 group by departmentname;
16 Write a query to filter product categories with an average price greater than 400.
select  category , avg(price) from Products
group by  category
having avg(price)>400;
17 Write a query that calculates the total sales for each year in the Sales table.
select saledate , sum(saleamount) from sales
group by saledate;
18.Write a query to show the list of customers who placed at least 3 orders.
select customerid , count(customerid) as Ordercount from sales
group by customerid
order by Customerid>3;
19.Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).;
select departmentname , avg(salary) from Employees
group by departmentname
having avg(salary)>60000
-- #Hard-Level Tasks (6)
20.Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.
select category, avg(price) from products
group by category
having avg(price)>150;
21.Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
select customerid , sum(saleamount) from sales
group by customerid
having sum(saleamount)>1500;
22.Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
select departmentname, sum(salary), avg(salary) from employees
group by departmentname
having avg(salary)>65000;
23.Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).
24.Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)
select orderdate, count(distinct totalamount) from orders
group by orderdate
having count(productid)>=2;
25.Write a query to find the MIN and MAX order quantity per Year. From orders table. Necessary tables:
select  orderdate ,min(quantity), max(quantity) from orders
group by orderdate


