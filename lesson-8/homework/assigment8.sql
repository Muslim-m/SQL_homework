-- Easy-Level Tasks
1.Using Products table, find the total number of products available in each category.
select category ,count(*) as Number_of_product from products
group by category;
2.Using Products table, get the average price of products in the 'Electronics' category.
select  avg(price) as Average_Price from products
 where category='Electronics';

3.Using Customers table, list all customers from cities that start with 'L'.
select * from customers
where city like 'L%';
4.Using Products table, get all product names that end with 'er'.
select productname from products
where productname like '%er';
5.Using Customers table, list all customers from countries ending in 'A'.
Using Customers table, list all customers from countries ending in 'A'.
 select * from customers
 where country like '%A';
6.Using Products table, show the highest price among all products.
select MAX(price) as highestPrice from  Products;
7.Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
select productname,stockquantity, case when stockquantity<30 then 'Low Stock'
 else 'Sufficient' end  as Stock from products;

8.Using Customers table, find the total number of customers in each country.
select country , count(*) as Total_customer from customers
group by country;
9.Using Orders table, find the minimum and maximum quantity ordered.
select min(quantity) as minquantity , max(quantity) as maxquantity from orders;
    --#Medium-Level Tasks
10 Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.;
SELECT DISTINCT o.CustomerID
FROM Orders o
LEFT JOIN Invoices i ON o.CustomerID = i.CustomerID
WHERE YEAR(o.OrderDate) = 2023 AND MONTH(o.OrderDate) = 1
AND i.CustomerID IS NULL;
11.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
select productname  from products
union all
select productname from products_discounted;
12.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
    select productname  from products
union
select productname from products_discounted;
13.Using Orders table, find the average order amount by year.
SELECT YEAR(OrderDate) AS order_year, AVG(TotalAmount) AS avg_order_amount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY order_year;
14.Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
select productname, case when  price<100 then 'Low'
 when  price between 100 and 500  then 'Mid' else 'High' end as ProductCategory from Products;
15.Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
CREATE TABLE Population_Each_Year AS
SELECT
    district_id,
    district_name,
    SUM(CASE WHEN year = '2012' THEN population ELSE 0 END) AS "2012",
    SUM(CASE WHEN year = '2013' THEN population ELSE 0 END) AS "2013"
FROM city_population
GROUP BY district_id, district_name;
16.Using Sales table, find total sales per product Id.
select productid,sum(saleamount) as Totalsales  from sales
group by productid ;
17.Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
select productname  from products
where productname like '%oo%';
18.Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
   CREATE TABLE Population_Each_City AS
SELECT
    year,
    SUM(CASE WHEN district_name = 'Bektemir' THEN population ELSE 0 END) AS Bektemir,
    SUM(CASE WHEN district_name = 'Chilonzor' THEN population ELSE 0 END) AS Chilonzor,
    SUM(CASE WHEN district_name = 'Yakkasaroy' THEN population ELSE 0 END) AS Yakkasaroy,
    SUM(CASE WHEN district_name = 'Mirobod' THEN population ELSE 0 END) AS Mirobod,
    SUM(CASE WHEN district_name = 'Yashnobod' THEN population ELSE 0 END) AS Yashnobod
FROM city_population
GROUP BY year;

--Hard-Level Tasks
19.Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT CustomerID, SUM(totalamount) AS Totalspent
FROM invoices
GROUP BY CustomerID
ORDER BY Totalspent DESC
LIMIT 3;
20.Transform Population_Each_Year table to its original format (City_Population).
      CREATE TABLE City_Population_Restored AS
SELECT
    district_id,
    district_name,
    "2012" AS population,
    '2012' AS year
FROM Population_Each_Year
WHERE "2012" > 0
UNION ALL
SELECT
    district_id,
    district_name,
    "2013" AS population,
    '2013' AS year
FROM Population_Each_Year
WHERE "2013" > 0;
21 Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT
    p.ProductName,
    COUNT(s.SaleID) AS TimesSold
FROM
    Products p
JOIN
    Sales s ON p.ProductID = s.ProductID
GROUP BY
    p.ProductName
ORDER BY
    TimesSold DESC;
22.Transform Population_Each_City table to its original format (City_Population).
CREATE TABLE City_Population_Restored AS
SELECT
    year,
    'Bektemir' AS district_name,
    Bektemir AS population
FROM Population_Each_City
WHERE Bektemir > 0
UNION ALL
SELECT
    year,
    'Chilonzor' AS district_name,
    Chilonzor AS population
FROM Population_Each_City
WHERE Chilonzor > 0
UNION ALL
SELECT
    year,
    'Yakkasaroy' AS district_name,
    Yakkasaroy AS population
FROM Population_Each_City
WHERE Yakkasaroy > 0
UNION ALL
SELECT
    year,
    'Mirobod' AS district_name,
    Mirobod AS population
FROM Population_Each_City
WHERE Mirobod > 0
UNION ALL
SELECT
    year,
    'Yashnobod' AS district_name,
    Yashnobod AS population
FROM Population_Each_City
WHERE Yashnobod > 0;
