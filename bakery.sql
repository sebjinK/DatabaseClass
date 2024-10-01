SELECT * FROM tblCharacters WHERE LastName = 'Turtle' ORDER BY LastName;
SELECT * FROM tblCharacters WHERE LastName LIKE 'Tur%' ORDER BY LastName;

SELECT * FROM tblCharacters WHERE FirstName LIKE '%l%';

SELECT COUNT(*) AS 'Number of Characters' FROM tblCharacters  WHERE (FirstName LIKE '%l%' OR FirstName LIKE '%e%') AND LastName = 'Turtle';

INSERT INTO tblCharacters VALUES ('SPL01','Splinter','Turdle','TMNT1');
UPDATE tblCharacters SET LastName = 'Turdle'
WHERE CharacterID = 'SPL01';

CREATE TABLE tblOrderItems(
    Quantity INT,
    Description VARCHAR(50),
    Price DECIMAL(5,2)
);
INSERT INTO tblOrderItems VALUES (1, 'Chilli Dog',2.19);
INSERT INTO tblOrderItems VALUES (1, 'Chicago Dog',2.60);
INSERT INTO tblOrderItems VALUES (14, 'Original Dog',4.99);
INSERT INTO tblOrderItems VALUES (6, 'Hot Link',4.00);
INSERT INTO tblOrderItems VALUES (1, 'Good Chilli Dog',12.50);

UPDATE tblOrderItems SET Description = 'Good Chilli Dog' WHERE Price = 12.50;

SELECT Quantity, Price FROM tblOrderItems WHERE Description = 'Chilli Dog';

SELECT (Quantity * Price) AS "Total Price"  FROM TblOrderItems WHERE Description = 'Chilli Dog';

SELECT *, (Quantity * Price) TotalPrice FROM TblOrderItems;
-- WHERE Description = 'Chilli Dog';
SELECT Description FROM tblOrderItems WHERE Description LIKE '%Original%';

SELECT SUM(Quantity) FROM tblOrderItems WHERE Description LIKE '%Original%';
-- returns 0 since no numeric values
SELECT SUM(Description) FROM tblOrderItems WHERE Description LIKE '%Original%';
UPDATE tblOrderItems SET Description = 'Good Burger Dogs' WHERE Description LIKE '%Original%'; 
UPDATE tblOrderItems SET Price = 5.25 WHERE Description = 'Hot Link'; 
SELECT Description, Price, (Price * 0.90) AS "TTU Price" FROM tblOrderItems;
-- faster than the next query
SELECT Description, Price, (Price * (Price * 0.10)) AS "TTU Price" FROM tblOrderItems;

SELECT * FROM tblOrderItems WHERE (Price * Quantity) > 8.00;
SELECT Description AS Testing FROM tblOrderItems WHERE ;
SELECT DISTINCT(Description) FROM tblOrderItems WHERE Price > 4 ORDER BY Description ASC;

DELETE FROM tblOrderItems WHERE Description LIKE '%Link%';