1.
select p.firstName, p.lastName,  a.city,a.state from Person  as p
    left join Address as a on p.personId=a.personId


2.
select e1.name  as employee from employee as e1
inner  join employee as e2
on e1.managerid=e2.id
where e1.salary>e2.salary;

3.
select email  as Email from person
group by email
having count(id)>1

4.
WITH MinIds AS (
    SELECT MIN(id) AS min_id
    FROM Person
    GROUP BY email
)
DELETE FROM Person
WHERE id NOT IN (SELECT min_id FROM MinIds);

5.

select  distinct  g.parentname as ParentName  from girls as g
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

select * from cart1 as c1
full outer  join  cart2 as c2
on c1.item=c2.item;

8.
select c.name as customers  from customers as c
left join orders as o
on c.id=o.customerid
where  o.id is   null

9.
  SELECT
    s.student_id,
    s.student_name,
    sb.subject_name,
    COUNT(e.student_id) AS attended_exams
FROM
    Students s
CROSS JOIN
    Subjects sb
LEFT JOIN
    Examinations e
ON
    s.student_id = e.student_id
    AND sb.subject_name = e.subject_name
GROUP BY
    s.student_id,
    s.student_name,
    sb.subject_name
ORDER BY
    s.student_id,
    sb.subject_name;
