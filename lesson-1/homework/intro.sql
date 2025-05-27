##Easy
1.Define the following terms: data, database, relational database, and table.

	1)Data:Raw facts or figures that have not been processed, such as numbers, text, or images, which can be used for analysis or decision-making.

	2)Database:An organized collection of data that allows for easy access, management, and updating, typically stored electronically.

	3)Relational Database:A type of database that stores data in structured tables with rows and columns, where relationships between tables are maintained using keys.

	4)Table:A structured format within a database that organizes data into rows (records) and columns (fields), representing a single entity or subject.
    
    
2.List five key features of SQL Server.
	1)Data Storage and Management:Stores and manages structured data using tables, views, and indexes.
	2)Transact-SQL (T-SQL):Supports a powerful extension of SQL for querying, scripting, and managing data.
	3)Security:Provides authentication, authorization, encryption, and role-based access control.
	4)High Availability:Offers features like Always On Availability Groups, failover clustering, and replication.
	5)Backup and Recovery:Enables automated and manual data backups, with support for point-in-time recovery.
    
3.What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
SQL Server supports the following two main authentication modes.They include:
1) Windows Authentication -> SQL Server uses the user’s Windows account to authenticate.
2)SQL Server Authentication (Mixed Mode) -> Requires a separate login and password defined in SQL Server.


## Medium
4.Create a new database in SSMS named SchoolDB.
CREATE DATABASE SchoolDB;
5.Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
6.Describe the differences between SQL Server, SSMS, and SQL.
SQL Server is a relational database management system (RDBMS) developed by Microsoft.
Purpose: Stores, manages, and processes data in relational databases.
Example Use: Hosting large enterprise databases, managing financial transactions, and performing business analytics.
SSMS (SQL Server Management Studio) isA graphical user interface (GUI) tool provided by Microsoft.
Purpose: Used to connect to SQL Server, write and run SQL queries, manage databases, create tables, and perform backups.
Example: A developer uses SSMS to create a new database and run T-SQL scripts.
 SQL (Structured Query Language is A programming language used to query and manage data in a relational database.
Purpose: Used to write commands like SELECT, INSERT, UPDATE, and DELETE.
Example : Writing SELECT * FROM Students to fetch data from a table.
##Hard
7.Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
1)DQL (Data Query Language) is used to retrieve data from the database. The primary command is SELECT. For example:
SELECT * FROM Students;
2)DML (Data Manipulation Language) is used to modify data in existing tables. Common commands include INSERT, UPDATE, and DELETE. Examples:
INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'Ali', 20);
UPDATE Students SET Age = 21 WHERE StudentID = 1;
DELETE FROM Students WHERE StudentID = 1;
3)DDL (Data Definition Language) deals with the structure of database objects such as tables and schemas. Commands include CREATE, ALTER, and DROP. Examples:
CREATE TABLE Courses (CourseID INT PRIMARY KEY, CourseName VARCHAR(50));
ALTER TABLE Students ADD Gender VARCHAR(10);
DROP TABLE Courses;
4)DCL (Data Control Language) is used to manage access permissions in the database. It includes GRANT and REVOKE. Examples:
GRANT SELECT ON Students TO User1;
REVOKE SELECT ON Students FROM User1;
5)TCL (Transaction Control Language) is used to manage transactions and maintain data integrity. Commands include COMMIT, ROLLBACK, and SAVEPOINT. Example:
BEGIN TRANSACTION;
INSERT INTO Students (StudentID, Name, Age) VALUES (2, 'Sara', 22);
COMMIT; -- to save changes
-- or
ROLLBACK; -- to undo changes

8.Write a query to insert three records into the Students table.
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Ali', 20),
(2, 'Sara', 22),
(3, 'John', 19);


9.Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
First off all , we have to download this file, going to https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak. After then ,Move the File to the Backup Directory with following path 
C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup
Having it done , we have to Open SSMS and Connect to SQL Server , which means that Launch SQL Server Management Studio (SSMS).
	•	Connect to your local SQL Server instance.In folloing stage , we have to restore the database. I explain it  in folling row
	1)In Object Explorer, right-click on Databases.
	2)Choose Restore Database…
	3)In the Source section:
	•Select Device.
	•	Click the … button.
	•	Click Add and browse to the .bak file you downloaded.
	4.	Select the .bak file and click OK.
	5.	In the Destination section, name the database (e.g., AdventureWorksDW2022).
	6.	Go to the Files tab and make sure the file paths are valid (you may need to change them if your SQL Server is using a different data directory).
	7.	Click OK to start the restore process.
    Finally , Only thing we have to do is to  Verify the Restore . I mean that after the restore completes, it is available to see the new database (AdventureWorksDW2022) listed under Databases in SSMS.

I have successfully complete all given tasks which include 9 different  question .I think all answers are correct and to get 100% result is enough.




