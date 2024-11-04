CREATE TABLE tblMake
(
	MakeID VARCHAR(32),
	MakeDescription VARCHAR(50),
    MakeStatus BOOL
	-- PRIMARY KEY(MakelID)
);
DROP TABLE tblModel;
ALTER TABLE tblMake ADD PRIMARY KEY(MakeID);
DESCRIBE TABLE tblMake;

CREATE TABLE tblModel
(
	ModelID VARCHAR(32),
    ModelDesc VARCHAR(50),
    ModelStatus BOOLEAN, 
    PRIMARY KEY(ModelID)
);
INSERT INTO tblVehicle VALUES('ABCD123','I334587','TOYCAM',373124,FALSE,2014);
INSERT INTO tblMake VALUES('I334587','Toyota',TRUE);
INSERT INTO tblModel VALUES('TOYCAM','Camry',TRUE);
CREATE TABLE tblVehicle
(
	VIN VARCHAR(17),
    MakeID VARCHAR(32),
    ModelID VARCHAR(32),
    Mileage INT,
    NEW BOOLEAN,
    VehicleYear INT,
    PRIMARY KEY(VIN),
    FOREIGN KEY (MakeID) REFERENCES tblMake(MakeID),
    FOREIGN KEY (ModelID) REFERENCES tblModel(ModelID)
);
SELECT * FROM tblVehicle;
SELECT * FROM tblVehicle LEFT JOIN tblMake ON tblVehicle.MakeID = tblMake.MakeID;
SELECT * FROM tblVehicle LEFT JOIN tblModel ON tblVehicle.ModelID = tblModel.ModelID;

SELECT VIN, tblMake.MakeDescription AS MakeID, tblModel.ModelDesc AS ModelID, Mileage, VehicleYear
FROM tblVehicle
LEFT JOIN tblMake ON tblVehicle.MakeID = tblMake.MakeID
LEFT JOIN tblModel ON tblVehicle.ModelID = tblModel.ModelID
WHERE tblMake.MakeDescription = 'Toyota';

INSERT INTO tblVehicle VALUES('ABCD124','I334588','FORFOC',0,TRUE,2017);
INSERT INTO tblMake VALUES('I334588','Ford',TRUE);
INSERT INTO tblModel VALUES('FORFOC','Focus',TRUE);

INSERT INTO tblVehicle VALUES('ABCD125','I334589','LEXES330',1200,TRUE,2011);
INSERT INTO tblMake VALUES('I334589','Lexus',TRUE);
INSERT INTO tblModel VALUES('LEXES330','ES 330',TRUE);

UPDATE tblVehicle SET NEW = FALSE WHERE VIN = 'ABCD125';

DELETE FROM tblVehicle WHERE tblVehicle.MakeID = 'I334587';
DELETE FROM tblMake WHERE tblMake.MakeID = 'I334587';