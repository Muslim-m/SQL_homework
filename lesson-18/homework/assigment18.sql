--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.

CREATE TABLE #MonthlySales
(
    productid INT,
    total_quantity INT,
    total_revenue DECIMAL(10,2)
)

INSERT INTO #MonthlySales
(
    productid,
    total_quantity,
    total_revenue
)
SELECT
    s.productid,
    SUM(s.quantity) AS total_quantity,
    SUM(s.quantity * p.price) AS total_revenue
FROM sales AS s
INNER JOIN products AS p
    ON s.productid = p.productid
WHERE YEAR(s.saledate) = 2025
    AND MONTH(s.saledate) = 7
GROUP BY s.productid;

SELECT * FROM #MonthlySales;



--2.Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.


CREATE VIEW vw_ProductSalesSummary AS
select s.productid,
    p.productname,
    p.category,
    coalesce(sum(s.quantity),0) as TotalQuantitySold from products as p
left join sales as s
on s.productid = p.productid
group by p.productid, p.productname, p.category


--3.Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
CREATE FUNCTION dbo.fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10,2);

    SELECT @TotalRevenue = COALESCE(SUM(p.price * s.quantity), 0)
    FROM products AS p
    LEFT JOIN sales AS s
        ON p.productid = s.productid
    WHERE p.productid = @ProductID;

    RETURN @TotalRevenue;
END;
--4.Create an function fn_GetSalesByCategory(@Category VARCHAR(50))

create function fn_GetSalesByCategory(@Category VARCHAR(50))
return table
as
    return(

select  p.productname , coalesce(sum(s.quantity),0) as TotalQuantity , coalesce(sum(s.quantity*p.price),0) as TotalRevenue from products as p
left join sales as s
on p.productid = s.productid
    where p.category=@category
group by p.productname
);

--5.you have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:
    CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;

    IF @Number <= 1
        RETURN 'No';
    IF @Number = 2
        RETURN 'Yes';

    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i += 1;
    END

    RETURN 'Yes';
END;
--6.Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
CREATE FUNCTION dbo.fn_GetNumbersBetween (@start_num INT, @end_num INT)
RETURNS @Result TABLE (number INT)
AS
BEGIN
    WITH Numbers AS (
        SELECT @start_num AS number
        UNION ALL
        SELECT number + 1
        FROM Numbers
        WHERE number < @end_num
    )
    INSERT INTO @Result
    SELECT number
    FROM Numbers;

    RETURN;
END;

SELECT * FROM dbo.fn_GetNumbersBetween(1, 23);





--7.Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.
CREATE FUNCTION getNthHighestSalary (@N INT)
RETURNS TABLE
AS
RETURN (
    SELECT
        (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            OFFSET @N - 1 ROWS FETCH NEXT 1 ROWS ONLY
        ) AS highestSalary
);


--8.Write a SQL query to find the person who has the most friends.
SELECT TOP 1 requester_id       AS id,
             Count(accepter_id) AS num
FROM   (SELECT requester_id,
               accepter_id
        FROM   requestaccepted
        UNION ALL
        SELECT accepter_id,
               requester_id
        FROM   requestaccepted) dt
GROUP  BY requester_id
ORDER  BY num DESC


--9.Create a View for Customer Order Summary.

select * from customers;
select * from orders;

create view  vw_CustomerOrderSummary as

select  c.customer_id , c.name, c.city ,
        count(o.order_id),
        sum(o.amount)

        from customers as c
left join orders as o
on c.customer_id = o.customer_id
group by c.customer_id, c.name, c.city

SELECT * FROM vw_CustomerOrderSummary;


--10.Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.

select g.RowNumber, dt.Workflow from Gaps as g
outer apply (
    select top 1 TestCase  as Workflow from Gaps as g2
                  where g2.RowNumber<=g.RowNumber and g2.TestCase is not null
                  order by g2.RowNumber desc

)dt
order by g.RowNumber;

