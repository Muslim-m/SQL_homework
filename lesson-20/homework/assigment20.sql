--Lesson-20: Practice
--1. Find customers who purchased at least one item in March 2024 using EXISTS
SELECT DISTINCT saleid, customername, price, saledate
FROM #Sales AS s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales AS s2
    WHERE s2.customername = s1.customername
    AND saledate >= '2024-03-01'
    AND saledate < '2024-04-01'
)
AND s1.saledate >= '2024-03-01'
AND s1.saledate < '2024-04-01';

--2.Find the product with the highest total sales revenue using a subquery.
select product, sum(quantity*price) as highsales from sales
group by product
having sum(quantity*price)=(
select max(total) from (
select sum(quantity*price) as total  from sales
group by product) dt);

--3.Find the second highest sale amount using a subquery
SELECT product, SUM(quantity * price) AS total_sales
FROM #Sales
GROUP BY product
HAVING SUM(quantity * price) = (
    SELECT MAX(total)
    FROM (
        SELECT SUM(quantity * price) AS total
        FROM #Sales
        GROUP BY product
        ORDER BY total DESC
        OFFSET 1 ROWS FETCH FIRST 1 ROW ONLY
    ) dt
);
--4.Find the total quantity of products sold per month using a subquery

SELECT
    MonthlySales.SaleMonth,
    MonthlySales.TotalQuantity
FROM (
    SELECT
        MONTH(SaleDate) AS SaleMonth,
        SUM(Quantity) AS TotalQuantity
    FROM #Sales
    GROUP BY MONTH(SaleDate)
) AS MonthlySales;

--5.Find the total quantity of products sold per month using a subquery

select * from sales as s1
where  exists(
    select * from  sales s2
             where s1.product=s2.product and s1.customername<>s2.customername);

--6 Return how many fruits does each person have in individual fruit level
 select name ,  sum(case when fruit='Apple' then 1 else 0 end) as Apple ,
  sum(case when fruit='Orange' then 1 else 0 end) as Orange ,
   sum(case when fruit='Banana' then 1 else 0 end) as Banana

 from fruits
 group by name;

--7. Return older people in the family with younger ones

WITH Ancestors AS (
    -- Anchor member: direct relationships
    SELECT ParentId, ChildID
    FROM Family
    UNION ALL
    -- Recursive member: find grandchildren, great-grandchildren, etc.
    SELECT A.ParentId, F.ChildID
    FROM Ancestors A
    JOIN Family F ON A.ChildID = F.ParentId
)
SELECT DISTINCT ParentId AS PID, ChildID AS CHID
FROM Ancestors
ORDER BY PID, CHID;

--8. Write an SQL statement given the following requirements.
-- For every customer that had a delivery to California,
-- provide a result set of the customer orders that were delivered to Texas

select * from orders as o1
where deliverystate ='TX' and exists(
    select 1 from orders as o2
             where o1.customerid=o2.customerid and o2.deliverystate='CA'
)

--9.Insert the names of residents if they are missing.
UPDATE #residents
SET address = CONCAT(address, ' name=', fullname)
WHERE address NOT LIKE '%name=' + fullname;

--10 Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes
-- Build the recursive route explorer
WITH RoutePaths AS (
    SELECT
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        ArrivalCity,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT
        RP.Route + ' - ' + R.ArrivalCity,
        R.ArrivalCity,
        RP.Cost + R.Cost
    FROM RoutePaths RP
    JOIN #Routes R ON RP.ArrivalCity = R.DepartureCity
    WHERE RP.Route NOT LIKE '%' + R.ArrivalCity + '%'
)
SELECT TOP 1 WITH TIES Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC
UNION ALL
SELECT TOP 1 WITH TIES Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost DESC;

