                               --TASKS on Stored Procedures and MERGE
 --Task 1:
 /*Create a stored procedure that:

Creates a temp table #EmployeeBonus
Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
(BonusAmount = Salary * BonusPercentage / 100)
Then, selects all data from the temp table.

  */


create procedure EmployeeBonus
as
    begin
    create table #EmployeeBonuses (
 employeeid int, fullname nvarchar(40), Department nvarchar(60), salary decimal(10,2), BonusAmount decimal(10,2)
     );
insert into #EmployeeBonuses(employeeid, fullname, Department, Salary, BonusAmount)
select e.employeeid, concat(e.firstname ,' ' ,e.lastname) as fullname ,  e.department, e.salary , (e.salary*db.BonusPercentage) as BonusAmount
from Employees as e
inner join Departmentbonus as db
on e.department=db.department;
select * from #EmployeeBonuses;
end;


 --Task 2:
    /*
Create a stored procedure that:

Accepts a department name and an increase percentage as parameters
Update salary of all employees in the given department by the given percentage
Returns updated employees from that department.

     */

create procedure  UpdateDepartmentSalary
@deptname nvarchar(40),
@IncreasePercent decimal(10,2)
as
    begin
update  employees
set salary=salary+(salary*@IncreasePercent / 100)
where department=@Deptname;

select
employeeid,
firstname,
lastname ,
department,
salary from employees
where department=@deptname
end;

           --Part 2: MERGE Tasks

 /*
  Task 3:
Perform a MERGE operation that:

Updates ProductName and Price if ProductID matches
Inserts new products if ProductID does not exist
Deletes products from Products_Current if they are missing in Products_New
Return the final state of Products_Current after the MERGE.
 */

merge into Products_Current as target
using Products_New as source
on target.productid=source.productid
when matched then
update set
           productName=source.productName ,
           price=source.price
when not matched by target then
insert (productid, productname, price)
values(source.productid,source.productname,source.price)
when not matched by source then
delete ;

    --Task 4:
/*
 Tree Node

Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.
 */
    SELECT id,
       CASE
           WHEN p_id IS NULL THEN 'Root'
           WHEN id NOT IN
                  (SELECT p_id
                   FROM tree
                   WHERE p_id IS NOT NULL) THEN 'Leaf'
           ELSE 'Inner'
       END AS TYPE
FROM tree
ORDER BY id;

 --

 SELECT s.user_id,
       Round(Sum(CASE
                   WHEN action = 'confirmed'THEN 1
                   ELSE 0
                 END) * 1.00 / Isnull(Count(CASE
                                              WHEN action = 'confirmed'THEN 1
                                              ELSE 0
                                            END), 0), 2) AS confirmation_rate
FROM   signups AS s
       LEFT JOIN confirmations AS c
              ON s.user_id = c.user_id
GROUP  BY s.user_id

6.Find employees with the lowest salary

select *from employees
where salary = (select min(salary) from employees)

7.Get Product Sales Summary
/*
 Create a stored procedure called GetProductSalesSummary that:

Accepts a @ProductID input
Returns:
ProductName
Total Quantity Sold
Total Sales Amount (Quantity × Price)
First Sale Date
Last Sale Date
If the product has no sales, return NULL for quantity, total amount, first date, and last date, but still return the product name.
 */
CREATE PROCEDURE dbo.GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT
        p.ProductName,
        SUM(s.Quantity) AS Total_Quantity_Sold,
        SUM(s.Quantity * p.Price) AS Total_Sales_Amount,
        MIN(s.SaleDate) AS First_Sale_Date,
        MAX(s.SaleDate) AS Last_Sale_Date
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName, p.ProductID;
END;
