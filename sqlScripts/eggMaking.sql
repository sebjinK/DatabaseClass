CREATE TABLE tblBreeds (
    BreedID VARCHAR(36),
    Description VARCHAR(100),
    EggColor VARCHAR(20),
    PRIMARY KEY (BreedID)
);
CREATE TABLE tblChickens (
    ChickenID VARCHAR(36),
    HRName VARCHAR(100),
    BirthDate DATE,
    BreedID VARCHAR(36),
    DeceasedDate DATE,
    PRIMARY KEY (ChickenID),
    FOREIGN KEY (BreedID) REFERENCES tblBreeds(BreedID)
);
DROP TABLE tblChickens;
CREATE TABLE tblEggLog (
    LogID VARCHAR(36),
    ChickenID VARCHAR(36),
    Qty INT,
    CollectionDateTime DATETIME,
    PRIMARY KEY (LogID),
    FOREIGN KEY (ChickenID) REFERENCES tblChickens(ChickenID)
);
DROP TABLE tblEggLog;
-- Question 1 
INSERT INTO tblBreeds VALUES('65a7985f-68de-46ba-b2d6-c292427f79d9','Chocolate Maran','Dark Brown');
INSERT INTO tblBreeds VALUES('0392cdaa-1f52-498f-b3e3-1942758a5bc6', 'Rhode Island Red', 'Light Brown');
INSERT INTO tblBreeds VALUES('c2274d0b-f0eb-4b38-95eb-4db1f7aae411', 'Easter Egger', 'Green');

-- Question 2
INSERT INTO tblChickens VALUES('4e3305bf-9ef5-460a-909a-a6f32b28077e', 'Henifer Aniston', '2023-08-02', '65a7985f-68de-46ba-b2d6-c292427f79d9', NULL);

-- Question 3
INSERT INTO tblEggLog (LogID, ChickenID, Qty, CollectionDateTime) VALUES
('1a45d22b-4d3f-4f7e-901a-bf6a9733e5a1', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 1, '2024-09-01 08:15:00'),
('2d9a6789-5c1a-4bb8-82b7-3d2e123a2a97', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 1, '2024-09-02 08:20:00'),
('3e8c4f7a-6b1a-4789-8a9b-21a7f2b7cc1d', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 1, '2024-09-03 08:25:00'),
('44f6c7a9-2e3b-401f-9469-bf23ae2d3a90', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 2, '2024-09-04 08:30:00'),
('59ac5b3d-2e8c-402b-8b97-9477e2e0b133', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 2, '2024-09-05 08:35:00'),
('68bd5f7e-3b2a-4f56-96b9-5e10f2e7f8c1', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 1, '2024-09-06 08:40:00'),
('7ce0f3b9-4d9a-4a0e-961b-3e69d2b7a1b9', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 1, '2024-09-07 08:45:00'),
('841d5f7b-5d3c-409d-8d4a-7a6c3e9d5b4a', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 1, '2024-09-08 08:50:00'),
('9cbd5e9f-6b2d-4e3c-9b7a-7e21f3a2e4a0', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 1, '2024-09-09 08:55:00'),
('a4f76b8c-7c3a-4a2e-97c7-0a42f3a9d7b8', '4e3305bf-9ef5-460a-909a-a6f32b28077e', 0, '2024-09-10 09:00:00');

SELECT SUM(Qty) AS 'Total Eggs'
FROM tblEggLog
GROUP BY ChickenID HAVING ChickenID = '4e3305bf-9ef5-460a-909a-a6f32b28077e';

-- Question 4
SELECT tblChickens.HRName, SUM(Qty) AS 'Total Eggs'
FROM tblEggLog
LEFT JOIN tblChickens ON tblChickens.ChickenID = tblEggLog.ChickenID
WHERE tblChickens.HRName = 'Henifer Aniston';

-- Question 5
SELECT COUNT(*)
FROM tblEggLog
WHERE Qty > 1;

-- Question 6
SELECT Description
FROM tblBreeds
WHERE EggColor LIKE '%Brown%';

-- Question 7
SELECT HRName
FROM tblChickens
LEFT JOIN tblBreeds ON tblBreeds.BreedID = tblChickens.BreedID
WHERE tblBreeds.Description = 'Chocolate Maran';