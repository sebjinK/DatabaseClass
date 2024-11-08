-- Create tables for question 1
CREATE TABLE tblOrderItemsData
(
	OrderItemID VARCHAR (32),
    Description VARCHAR (50), 
    Quantity INT,
    Price DECIMAL (2, 2),
    OrderID VARCHAR (32),
	PRIMARY KEY (OrderItemID),
    FOREIGN KEY (OrderID) REFERENCES tblOrderData (OrderNumber)
);
CREATE TABLE tblOrderData
(
	OrderNumber VARCHAR (32),
    OrderDateAndTime DATETIME,
    DeliveryIndicator BOOLEAN,
    CustomerID VARCHAR (32),
    PRIMARY KEY (OrderNumber),
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (CustomerID)
);
CREATE TABLE tblCustomerAddresses
(
	AddressID VARCHAR (32),
    Street1 VARCHAR (85),
    Street2 VARCHAR (85),
    City VARCHAR (25),
    State VARCHAR (2),
    ZIPCode VARCHAR (5),
    CustomerID VARCHAR (32),
	PRIMARY KEY (AddressID),
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (CustomerID)
);
CREATE TABLE tblCustomer
(
	CustomerID VARCHAR (32),
    FirstName VARCHAR (25),
    LastName VARCHAR (35),
    PhoneAreaCode VARCHAR (3),
    PhoneNumber VARCHAR (7),
    PRIMARY KEY (CustomerID)
);

-- Was having logic issues until I realized how one to many works
ALTER TABLE tblCustomer DROP COLUMN Addresses;
SELECT * FROM tblCustomer;

-- PETAH GRIFFITH Info for Question 2 
INSERT INTO tblCustomer VALUES('AAA111','Peter','Griffin','931','5262125');
INSERT INTO tblCustomerAddresses VALUES('AAAA1111','10 E Broad Street','','Cookeville','TN','38506','AAA111');

-- Question 3 Order
INSERT INTO tblOrderData VALUES('220925-01','2024-09-25 02:00:00',True,'AAA111');
INSERT INTO tblOrderItemsData VALUES('SAUS-PIZ','Sausage Pizza',2,14.53,'220925-01');

-- Question 4 Update Price of all Sausage Pizza entries to show a price of 12.99
UPDATE tblOrderItemsData SET Price = 12.99 WHERE Description = 'Sausage Pizza';

-- Question 5 Add to order 220925
INSERT INTO tblOrderItemsData VALUE ('VANI-COKE','Vanilla Coke',1,01.69,'220925-01');

-- Question 6 Show stuff
SELECT tblOrderData.OrderNumber AS "Order Number", FirstName AS "Customer Name", tblCustomerAddresses.Street1, tblCustomerAddresses.Street2, tblCustomerAddresses.City, tblCustomerAddrsses.State
FROM tblCustomer
LEFT JOIN tblOrderData ON tblOrderData.CustomerID = tblCustomer.CustomerID
LEFT JOIN tblCustomerAddresses ON tblCustomerAddresses.CustomerID = tblCustomer.CustomerID
WHERE DeliveryIndicator = True; 

-- Question 7 
SELECT COUNT(LastName = 'Griffin') AS 'Total Griffins' FROM tblCustomer;

-- Question 8
DELETE FROM tblOrderItemsData WHERE OrderItemID = "220925-01";
-- Question 9
DROP TABLE tblOrderItemsData;