@SQL (@ = Discuss; # = Selection; - = Example)

#SELECT
SELECT column1, column2, ...
FROM table_name;

-SELECT CustomerName, City FROM Customers;

SELECT * FROM table_name;
-SELECT * FROM Customers;

SELECT DISTINCT column1, column2, ...
FROM table_name;

-SELECT DISTINCT Country FROM Customers;

-SELECT COUNT(DISTINCT column1) FROM table_name;

-SELECT Count(*) AS DistinctCountries
 FROM (SELECT DISTINCT Country FROM Customers);

#WHERE
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-SELECT * FROM Customers
 WHERE Country='Mexico';

-SELECT * FROM Customers
 WHERE CustomerID=1;

#OPERATORS
=
>
<
>=
<=
<>
BETWEEN
LIKE
IN

#AND/OR/NOT
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;

-SELECT * FROM Customers
 WHERE Country='Germany' AND City='Berlin';

SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;

-SELECT * FROM Customers
 WHERE City='Berlin' OR City='München';

SELECT column1, column2, ...
FROM table_name
WHERE NOT condition;

-SELECT * FROM Customers
 WHERE NOT Country='Germany';

#COMBINING AND/OR/NOT
-SELECT * FROM Customers
 WHERE Country='Germany' AND (City='Berlin' OR City='München');

-SELECT * FROM Customers
 WHERE NOT Country='Germany' AND NOT Country='USA';

#ORDER BY
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;

-SELECT * FROM Customers
 ORDER BY Country DESC;

-SELECT * FROM Customers
 ORDER BY Country ASC, CustomerName DESC;

#INSERT INTO
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

-INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
 VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');

-INSERT INTO Customers (CustomerName, City, Country)
 VALUES ('Cardinal', 'Stavanger', 'Norway');

#NULL
SELECT column_names
FROM table_name
WHERE column_name IS NULL;

-SELECT CustomerName, ContactName, Address
 FROM Customers
 WHERE Address IS NULL;

SELECT column_names
FROM table_name
WHERE column_name IS NOT NULL;

-SELECT CustomerName, ContactName, Address
 FROM Customers
 WHERE Address IS NOT NULL;

#UPDATE
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

-UPDATE Customers
 SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
 WHERE CustomerID = 1;

#DELETE
DELETE FROM table_name WHERE condition;

-DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';

#LIMIT
SELECT column_name(s)
FROM table_name
WHERE condition
LIMIT number;

-SELECT * FROM Customers
 LIMIT 3;

#TOP
SELECT TOP number FROM table_name;

-SELECT TOP 3 * FROM Customers;

#MIN/MAX
SELECT MIN/MAX(column_name)
FROM table_name
WHERE condition;

-SELECT MIN/MAX(Price) AS SmallestPrice
 FROM Products;

#COUNT
SELECT COUNT(column_name)
FROM table_name
WHERE condition;

-SELECT COUNT(ProductID)
 FROM Products;

#AVG
SELECT AVG(column_name)
FROM table_name
WHERE condition;

-SELECT AVG(Price)
 FROM Products;

#SUM
SELECT SUM(column_name)
FROM table_name
WHERE condition;

-SELECT SUM(Quantity)
 FROM OrderDetails;

#LIKE
SELECT column1, column2, ...
FROM table_name
WHERE columnN LIKE pattern;

-SELECT * FROM Customers
 WHERE CustomerName LIKE 'a%';

-SELECT * FROM Customers
 WHERE CustomerName LIKE '%a';

-SELECT * FROM Customers
 WHERE CustomerName LIKE '%or%';

-SELECT * FROM Customers
 WHERE CustomerName LIKE '_r%';

-SELECT * FROM Customers
 WHERE CustomerName NOT LIKE 'a%';

#IN
SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1, value2, ...);

-SELECT * FROM Customers
 WHERE Country IN ('Germany', 'France', 'UK');

-SELECT * FROM Customers
 WHERE Country NOT IN ('Germany', 'France', 'UK');

SELECT column_name(s)
FROM table_name
WHERE column_name IN (SELECT STATEMENT);

-SELECT * FROM Customers
 WHERE Country IN (SELECT Country FROM Suppliers);

#BETWEEN
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;

-SELECT * FROM Products
 WHERE Price BETWEEN 10 AND 20;

-SELECT * FROM Products
 WHERE Price NOT BETWEEN 10 AND 20;

-SELECT * FROM Products
 WHERE Price BETWEEN 10 AND 20
 AND NOT CategoryID IN (1,2,3);

-SELECT * FROM Products
 WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
 ORDER BY ProductName;

-SELECT * FROM Orders
 WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

#ALIAS
SELECT column_name AS alias_name
FROM table_name;

-SELECT CustomerID AS ID, CustomerName AS Customer
 FROM Customers;

SELECT column_name(s)
FROM table_name AS alias_name;

-SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
 FROM Customers;

