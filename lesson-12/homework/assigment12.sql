1.
select firstName, lastName,  city,state from Person  as p  left join Address as a on p.personId=a.personId


2.
select a.name  as employee from employee as a
inner  join employee as b
on a.managerid=b.id
where a.salary>b.salary;


3.
select email from person
group by email
having count(id)>1

4.
delete from person
where id  not in
(
    select min(id) from person
    group by email
)

5.
select g.parentname from girls as g
left join boys as b
on g.parentname=b.parentname
where b.parentname is null
6.
SELECT custid, SUM(unitprice*qty*(1-discount)), MIN(weight) FROM [TSQL2012].[Sales].[Orders] o
join [TSQL2012].[Sales].[OrderDetails] od
on o.orderid = od.orderid
where weight > 50
group by custid

7.

select * from cart1 as t
full outer  join  cart2 as l
on t.item=l.item;

8.
select c.name as customers  from customers as c
left join orders as o
on c.id=o.customerid
where  o.id is   null

9.
Select s.student_id, s.student_name, sb.subject_name, count(e.student_id) attended_exams from Students s cross join Subjects sb left join Examinations e on s.student_id = e.student_id and sb.subject_name = e.subject_name
group by s.student_id, s.student_name, sb.subject_name
order by s.student_id, student_name
