## Easy-Level Tasks (10)
  #1 Define and explain the purpose of BULK INSERT in SQL Server.
            Definition: BULK INSERT is a Transact-SQL command in SQL Server that efficiently imports large volumes of data from a text or CSV file into a database table.

Purpose:
High Performance: Loads data in a single, optimized operation, significantly faster than individual INSERT statements.
Data Migration: Ideal for transferring large datasets during migrations or system integrations.
ETL Processes: Commonly used in Extract, Transform, Load (ETL) workflows to import external data.
Customizable: Supports options like FIELDTERMINATOR, ROWTERMINATOR, and FIRSTROW to handle various file formats.
   BULK INSERT TableName
FROM 'file_path'
WITH (
    FIELDTERMINATOR = 'delimiter',
    ROWTERMINATOR = 'row_delimiter',
    FIRSTROW = n
);
 #2 List four file formats that can be imported into SQL Server.
    1)	CSV (Comma-Separated Values)
	2)	TXT (Plain Text Files)
	3)	XML (eXtensible Markup Language)
	4)	JSON (JavaScript Object Notation)
# 3 Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);
# 4 Insert three records into the Products table using INSERT INTO.
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Smartphone', 800.50),
(3, 'Headphones', 150.75);
#5 Explain the difference between NULL and NOT NULL.
NULL means that a field doesn’t have any value — it’s empty or unknown. We use NULL when we want to allow missing or optional information. For example, if a customer doesn’t provide a phone number, the phone number column can be NULL because it’s okay to not have that data.

NOT NULL means the field must have a value; it cannot be left empty. We use NOT NULL when the information is required and important for the record. For example, a product’s name should never be empty, so the ProductName column is set as NOT NULL.

Purpose:
	NULL allows flexibility to store incomplete data.
	NOT NULL enforces that critical data is always present.
	What's more , i am goint to provide an example to be understandable
                    CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NULL  -- Email can be empty
);
#6 Add a UNIQUE constraint to the ProductName column in the Products table.
alter table Products
add constraint unique_productname unique(ProductName);
#7Write a comment in a SQL query explaining its purpose.
-- This query inserts a new product into the Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (4, 'Tablet', 499.99);
Purpose of the Comment:
The comment explains what the SQL statement is doing, which helps others (or your future self) understand the purpose of the code. It improves readability, maintainability, and makes the query easier to follow, especially in large or complex databases.
#8 Add CategoryID column to the Products table.
alter table Products
add  CategoryID int;
#9 Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(40) UNIQUE
);
#10 Explain the purpose of the IDENTITY column in SQL Server.
Purpose: The IDENTITY property automatically generates sequential numeric values for a column, typically used for unique row identification (e.g., primary keys).
Key Features:

Auto-Increment: Generates values based on a seed (starting value) and increment (step value).


Uniqueness: Ensures unique values for each row, ideal for primary keys.


Performance: Numeric IDENTITY columns are efficient for indexing and querying.


No Manual Input: Eliminates the need for custom logic to generate unique IDs.
Syntax: column_name INT IDENTITY(seed, increment)
 Example:CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50)
);
-- Inserts a row with StudentID = 1 automatically
INSERT INTO Students (Name) VALUES (''John'');                                           '
                                            '
Non-Editable: IDENTITY values cannot be updated directly.
##Medium-Level Tasks (10)
#11 Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT Products
FROM 'C:\Users\Maab\Desktop\products.txt'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '\n',
    FIRSTROW = 1
);
#12  Create a FOREIGN KEY in the Products table that references the Categories table.
            ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

# 13 Explain the differences between PRIMARY KEY and UNIQUE KEY.
PRIMARY KEY:
Uniquely identifies each row in a table.
Does not allow NULL values.
Only one PRIMARY KEY per table (can be composite).
Typically has a clustered index (unless specified otherwise).
Used as the main identifier for rows, often referenced by FOREIGN KEYs.
Example: CustomerID in a Customers table.
UNIQUE KEY:
Ensures all values in the column(s) are unique.
Allows one NULL value in SQL Server.
Multiple UNIQUE KEY constraints can exist per table.
Typically has a non-clustered index.
Used for columns that must be unique but aren’t the primary identifier (e.g., Email).
I want to provide example :
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY, -- No NULLs, clustered index
    Email VARCHAR(100) UNIQUE  -- Allows one NULL, non-clustered index
);

#14 Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);
#15 Modify the Products table to add a column Stock (INT, NOT NULL).
ALTER TABLE Products
ADD Stock INT NOT NULL;
#16 Use the ISNULL function to replace NULL values in Price column with a 0.
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;
#17 Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
FOREIGN KEY constraints in SQL Server are used to enforce referential integrity between tables. Their main purpose is to ensure that a value in one table (the child table) matches a value in another table (the parent table), preventing invalid data and maintaining consistent relationships.
Purpose:
	•	Maintain data consistency: Prevents entering a value in the child table’s foreign key column that doesn’t exist in the parent table’s primary key.
	•	Enforce relationships: Helps model real-world relationships between entities (like products belonging to categories).
	•	Protect data integrity: Avoids orphan records (e.g., products linked to non-existent categories).
Usage:
	•	Define a foreign key column in the child table.
	•	Reference a primary key (or unique key) column in the parent table.
	•	SQL Server automatically checks data on INSERT, UPDATE, and DELETE to enforce the constraint.
Example :
 ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);


##Hard-Level Tasks (10)
##18.Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT,
    CONSTRAINT CHK_Age CHECK (Age >= 18)
);
## 19.Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE Orders (
    OrderID INT IDENTITY(100, 10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerName VARCHAR(100) NOT NULL
);
##20 Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);
## 21 Explain the use of COALESCE and ISNULL functions for handling NULL values.
      ISNULL:
Function: Replaces a NULL value with a specified replacement value.
Syntax: ISNULL(expression, replacement)
Details:
Takes two arguments.
SQL Server-specific.
Returns the type of the first argument.
Faster for simple NULL replacements.
Example: SELECT ISNULL(Price, 0) AS Price FROM Products;
-- Returns 0 if Price is NULL
COALESCE:
Function: Returns the first non-NULL value from a list of expressions.
Syntax: COALESCE(expression1, expression2, ..., expressionN)
Details:
Takes two or more arguments.
ANSI SQL standard, portable across databases.
More flexible for evaluating multiple expressions.
Returns the type of the highest-precedence argument.
example:
SELECT COALESCE(Price, DiscountPrice, 0) AS FinalPrice FROM Products;
-- Returns Price, DiscountPrice, or 0 (first non-NULL)
#22 Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    HireDate DATE NOT NULL
);
#23 Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Orders
FOREIGN KEY (OrderID)
REFERENCES Orders (OrderID)
ON DELETE CASCADE
ON UPDATE CASCADE;