-SELECT o.OrderID, o.OrderDate, c.CustomerName
 FROM Customers AS c, Orders AS o
 WHERE c.CustomerName="Around the Horn" AND c.CustomerID=o.CustomerID;

#JOINS: LEFT/RIGHT/INNER/FULL/SELF
SELECT column_name(s)
FROM table1
LEFT/RIGHT/INNER/FULL JOIN table2
ON table1.column_name = table2.column_name;

-SELECT Orders.OrderID, Customers.CustomerName
 FROM Orders
 LEFT/RIGHT/INNER/FULL JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition;

-SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
 FROM Customers A, Customers B
 WHERE A.CustomerID <> B.CustomerID
 AND A.City = B.City
 ORDER BY A.City;

#UNION
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

-SELECT City, Country FROM Customers
 WHERE Country='Germany'
 UNION
 SELECT City, Country FROM Suppliers
 WHERE Country='Germany'
 ORDER BY City;

#GROUP BY
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);

-SELECT COUNT(CustomerID), Country
 FROM Customers
 GROUP BY Country
 ORDER BY COUNT(CustomerID) DESC;

#HAVING
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

-SELECT COUNT(CustomerID), Country
 FROM Customers
 GROUP BY Country
 HAVING COUNT(CustomerID) > 5
 ORDER BY COUNT(CustomerID) DESC;

-SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
 FROM Orders
 INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
 WHERE LastName = 'Davolio' OR LastName = 'Fuller'
 GROUP BY LastName
 HAVING COUNT(Orders.OrderID) > 25;

#EXISTS
SELECT column_name(s)
FROM table_name
WHERE EXISTS (SELECT column_name FROM table_name WHERE condition);

-SELECT SupplierName
 FROM Suppliers
 WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);

#ANY/ALL
SELECT column_name(s)
FROM table_name
WHERE column_name operator ANY (SELECT column_name FROM table_name WHERE condition);

-SELECT ProductName
 FROM Products
 WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);

SELECT column_name(s)
FROM table_name
WHERE column_name operator ALL (SELECT column_name FROM table_name WHERE condition);

-SELECT ProductName
 FROM Products
 WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);

#COMMENT
-SELECT * FROM Customers -- WHERE City='Berlin';
-/*Select all the columns
 of all the records
 in the Customers table:*/
SELECT * FROM Customers;
_______________________________________________________________________________

@DATABASE
#CREATE
CREATE DATABASE databasename;

-CREATE DATABASE testDB;

#DROP
DROP DATABASE databasename;

-DROP DATABASE testDB;

#BACKUP
BACKUP DATABASE databasename
TO DISK = 'filepath';

-BACKUP DATABASE testDB
 TO DISK = 'D:\backups\testDB.bak';

#CREATE TABLE
CREATE TABLE table_name (
column1 datatype,
column2 datatype,
column3 datatype,
....
);

-CREATE TABLE Persons (
  PersonID int,
  LastName varchar(255),
  FirstName varchar(255),
  Address varchar(255),
  City varchar(255)
);

#DROP TABLE
DROP TABLE table_name;

-DROP TABLE Shippers;

#ALTER TABLE
ALTER TABLE table_name
ADD column_name datatype;

-ALTER TABLE Persons
 ADD DateOfBirth date;

ALTER TABLE table_name
DROP COLUMN column_name;

-ALTER TABLE Persons
 DROP COLUMN DateOfBirth;

ALTER TABLE table_name
MODIFY COLUMN column_name datatype;

-ALTER TABLE Persons
 MODIFY COLUMN DateOfBirth year;

#NOT NULL
-CREATE TABLE Persons (
  ID int NOT NULL,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255) NOT NULL,
  Age int
);

-ALTER TABLE Persons
 MODIFY Age int NOT NULL;

#UNIQUE
-CREATE TABLE Persons (
  ID int NOT NULL,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255),
  Age int,
  UNIQUE (ID)
);

-ALTER TABLE Persons
 ADD UNIQUE (ID);

#PRIMARY KEY
-CREATE TABLE Persons (
  ID int NOT NULL,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255),
  Age int,
  PRIMARY KEY (ID)
);

-ALTER TABLE Persons
 ADD PRIMARY KEY (ID);

#FOREIGN KEY
-CREATE TABLE Orders (
  OrderID int NOT NULL,
  OrderNumber int NOT NULL,
  PersonID int,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

-ALTER TABLE Orders
 ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

#CHECK
-CREATE TABLE Persons (
  ID int NOT NULL,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255),
  Age int CHECK (Age>=18)
);

-ALTER TABLE Persons
 ADD CHECK (Age>=18);

#DEFAULT
-CREATE TABLE Persons (
  ID int NOT NULL,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255),
  Age int,
  City varchar(255) DEFAULT 'Sandnes'
);

-ALTER TABLE Persons
 ALTER City SET DEFAULT 'Sandnes';

#CREATE VIEW
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-CREATE VIEW [Brazil Customers] AS
 SELECT CustomerName, ContactName
 FROM Customers
 WHERE Country = "Brazil";

#MERGE
95
