-- Step 1
CREATE TABLE tblBook
(
	BookID INT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(100),
    Author VARCHAR(50),
    Price DECIMAL(5, 2),
    Stock INT,
    PRIMARY KEY (BookID)
);
CREATE TABLE tblCustomer
(
	CustomerID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE,
    PRIMARY KEY (CustomerID)
);
DROP TABLE tblCustomer;
CREATE TABLE tblOrder
(
	OrderID INT NOT NULL AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(8, 2),
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (CustomerID)
);
CREATE TABLE tblOrderDetails
(
	OrderDetailID INT NOT NULL AUTO_INCREMENT, 
    OrderID INT,
    BookID INT,
    Quantity INT,
    UnitPrice DECIMAL (5, 2),
    PRIMARY KEY (OrderDetailID),
    FOREIGN KEY (OrderID) REFERENCES tblOrder (OrderID),
    FOREIGN KEY (BookID) REFERENCES tblBook (BookID)
);
-- STEP 2
-- Insert 5 books
INSERT INTO tblBook (Title, Author, Price, Stock) VALUES('The Giving Tree','Shel Silverstien',5.97,4);
INSERT INTO tblBook (Title, Author, Price, Stock) VALUES('Farenheit 451','Ray Bradbury',10.99,2);
INSERT INTO tblBook (Title, Author, Price, Stock) VALUES('The Odyssey','Homer',24.97,6);
INSERT INTO tblBook (Title, Author, Price, Stock) VALUES('Re;Zero Volume 1','Tappei Nagatsuki',10.00,3);
INSERT INTO tblBook (Title, Author, Price, Stock) VALUES('The Book of Bill','Alex Hirsch',27.99,1);
SELECT * FROM tblBook;
-- Insert 3 customers
ALTER TABLE tblCustomer AUTO_INCREMENT = 100;
INSERT INTO tblCustomer (FirstName, LastName, Email, RegistrationDate) VALUES('Sebjin','Kennedy','sjkennedy43@tntech.edu','2024-07-14');
INSERT INTO tblCustomer (FirstName, LastName, Email, RegistrationDate) VALUES('Benjamin','Burchfield','bburchfield@tntech.edu','2002-12-03');
INSERT INTO tblCustomer (FirstName, LastName, Email, RegistrationDate) VALUES('Uncle','Sam','uSam@tntech.edu','1942-09-19');
SELECT * FROM tblCustomer;
-- Insert 2 orders per customer
ALTER TABLE tblOrder AUTO_INCREMENT = 200;
INSERT INTO tblOrder (CustomerID, OrderDate, TotalAmount) 
(100,'2024-07-14',10.99), (100, '2024-08-5',27.99), -- customer 100 ordered Faranheit451 & Book of Bill
(101,'2006-01-10',24.97), (101, '2006-03-25',10.99), -- customer 101 ordered Homer's Oddyssey and FaranHeit 451
(102,'1942-07-04',5.97), (102, '2021-12-13',10.99); -- customer 102 ordered The Giving Tree and Faranheit 451
DELETE FROM tblOrder WHERE TotalAmount = 37.99;
SELECT * FROM tblOrder;
-- Several Orders based on the books the customer ordered
ALTER TABLE tblOrderDetails AUTO_INCREMENT = 300;
INSERT INTO tblOrderDetails (OrderID, BookID, Quantity, UnitPrice) VALUES
(200,2,1,10.99),(206,5,1,27.99),
(202,3,1,24.97),(203,2,1,10.99),
(204,1,1,5.97),(205,2,1,10.99);
-- to add multiple types of books to one order, just put two order details under one order
SELECT * FROM tblOrderDetails;

-- STEP 3
-- Question 1
SELECT FirstName, LastName, RegistrationDate
FROM tblCustomer;
-- Question 2
SELECT CONCAT(tblCustomer.FirstName, ' ', tblCustomer.LastName) AS 'Full Name' , OrderDate, TotalAmount
FROM tblOrder
INNER JOIN tblCustomer ON tblCustomer.CustomerID = tblOrder.CustomerID;
-- Question 3
SELECT tblCustomer.FirstName, tblCustomer.LastName, SUM(TotalAmount) AS 'Total Spent'
FROM tblOrder
LEFT JOIN tblCustomer ON tblCustomer.CustomerID = tblOrder.CustomerID
GROUP BY tblCustomer.CustomerID;
-- Question 4
SELECT Title, Price AS 'Book Price'
FROM tblBook
ORDER BY Price DESC;
-- Question 5
SELECT DISTINCT(COUNT(*))
FROM tblCustomer;
-- Question 6
SELECT Title
FROM tblBook
WHERE NOT EXISTS
(SELECT BookID 
FROM tblOrderDetails 
WHERE tblBook.BookID = tblOrderDetails.BookID);
-- STEP 4 
UPDATE tblBook SET Price = 10.99 * 1.10 WHERE Title = 'Farenheit 451';
ALTER TABLE tblOrder
ADD CONSTRAINT del_fk_customer_order 
FOREIGN KEY (CustomerID) REFERENCES tblCustomer (CustomerID)
ON DELETE CASCADE;

ALTER TABLE tblOrderDetails
ADD CONSTRAINT del_fk_order_orderdetails
FOREIGN KEY (OrderID) REFERENCES tblOrder(OrderID)
ON DELETE CASCADE;

DELETE FROM tblCustomer WHERE CustomerID = '100';

-- STEP 5
SELECT tblCustomer.FirstName, tblCustomer.LastName, SUM(tblOrder.TotalAmount) AS 'Top 3 Total Spent'
FROM tblCustomer
LEFT JOIN tblOrder ON tblOrder.CustomerID = tblCustomer.CustomerID
GROUP BY tblCustomer.CustomerID 
ORDER BY SUM(tblOrder.TotalAmount) DESC
LIMIT 3;