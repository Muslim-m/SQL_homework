--#Easy-Level Tasks (7)
1.Return: OrderID, CustomerName, OrderDate
Task: Show all orders placed after 2022 along with the names of the customers who placed them.
Tables Used: Orders, Customers

select o.orderid as OrderId , Concat(c.firstname ,' ', c.lastname ) as CustomerName  ,o.orderdate from orders as o
inner join customers as c
on c.customerid=o.customerid
where YEAR(orderdate) >2022;

2.Return: EmployeeName, DepartmentName
Task: Display the names of employees who work in either the Sales or Marketing department.
Tables Used: Employees, Departments

select e.name as EmployeeName ,  d.departmentname as DepartmentName from employees as e
inner join departments as d
on e.departmentid=d.departmentid
where d.departmentname in ('Sales','Marketing' );

3.Return: DepartmentName,  MaxSalary
Task: Show the highest salary for each department.
Tables Used: Departments, Employees

  select d.departmentname as  DepartmentName , max(e.salary) from departments as d
inner join employees as e
on d.departmentid=e.departmentid
group by d.departmentname

4.Return: CustomerName, OrderID, OrderDate
Task: List all customers from the USA who placed orders in the year 2023.
Tables Used: Customers, Orders

SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, o.OrderID, o.OrderDate
FROM Customers AS c
INNER JOIN Orders AS o
ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023;

5.Return: CustomerName, TotalOrders
Task: Show how many orders each customer has placed.
Tables Used: Orders , Customers


select concat(c.firstname ,' ' , c.lastname ) as  CustomerName , count(o.orderid) as TotalOrders  from customers as c
left join orders as o
on c.customerid=o.customerid
group by c.firstname, c.lastname ;

6.Return: ProductName, SupplierName
Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
Tables Used: Products, Suppliers


select p.productname as ProductName , s.suppliername  as  SupplierName from  products as p
inner join suppliers as s
on p.supplierid = s.supplierid
where s.suppliername in ('Gadget Supplies','Clothing Mart');

7.Return: CustomerName, MostRecentOrderDate
Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
Tables Used: Customers, Orders

select concat(c.firstname, ' ' , c.lastname ) as CustomerName , max(o.orderdate) as MostRecentOrderDate from customers as c
left join orders as o
on c.customerid=o.customerid
group by c.firstname, c.lastname ;

    --Medium-Level Tasks (6)
8.Return: CustomerName,  OrderTotal
Task: Show the customers who have placed an order where the total amount is greater than 500.
Tables Used: Orders, Customers

select concat(c.firstname,' ', c.lastname ) as CustomerName , o.totalamount as OrderTotal from customers as c
inner join orders as o
on c.customerid=o.customerid
where o.totalamount>500;

9.Return: ProductName, SaleDate, SaleAmount
Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
Tables Used: Products, Sales

select p.ProductName as ProductName , s.saledate as SaleDate , s.saleamount as SaleAmount  from products as p
inner join sales as s
on p.productid=s.productid
where YEAR(s.saledate)=2022 or s.saleamount>400;

10.Return: ProductName, TotalSalesAmount
Task: Display each product along with the total amount it has been sold for.
Tables Used: Sales, Products

select p.productname as ProductName , sum(s.saleamount) as TotalSalesAmount  from products as p
inner join sales as s
on p.productid=s.productid
 GROUP BY p.ProductID, p.ProductName

11.Return: EmployeeName, DepartmentName, Salary
Task: Show the employees who work in the HR department and earn a salary greater than 60000.
Tables Used: Employees, Departments


select e.name as EmployeeName , d.departmentname as DepartmentName , e.salary as  Salary from employees as e
inner join departments as d
on e.departmentid=d.departmentid
where d.departmentname='HR'and e.Salary>60000;


12.Return: ProductName, SaleDate, StockQuantity
Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
Tables Used: Products, Sales

select p.productname as ProductName , s.saledate as SaleDate, p.stockquantity as StockQuantity from products as p
inner join sales as s
on p.productid=s.productid
where YEAR(s.SaleDate) = 2023 and  p.stockquantity>100;

13.Return: EmployeeName, DepartmentName, HireDate
Task: Show employees who either work in the Sales department or were hired after 2020.
Tables Used: Employees, Departments

select e.name as EmployeeName , d.departmentname as DepartmentName , e.hiredate as HireDate from employees as e
inner join  departments as d
on e.departmentid=d.departmentid
where d.departmentname='Sales' or Year(e.hiredate)>2020;


 --#Hard-Level Tasks (7)
14.Return: CustomerName, OrderID, Address, OrderDate
Task: List all orders made by customers in the USA whose address starts with 4 digits.
Tables Used: Customers, Orders


select concat(c.firstname ,' ', c.lastname) as CustomerName , o.orderid as OrderID ,
       c.address as Address , o.orderdate as OrderDate from customers as c
inner join orders as o
on  c.customerid=o.customerid
where c.country='USA'and c.Address LIKE '[0-9][0-9][0-9][0-9][^0-9]%';

15.Return: ProductName, Category, SaleAmount
Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
Tables Used: Products, Sales


select p.productname as  ProductName , p.category as Category, s.saleamount as SaleAmount from products as p
inner join Sales as s
on p.productid=s.productid
where p.category='Electronics' or  s.saleamount>350;


16.Return: CategoryName, ProductCount
Task: Show the number of products available in each category.
Tables Used: Products, Categories

select  c.categoryname as CategoryName , count(p.productname) as ProductCount from categories as c
left join products as p
on p.category=c.categoryname
group by c.categoryname;

17.Return: CustomerName, City, OrderID, Amount
Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
Tables Used: Customers, Orders

select concat(c.firstname,' ',c.lastname) as  CustomerName , c.city as City , o.orderid as OrderID , o.totalamount as Amount
from customers as c
inner join orders as o
on c.customerid=o.customerid
where c.city='Los Angeles' and  o.totalamount>300;

18.Return: EmployeeName, DepartmentName
Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
Tables Used: Employees, Departments

select e.name as EmployeeName  , d.departmentname as DepartmentName from employees as e
inner join departments as d
on e.departmentid=d.departmentid
where d.departmentname in ('Human Resources','Finance department')
OR (
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'a', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'e', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'i', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'o', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'u', '')))
        >= 4
    )
;

19.Return: EmployeeName, DepartmentName, Salary
Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
Tables Used: Employees, Departments

select  e.name as EmployeeName , d.departmentname as DepartmentName , e.salary as Salary from employees as e
inner join departments as d
on e.departmentid=d.departmentid
where d.departmentname in ('Sales','Marketing') and e.salary>60000;
