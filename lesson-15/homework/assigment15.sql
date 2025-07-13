--Lesson-15: Subqueries and Exists
--Level 1: Basic Subqueries

 1. Find Employees with Minimum Salary
 Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)

select id, name , salary from employees
where salary=(select min(salary) as MIN_SALARY from employees);

2.Find Products Above Average Price
 TAsk:Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

select id, product_name, price  from products
where price>(select avg(price) as avg_price from products)


--Level 2: Nested Subqueries with Conditions
3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department.
 Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

select  id ,name   from employees
where  department_id=(select id from departments where  department_name ='Sales')

4. Find Customers with No Orders

 Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)

select customer_id , name  from customers
where  customer_id not in (select customer_id from orders )

--Level 3: Aggregation and Grouping in Subqueries

5. Find Products with Max Price in Each Category
Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)

 select id , product_name , price , p.category_id from products as p
join (select max(price) as maxprice , category_id from products group by category_id ) as max_prices
on p.price=max_prices.maxprice and p.category_id=max_prices.category_id;

6.Find Employees in Department with Highest Average Salary
Task: Retrieve employees working in the department with the highest average salary.
Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
 select name , department_id , salary from employees as e
join     departments  d
     on e.department_id=d.id
where e.salary>=(select avg(salary) from employees);

              --Level 4: Correlated Subqueries

7. Find Employees Earning Above Department Average
Task: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)

select id, name , salary , department_id from employees as e1
where salary>(select avg(salary) from employees as e2  where e1.department_id=e2.department_id )

8.Find Students with Highest Grade per Course
Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)


select g.student_id  , g.course_id,  s.name , g.grade from grades as g
inner join students  as s
on g.student_id=s.student_id
where (g.course_id, g.grade) in (select course_id , max(grade) from grades  group by  course_id)

         -- Level 5: Subqueries with Ranking and Complex Conditions

 9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category.
Tables: products (columns: id, product_name, price, category_id)

with cte as (
select product_name , price, category_id , row_number() over (partition by category_id order by price) as rn from products)
select * from cte
where  rn=3;



10. Find Employees whose Salary Between Company Average and Department Max Salary
Task: Retrieve employees with salaries above the company average but below the maximum in their department.
Tables: employees (columns: id, name, salary, department_id)


select id, name , salary , department_id from employees as e
where  salary>(select avg(salary) from employees) and
       salary<(select max(salary) from employees as e2
where e.department_id=e2.department_id);
