-- Lesson-16: CTEs and Derived Tables
 --Easy Tasks
1.Create a numbers table using a recursive query from 1 to 1000.

 with recursive cte as (
    select 1 as number
union all
select number+1 from  cte
                where number<1000
)
select number from cte;
2.Write a query to find the total sales per employee using a derived table.(Sales, Employees)


select e.employeeid , firstname, lastname , total_sales from employees as e
join (
    select  employeeid , sum(salesamount) as total_sales   from sales as s
                                          group by employeeid
) as k
on e.employeeid=k.employeeid

3.Create a CTE to find the average salary of employees.(Employees)

with cte as (select avg(salary)
             from employees)
select * from cte;

4.Write a query using a derived table to find the highest sales for each product.(Sales, Products)

select p.id, p.product_name , k.highest_sales from products as p
join (
    select productid, max(salesamount) as highest_sales  from sales as s
                            group by productid
) k
on p.id=k.productid

5.Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
 with recursive  cte as (
     select 1 as number
     union all
     select number*2  from cte
                      where number*2<1000000
 )
select * from cte;
6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)

with cte as (
select employeeid , count(employeeid) as countnumber  from sales
group by employeeid
order by employeeid)
select firstname, lastname, countnumber from cte
join employees  as e
on cte.employeeid=e.employeeid
where cte.countnumber>5;

7.Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

 with cte as (select productid, sum(salesamount)  as total
             from sales as s
             group by productid)
select product_name , total from cte
join products as p
on p.id=cte.productid
 where total>500

 8.Create a CTE to find employees with salaries above the average salary.(Employees)

with cte as (
    select avg(salary) as avg_salary from employees
)
select firstname  , lastname, salary  from employees as e
join cte
on e.salary>cte.avg_salary;

       --Medium Tasks

1.Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)


select  firstname , lastname , k.number_of_orders   from employees  as e
join (
    select employeeid , count(*) as number_of_orders from sales
                                 group by employeeid
)  k
on k.employeeid=e.employeeid
order by k.number_of_orders
limit 5;

2.Write a query using a derived table to find the sales per product category.(Sales, Products)



select k.category_id , sum(k.salesamount) from (
    select  category_id , s.salesamount from sales as s
  join products as p
                                on s.productid=p.id
                                               ) k


group by k.category_id


3.Write a script to return the factorial of each value next to it.(Numbers1)



WITH RECURSIVE FactorialCTE AS (
    SELECT Number, 1 AS n, 1 AS factorial
    FROM Numbers1

    UNION ALL

    SELECT Number, n + 1, factorial * (n + 1)
    FROM FactorialCTE
    WHERE n < Number
)
SELECT Number, MAX(factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number;

4. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)

WITH RECURSIVE splitter AS (
    SELECT
        Id,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character,
        String
    FROM Example

    UNION ALL

    SELECT
        Id,
        Position + 1,
        SUBSTRING(String, Position + 1, 1),
        String
    FROM splitter
    WHERE Position < LENGTH(String)
)
SELECT Id, Position, Character
FROM splitter
ORDER BY Id, Position;

5.Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
