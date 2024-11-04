CREATE TABLE tblUsers
(
	UserID VARCHAR(32) NOT NULL,
    Email VARCHAR(250) NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Active BOOL,
    PRIMARY KEY (UserID)
);
SELECT * FROM tblUsers;
CREATE TABLE tblSessions
(
	SessionID VARCHAR(50) NOT NULL,
    TimeOfConnection DATETIME NOT NULL,
    Email VARCHAR(250) NOT NULL,
    -- Password VARCHAR(250),
    PRIMARY KEY (SessionID)
);

CREATE TABLE tblClassrooms
(
	ClassroomID INT AUTO_INCREMENT NOT NULL,
    RoomNumber VARCHAR(10) NOT NULL,
    Capacity INT NOT NULL,
    Equipment VARCHAR(300) NULL,
    Active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (ClassroomID)
);
SELECT * FROM tblClassrooms;
CREATE TABLE tblReservations
(
	ReservationID INT AUTO_INCREMENT NOT NULL,
    ClassroomID INT NOT NULL,
    UserID VARCHAR(50) NOT NULL, 
    StartDateTime DATETIME NOT NULL,
    EndDateTime DATETIME NOT NULL,
    PRIMARY KEY (ReservationID),
    FOREIGN KEY (ClassroomID) REFERENCES tblClassrooms (ClassroomID),
    FOREIGN KEY (UserID) REFERENCES tblUsers (UserID)
);

INSERT INTO tblClassrooms (RoomNumber, Capacity, Equipment) VALUES ("CLEM212",50,"Smartboard,Computer Lab");
INSERT INTO tblClassrooms (RoomNumber, Capacity, Equipment) VALUES ("BRUN109",30,"Projector, Whiteboard");
INSERT INTO tblClassrooms (RoomNumber, Capacity, Equipment) VALUES ("PRSC228",40,"Whiteboard");
INSERT INTO tblClassrooms (RoomNumber, Capacity, Equipment, Active) VALUES ("BRUN327",25,"Projector, Conference Phone", FALSE);
INSERT INTO tblClassrooms (RoomNumber, Capacity, Equipment) VALUES ("CLEM415",60,"Smartboard, Projector");

SELECT * FROM tblClassrooms;

SELECT NOW() FROM tblSessions;
INSERT INTO tblSessions VALUES('Somedata', NOW(), 'bburchfield@tntech.edu');
INSERT INTO tblSessions VALUES('Somedata', NOW(), 'bburchfield@tntech.edu')
SELECT FROM tblSessions SELECT COUNT(*) FROM tblUsers WHERE LOWER(Email='sjkennedy43@tntech.edu') AND LOWER(Password='Mickey2024!');



ALTER TABLE tblUsers ADD COLUMN Password VARCHAR(250);
DESCRIBE tblUsers;
ALTER TABLE tblusers MODIFY UserID VARCHAR(50);

SELECT * FROM tblUsers;
DELETE FROM tblUsers WHERE FirstName = "Sebjin";