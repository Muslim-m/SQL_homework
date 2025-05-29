    -- ##Basic-Level Tasks (10)
   --  1. Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
     CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL
);


-- 2.Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
--First approach "Single-row insert:"
INSERT INTO Employees(EMPID, NAME, SALARY) VALUES
(1,'Muslimbek' ,5500.00);
--Second approach " Another single-row insert (optional variation)"
INSERT INTO Employees VALUES (2,'Diyor',6300.40);

--Third approach "Multiple-row insert"
INSERT INTO  Employees VALUES (3,'Trump',8000.00),
                              (4,'John',4500.00),
                              (5,'Franklin',7000.00);
--3.Update the Salary of an employee to 7000 where EmpID = 1.
UPDATE Employees
SET Salary=7000
WHERE EmpID=1;
--4 Delete a record from the Employees table where EmpID = 2.
DELETE  FROM Employees WHERE EmpID=2;
--5 Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
FIRST OFF ALL, i am going to provide definition for each ones
DELETE: Removes specific rows from a table based on a condition, leaving the table structure intact. It’s logged and can be rolled back.

TRUNCATE: Removes all rows from a table, resetting it to empty while keeping the structure. It’s faster than DELETE, minimally logged, and cannot be rolled back in some databases.

DROP: Completely removes a table or database object, including its structure and data, with no recovery option in most cases.
Additionally , if i give an answer when we use DELETE, TRUNCATE, and DROP, you  can read folloing rows about usage of them
  DELETE: When you need to remove specific rows or want to trigger actions and keep table structure.
  TRUNCATE:When you want to quickly and fully empty a table without logging each deletion.
 DROP:When the table or database is no longer needed and you want to remove it entirely.
Nevertheless, I am going to SHOW their practice in sql
1. Use DELETE to remove an employee with a salary below 5000:
       DELETE FROM Employees
WHERE Salary < 5000;
2. Use TRUNCATE to remove all data from the Employees table:
TRUNCATE TABLE Employees;
3. Use DROP to permanently delete the Employees table:
            DROP TABLE Employees;
--6 Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE  Employees
ALTER COLUMN  Name VARCHAR(100);
--7 Add a new column Department (VARCHAR(50)) to the Employees table.
ALTER TABLE  Employees
ADD  Department varchar(50);
--8 Change the data type of the Salary column to FLOAT.
ALTER TABLE Employees
ALTER  COLUMN Salary FLOAT;
--9 Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
CREATE TABLE Departments(
 DepartmentID INT PRIMARY KEY ,
    DepartmentName VARCHAR(50)
);
--10 Remove all records from the Employees table without deleting its structure.
TRUNCATE TABLE Employees;




-- ##Intermediate-Level Tasks (6)
--11 Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
INSERT INTO TempDepartments (DepartmentID, DepartmentName, Location) VALUES
(1, 'Human Resources', 'New York'),
(2, 'Engineering', 'San Francisco'),
(3, 'Marketing', 'Chicago'),
(4, 'Finance', 'Boston'),
(5, 'Sales', 'Los Angeles');

--12 Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees
SET Department='Management'
WHERE Salary>5000;
--13 Write a query that removes all employees but keeps the table structure intact.
TRUNCATE TABLE Employees;
--14 Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN Department;
--15 Rename the Employees table to StaffMembers using SQL commands.
ALTER TABLE Employees
RENAME to StaffMembers;
--16 Write a query to completely remove the Departments table from the database.
DROP TABLE Departments;
----  #Advanced-Level Tasks (9)

--17 Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products(
    ProductID INT PRIMARY KEY ,
    StockQuantity INT,
    ProductName VARCHAR(80),
    Category VARCHAR(80),
    Price DECIMAL(10,2)
);
--18 Add a CHECK constraint to ensure Price is always greater than 0.
Alter  TABLE  Products
ADD CONSTRAINT CHK_Price  CHECK ( Price>0 );
--19 Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER  table Products
ADD StockQuantity INT  default 50;
--20 Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory' ,'COLUMN';
--21 Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (1, 'Wireless Mouse', 'Electronics', 25.99, 100);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (2, 'Gaming Keyboard', 'Electronics', 59.49, 75);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (3, 'Notebook', 'Stationery', 3.50, 200);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (4, 'Desk Lamp', 'Furniture', 18.75, 60);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (5, 'Water Bottle', 'Accessories', 9.99, 150);

--22 Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT * INTO Products_Backup FROM Products;
--23Rename the Products table to Inventory.
EXEC sp_rename 'Products', 'Inventory';

--24 Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

ALTER TABLE Inventory
ALTER  COLUMN Price Float;

--25Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.

Alter table Inventory
ADD ProductCode INT IDENTITY(1000,5);


