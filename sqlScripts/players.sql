-- creating a db of college football teams and players associated
-- db keeps:
-- team played for
-- state team is in
-- players first name
-- player last name
-- position
-- jersey number

CREATE TABLE tblState
(
	StateID VARCHAR(2),
    Description VARCHAR(50),
    PRIMARY KEY (StateID)
);
CREATE TABLE tblPosition
(
	PositionID VARCHAR(32),
    Description VARCHAR(50),
    PRIMARY KEY (PositionID)
);
CREATE TABLE tblSchool
(
	SchoolID VARCHAR(32),
    Description VARCHAR(50),
    StateLocation VARCHAR(32),
    PRIMARY KEY (SchoolID),
    FOREIGN KEY (StateLocation) REFERENCES tblState (StateID)
);
CREATE TABLE tblPlayer
(
	PlayerID VARCHAR(32),
	FirstName VARCHAR(25),
    LastName VARCHAR(35),
    Position VARCHAR(32),
    JerseyNumber INT,
    Team VARCHAR(32),
    PRIMARY KEY (PlayerID),
    FOREIGN KEY (Position) REFERENCES tblPosition (PositionID),
    FOREIGN KEY (Team) REFERENCES tblSchool (SchoolID)
);
DROP TABLE tblPlayer;
DESCRIBE TABLE tblPlayer;

INSERT INTO tblState VALUES('TN', 'Tennessee');
INSERT INTO tblSchool VALUES('TNTECH','Tennessee Technological University','TN');
INSERT INTO tblPosition VALUES('QB','Quarterback');
INSERT INTO tblPlayer VALUES('AAA123','Sebjin','Kennedy','QB',27,'TNTECH');

SELECT FirstName AS 'First Name', LastName AS 'Last Name', tblState.Description AS 'State'
FROM tblPlayer
LEFT JOIN tblSchool ON tblSchool.SchoolID = tblPlayer.Team
LEFT JOIN tblState ON tblSchool.StateLocation = tblState.StateID
WHERE tblPlayer.FirstName = 'Sebjin';