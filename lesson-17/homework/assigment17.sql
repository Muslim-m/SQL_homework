--1. You must provide a report of all distributors and their sales by region.
-- If a distributor did not have any sales for a region, rovide a zero-dollar value for that day.
-- Assume there is at least one sale for each region

    with cte as (select distinct r.region, d.distributor
                 from (
                              (select distinct region from regionsales) as r
                              cross join
                                  (select distinct distributor from regionsales) as d))
select cte.region , cte.distributor ,coalesce(sales,0) from cte
left join regionsales as rs
on rs.distributor=cte.distributor and rs.region=cte.region

order by Distributor

-- 2Find managers with at least five direct reports

with cte as ( select
managerid , count(managerid) as countnumber from employee
group by managerid
)
select e.name  from cte
inner join employee as e
on e.id=cte.managerid
where countnumber>=5;



--3 Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

with  cte as (
  select product_id , sum(unit) as totalunit from  orders
 where extract(year from order_date)=2020 and extract(month from order_date)=02
group by product_id
)
select product_name , totalunit from cte
inner join products as p
on p.product_id=cte.product_id
where totalunit>=100;

4. Write an SQL statement that returns the vendor from which each customer has placed the most orders

with cte as (
    select customerid , vendor , sum(count) total  from orders
                                            group by customerid, vendor
)
select customerid , vendor   from cte
where total=(select max(total) from cte as k
 where k.customerid=cte.customerid );

5.You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

6.Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

with cte as (
    select device_id, locations , count(*) from device
                                           group by device_id, locations
),
    cte2 as (
    select device_id , locations as max_signal_location ,
 row_number() over (partition by  device_id order by count(*) desc) as rn
    from device
    group by device_id, locations
    ),
    cte3 as (
select device_id, count(*) as no_of_signals, count(distinct locations) as no_of_location  from device
                                                                       group by device_id
    )
select cte2.device_id, no_of_location, max_signal_location , no_of_signals from cte2
join cte3
on cte2.device_id=cte3.device_id

where rn=1

7.Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
                                                                                                                                                           with cte as (
select avg(salary) as avg_salary, deptid
from employee
group by deptid )
select EmpID, EmpName,Salary from cte
join employee as e
on  cte.deptid=e.deptid
where salary>avg_salary


8.You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.


with cte as (
 select ticket_id, count(*) as match from tickets

 inner join winning_numbers
 on tickets.number=winning_numbers.number
 group by ticket_id )
select sum(case when match=3 then 100 when match=2 then 10 else 0 end) as total_winnings from cte



9.The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.



10.Write an SQL Statement to de-group the following data.

with recursive cte(product,quantity)  as (select product, 1 as quantity, quantity as orginal_quantity
                                          from grouped

                                          union all
                                          select product, 1, orginal_quantity - 1
                                          from cte
                                          where orginal_quantity > 1)
select product, quantity from cte
order by product
