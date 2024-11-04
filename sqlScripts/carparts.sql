CREATE TABLE tblCars
(
	CarID VARCHAR(32),
    Make VARCHAR(25),
    Model VARCHAR(25),
    Year INT,
    PRIMARY KEY (CarID)
);
CREATE TABLE tblParts
(
	PartID VARCHAR(32),
    Quantity INT,
    Description VARCHAR(100),
    CarID VARCHAR(32),
    PRIMARY KEY (PartID),
    FOREIGN KEY (CarID) REFERENCES tblCars(CarID)
);
INSERT INTO tblCars VALUES('TOY1','Toyota','Prius',2010);
INSERT INTO tblCars VALUES('TOY2','Toyota','Tundra',2011);
INSERT INTO tblCars VALUES('HON1','Honda','Civic',2013);

SELECT * FROM tblCars;

INSERT INTO tblParts VALUES('STA01-TOY1',2,'Starter','TOY1');
INSERT INTO tblParts VALUES('ENG01-TOY1',1,'Engine','TOY1');
INSERT INTO tblParts VALUES('GAS01-TOY1',2,'Gas Tank','TOY1');

INSERT INTO tblParts VALUES('STA01-TOY2',1,'Starter','TOY2');
INSERT INTO tblParts VALUES('HOOD01-TOY2',1,'Hood Cap','TOY2');
INSERT INTO tblParts VALUES('WIN12-TOY2',10,'Windshield Wipers','TOY2');

INSERT INTO tblParts VALUES('KEY01-HON1',2,'Key Hole','HON1');
INSERT INTO tblParts VALUES('STA01-HON1',24,'Starter','HON1');
INSERT INTO tblParts VALUES('WHE01-HON1',30,'Wheels','HON1');

SELECT * FROM tblParts;

SELECT * FROM tblParts WHERE Quantity < 10;

SELECT SUM(Quantity) AS "Quantities", Description FROM tblParts
GROUP BY Description;

SELECT Quantity, Description, tblCars.Make, tblCars.Model, tblCars.Year
FROM tblParts
LEFT JOIN tblCars ON tblCars.CarID = tblParts.CarID;

SELECT COUNT(DISTINCT(Make)) FROM tblCars;

SELECT COUNT(*) AS "Entries" FROM tblParts;

-- Useful for singular descriptions
SELECT SUM(Quantity) AS 'Total Starters' 
FROM tblParts 
WHERE Description = 'Starter';

-- Useful for a lot of different descriptions
SELECT SUM(Quantity) AS 'Total Starters' 
FROM tblParts 
GROUP BY Description HAVING Description = 'Starter';

SELECT SUM(Quantity) AS 'Total Starters' 
FROM tblParts 
WHERE Description = 'Starter' OR Description = 'Hood Cap';

-- Aggregate of every single thing
SELECT Description, SUM(Quantity) AS 'Total Starters' 
FROM tblParts 
GROUP BY Description HAVING Description = 'Starter' OR Description = 'Hood Cap';

UPDATE tblParts SET Quantity = 3 WHERE Description = 'Starter';

SELECT UPPER(Description) FROM tblParts;

-- how to select every item from one table
SELECT tblParts.*
FROM tblParts
LEFT JOIN tblCars ON tblCars.CarID = tblParts.CarID
WHERE tblCars.Make = 'Toyota';

-- sub queries (error: return more than one row)
SELECT * 
FROM tblParts
WHERE CarID = 
(SELECT CarID 
FROM tblCars 
WHERE Make = 'Toyota');

-- correct sub query
SELECT * 
FROM tblParts
WHERE CarID IN 
(SELECT CarID 
FROM tblCars 
WHERE Make = 'Toyota');

-- select the cars that are toyota or honda
SELECT * 
FROM tblCars
WHERE Make IN
('Toyota','Honda');

-- select any car that has a 'y' in its make
SELECT * 
FROM tblCars
WHERE Make LIKE '%y%';