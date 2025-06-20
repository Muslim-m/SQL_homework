--Easy-Level Tasks (10)
1.Using Products, Suppliers table List all combinations of product names and supplier names.
select productname , suppliername
from products
cross join suppliers;
2.Using Departments, Employees table Get all combinations of departments and employees.
select * from employees
cross join departments;
3.Using Products, Suppliers table List only the combinations where the supplier actually supplies the product.
Return supplier name and product name
select productname, suppliername from products as p
inner join suppliers as s
on p.supplierid=s.supplierid;
4.Using Orders, Customers table List customer names and their orders ID.
select firstname, lastname , orderid
from customers as c
inner join orders as o
on c.customerid=o.customerid;
5.Using Courses, Students table Get all combinations of students and courses.
select * from students
cross join courses;
6.Using Products, Orders table Get product names and orders where product IDs match.
select productname ,orderid from products as p
inner join orders as o
on p.productid=o.productid;
7.Using Departments, Employees table List employees whose DepartmentID matches the department.
select e.name as EmployeeName, d.departmentname from employees as e
inner join departments as d
on e.departmentid=d.departmentid;
8.Using Students, Enrollments table List student names and their enrolled course IDs.
select name ,courseid from students s
inner join enrollments as e
on s.studentid = e.studentid;
9.Using Payments, Orders table List all orders that have matching payments.
select * from payments as p
inner join orders as o
on p.orderid = o.orderid;
--Medium (10 puzzles)
10.Using Orders, Products table Show orders where product price is more than 100.
select o.productid, productname,price from orders as o
inner join products as p
on o.productid=p.productid
where  price>100;
11.Using Employees, Departments table List employee names and department names where department IDs are not equal.
It means: Show all mismatched employee-department combinations.
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID != d.DepartmentID
12.Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.

select o.* , p.ProductName, p.StockQuantity from orders as o
inner join products as p
on o.productid=p.productid
where o.quantity>p.stockquantity



13.Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
select firstname , lastname , productid  from customers as c
inner join sales as s
on c.customerid=s.customerid
where s.saleamount>=500;
14.Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.

select name ,coursename from students as s
inner join enrollments as e
on s.studentid=e.studentid
inner join courses as c
on e.courseid=c.courseid;
15.Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
 select productname, suppliername  from products as p
inner join suppliers as s
on p.supplierid=s.supplierid
where s.suppliername like '%Tech%';
16.Using Orders, Payments table Show orders where payment amount is less than total amount.

select * from Orders as o
inner join Payments as p
on o.orderid = p.orderid
where p.amount<o.totalamount;



17.Using Employees and Departments tables, get the Department Name for each employee.
select name , departmentname from employees as e
left join departments as d
on  e.departmentid=d.departmentid;
18.Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
SELECT p.*
FROM Products AS p
LEFT JOIN Categories AS c
ON p.Categoryid = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
19.Using Sales, Customers table Show all sales from customers who are from 'USA'.
select * from Sales as s
 inner join customers as  c
on s.customerid=c.customerid
where c.country='USA';
20.Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
select * from orders as  o
inner join   customers as c
on o.customerid=c.customerid
where c.country='Germany' and o.totalamount>100;




 --Hard (5 puzzles)(Do some research for the tasks below)

 21.Using Employees table List all pairs of employees from different departments.
SELECT
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.DepartmentID AS Dept1,
    e2.DepartmentID AS Dept2
FROM Employees e1
INNER JOIN Employees e2
ON e1.EmployeeID < e2.EmployeeID
WHERE e1.DepartmentID != e2.DepartmentID;
22.Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT
    p.PaymentID,
    p.OrderID,
    p.PaymentDate,
    p.Amount AS PaidAmount,
    p.PaymentMethod,
    o.Quantity,
    pr.Price AS ProductPrice,
    (o.Quantity * pr.Price) AS ExpectedAmount
FROM Payments p
INNER JOIN Orders o
ON p.OrderID = o.OrderID
INNER JOIN Products pr
ON o.ProductID = pr.ProductID
WHERE p.Amount != (o.Quantity * pr.Price);
23.Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
                                        SELECT s.StudentID, s.Name
FROM Students s
LEFT JOIN Enrollments e
ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;
24.Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
                   SELECT
    m.EmployeeID AS ManagerID,
    m.Name AS ManagerName,
    m.Salary AS ManagerSalary,
    e.EmployeeID AS EmployeeID,
    e.Name AS EmployeeName,
    e.Salary AS EmployeeSalary
FROM Employees m
INNER JOIN Employees e
ON m.EmployeeID = e.ManagerID
WHERE m.Salary <= e.Salary;




25.Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.

SELECT DISTINCT
    c.CustomerID,
    c.FirstName,
    c.LastName
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.OrderID IS NULL;





