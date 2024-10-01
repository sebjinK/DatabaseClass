CREATE TABLE tblStudentTickets
(
	StudentEmail VARCHAR(50),
    FirstName VARCHAR(25),
    LastName VARCHAR(35),
    NumberOfTickets INT,
    PRIMARY KEY (StudentEmail)
);

INSERT INTO tblStudentTickets VALUES('sjkennedy43@tntech.edu','Sebjin','Kennedy',1);

SELECT * FROM tblStudentTickets;

UPDATE tblStudentTickets SET NumberOfTickets = 2 WHERE StudentEmail = 'sjkennedy43@tntech.edu';

INSERT INTO tblStudentTickets VALUES('bburchfield@tntech.edu','Benjamin','Burchfield',3);

UPDATE tblStudentTickets SET NumberOfTickets = 0;