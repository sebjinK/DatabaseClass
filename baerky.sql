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
INSERT INTO tblOrderItems VALUES (1, 'Chilli Dog',12.50);



