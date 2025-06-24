 --Easy-Level Tasks (10)
 1. Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is
 greater than 50000, along with their department names.
 Expected Columns: EmployeeName, Salary, DepartmentName

select e.name as EmployeeName , e.salary as Salary , d.departmentname as DepartmentName from employees as e
inner join departments as d
on e.departmentid=d.departmentid
where e.salary>50000;

2.Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
🔁 Expected Columns: FirstName, LastName, OrderDate

  select c.firstname as FirstName , c.lastname as  LastName,  o.orderdate as OrderDate from customers as c
inner join orders as o
on c.customerid=o.customerid
where   EXTRACT(YEAR FROM o.orderdate) = 2023;

3.Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
🔁 Expected Columns: EmployeeName, DepartmentName


select e.name as EmployeeName ,d.departmentname as DepartmentName from employees as e
left join departments as d
on e.departmentid=d.departmentid

4.Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
🔁 Expected Columns: SupplierName, ProductName

select s.suppliername as SupplierName, p.productname as ProductName  from suppliers as s
left join products as p
on s.supplierid = p.supplierid

5.Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount
select o.OrderID , o.OrderDate , p.PaymentDate , p.Amount from orders as o
full outer join  payments as p
on o.orderid=p.orderid
6.Using the Employees table, write a query to show each employee's name along with the name of their manager.
🔁 Expected Columns: EmployeeName, ManagerName

select e.name as  EmployeeName , m.name as ManagerName
from employees as e
left join employees as m
On e.managerid = m.employeeid;

7.Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
🔁 Expected Columns: StudentName, CourseName

SELECT s.name AS StudentName, c.coursename AS CourseName
FROM students AS s
INNER JOIN enrollments AS e
ON s.studentid = e.studentid
INNER JOIN courses AS c
ON e.courseid = c.courseid
WHERE c.coursename = 'Math 101';

8.Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
🔁 Expected Columns: FirstName, LastName, Quantity

SELECT c.firstname AS FirstName, c.lastname AS LastName, o.quantity AS Quantity
FROM customers AS c
INNER JOIN orders AS o
ON c.customerid = o.customerid
WHERE o.quantity > 3;

9.Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
🔁 Expected Columns: EmployeeName, DepartmentName

select e.name  as EmployeeName , d.departmentname as DepartmentName  from employees as e
inner join departments as d
on e.departmentid=d.departmentid
where d.departmentname='Human Resources' ;

--#Medium-Level Tasks (9)

10.Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
🔁 Expected Columns: DepartmentName, EmployeeCount

select  d.departmentname as  DepartmentName , count(e.employeeid) as  EmployeeCount  from departments as d
left join employees as e
on d.departmentid=e.departmentid
 group by d.departmentname
having  count(e.employeeid) >5

11.Using the Products and Sales tables, write a query to find products that have never been sold.
🔁 Expected Columns: ProductID, ProductName

 select * from products;
select * from Sales;
select  p.productid as ProductID , p.productname as  ProductName from products as p
left join sales as s
on p.productid=s.productid
where s.productid is null

12.Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
🔁 Expected Columns: FirstName, LastName, TotalOrders


select c.firstname as  FirstName , c.lastname as LastName , count(o.orderid) as TotalOrders from customers as c
inner join orders as o
on c.customerid=o.customerid
group by c.firstname, c.lastname
having count(o.orderid)>=1;

13.Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
🔁 Expected Columns: EmployeeName, DepartmentName

select e.name as EmployeeName ,  d.departmentname as DepartmentName from employees as e
inner join departments as d
on e.departmentid=d.departmentid

14.Using the Employees table, write a query to find pairs of employees who report to the same manager.
🔁 Expected Columns: Employee1, Employee2, ManagerID

SELECT
    e1.name AS Employee1,
    e2.name AS Employee2,
    e1.managerid AS ManagerID
FROM employees e1
INNER JOIN employees e2
ON e1.managerid = e2.managerid
AND e1.employeeid < e2.employeeid
WHERE e1.managerid IS NOT NULL;

15.Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName

select o.orderid as OrderID ,o.orderdate as OrderDate , c.firstname as FirstName  , c.lastname  as  LastName from orders as o
inner join customers as c
on  o.customerid=c.customerid
where EXTRACT(YEAR FROM o.orderdate) = 2022;

16.Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
🔁 Expected Columns: EmployeeName, Salary, DepartmentName

select e.name as  EmployeeName , e.salary as Salary , d.departmentname as DepartmentName from employees as e
inner join departments as d
on e.departmentid=d.departmentid
where d.departmentname ='Sales' and e.salary>60000;
17.Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount


select o.OrderID as OrderID ,o.OrderDate as OrderDate , p.paymentdate as  PaymentDate , p.amount as Amount
from  orders as o
inner join payments as p
on o.orderid = p.orderid

18.Using the Products and Orders tables, write a query to find products that were never ordered.
🔁 Expected Columns: ProductID, ProductName



select p.productid as  ProductID , p.productname as ProductName  from products as p
left join orders as o
on p.productid=o.productid
where o.orderid is null


-- #Hard-Level Tasks (9)

19.Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
🔁 Expected Columns: EmployeeName, Salary

select e1.name as EmployeeName , e1.salary  as Salary from employees as e1
where e1.salary>(select avg(e2.salary)  from employees as e2
where e1.departmentid=e2.departmentid);



20.Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
🔁 Expected Columns: OrderID, OrderDate



SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE EXTRACT(YEAR FROM o.orderdate)< 2020
AND p.OrderID IS NULL;

21.Using the Products and Categories tables, write a query to return products that do not have a matching category.
🔁 Expected Columns: ProductID, ProductName

 SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Categories c ON p.productid = c.CategoryID
WHERE c.CategoryID IS NULL;




22.Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary


SELECT e1.name AS Employee1, e2.name AS Employee2, e1.managerid AS ManagerID, e1.salary AS Salary
FROM employees e1
INNER JOIN employees e2
ON e1.managerid = e2.managerid
AND e1.employeeid < e2.employeeid
WHERE e1.salary > 60000 AND e2.salary > 60000
AND e1.managerid IS NOT NULL;

23.Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.
🔁 Expected Columns: EmployeeName, DepartmentName

 select e.name as  EmployeeName , d.departmentname as DepartmentName from employees as e
inner join departments d
    on e.departmentid = d.departmentid
where d.departmentname like 'M%';

24.Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
🔁 Expected Columns: SaleID, ProductName, SaleAmount

select s.saleid as SaleID , p.productname as ProductName , s.saleamount as SaleAmount  from sales as s
inner join products as p
on p.productid=s.productid
where s.saleamount>500;

25.Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
🔁 Expected Columns: StudentID, StudentName

SELECT s.studentid AS StudentID, s.name AS StudentName
FROM students AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    INNER JOIN courses c ON e.courseid = c.courseid
    WHERE e.studentid = s.studentid
    AND c.coursename = 'Math 101'
);


26.Using the Orders and Payments tables, write a query to return orders that are missing payment details.
🔁 Expected Columns: OrderID, OrderDate, PaymentID


select o.orderid as OrderID, o.orderdate as OrderDate , p.paymentid as PaymentID from orders as o
left join payments as p
on o.orderid = p.orderid
where p.paymentid is null;

27.Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
🔁 Expected Columns: ProductID, ProductName, CategoryName

select p.productid as ProductID , p.productname as  ProductName, c.categoryname  as CategoryName from products as p
inner join categories as c
on p.productid=c.categoryid
where c.categoryname in ('Electronics', 'Furniture');