--11.Rank products based on their order of insertion.



 /*
 +----+-------+--------------+--------------+
| ID | Vals  | ProductGroup | ProductRank  |
+----+-------+--------------+--------------+
| 2  | a     | a            | 1            |
| 3  | a     | a            | 1            |
| 4  | a     | a            | 1            |
| 5  | a     | a            | 1            |
| 7  | b     | b            | 2            |
| 8  | b     | b            | 2            |
|10  | c     | c            | 3            |
+----+-------+--------------+--------------+
 */
WITH Grouped AS (
    SELECT *,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END)
            OVER (ORDER BY ID) AS GroupID
    FROM #RankingPuzzle
),
Filtered AS (
    -- Remove the rows that are just 'Product'
    SELECT ID, Vals, GroupID
    FROM Grouped
    WHERE Vals <> 'Product'
),
Labeled AS (
    -- Assign ProductGroup and Rank
    SELECT
        ID,
        Vals,
        GroupID,
        MIN(Vals) OVER (PARTITION BY GroupID) AS ProductGroup,
        DENSE_RANK() OVER (ORDER BY GroupID) AS ProductRank
    FROM Filtered
)
SELECT
    ID, Vals, ProductGroup, ProductRank
FROM Labeled
ORDER BY ID;
--12 Find employees whose sales were higher than the average sales in their department

with cte as (
select employeename, department,salesamount ,
       avg(salesamount) over (partition by department ) as avg_sale from employeesales )
select * from cte
where salesamount>avg_sale;



--13.Find employees who had the highest sales in any given month using EXISTS

SELECT *
FROM EmployeeSales ES1
WHERE EXISTS (
    SELECT 1
    FROM EmployeeSales ES2
    WHERE ES1.SalesMonth = ES2.SalesMonth
      AND ES1.SalesYear = ES2.SalesYear
    GROUP BY ES2.SalesMonth, ES2.SalesYear
    HAVING ES1.SalesAmount = MAX(ES2.SalesAmount)
);
--14. Find employees who made sales in every month using NOT EXISTS
-- Find employees who made sales in every month (year+month pair)
SELECT DISTINCT ES1.EmployeeID, ES1.EmployeeName
FROM EmployeeSales ES1
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth, SalesYear
        FROM EmployeeSales
    ) AS AllMonths
    WHERE NOT EXISTS (
        SELECT 1
        FROM EmployeeSales ES2
        WHERE ES2.EmployeeID = ES1.EmployeeID
          AND ES2.SalesMonth = AllMonths.SalesMonth
          AND ES2.SalesYear = AllMonths.SalesYear
    )
);
--15.Retrieve the names of products that are more expensive than the average price of all products.
SELECT name, category, price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);
--16.Find the products that have a stock count lower than the highest stock count.
SELECT *
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);

--17.Get the names of products that belong to the same category as 'Laptop'.




SELECT Name
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'Laptop'
)
AND Name <> 'Laptop';

--18.Retrieve products whose price is greater than the lowest price in the Electronics category.
select * from products
order by category;
select * from products
where price>(select min(price) from products where category='Electronics')
--19.Find the products that have a higher price than the average price of their respective category.
select * from products as p
where price > (select avg(price) from products  where category=category)


--20 Find the products that have been ordered at least once
SELECT *
FROM Products
WHERE ProductID IN (
    SELECT DISTINCT ProductID
    FROM Orders
);
--21 Retrieve the names of products that have been ordered more than the average quantity ordered.
select  name  from products as p
inner join orders as o
on p.productid = o.productid
where o.quantity>(select avg(quantity) from orders);

--22. Find the products that have never been ordered.

SELECT *
FROM Products P
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders O
    WHERE O.ProductID = P.ProductID
);

--23.Retrieve the product with the highest total quantity ordered.


with cte as (
select productid , sum(quantity) as total from orders
group by productid) ,
    cte2 as (
        select max(total) as  max_total from cte
        )
    select p.name , p.category, p.price ,  max_total from products as p
inner join cte
 ON cte.ProductID = p.ProductID
inner join cte2
on cte2.max_total=cte.total












