CREATE TABLE tblStudent
(
	TNumber VARCHAR(9),
    FirstName VARCHAR(25),
    LastName VARCHAR(35),
    PRIMARY KEY (TNumber)
);
CREATE TABLE tblCourse
(
	CRN VARCHAR(5),
    Department VARCHAR(4),
    CourseNumber INT,
    PRIMARY KEY (CRN)
);

UPDATE tblCourse SET CRN = '80808' WHERE CRN = 80808; VALUES('80808','CSC',3300);
INSERT INTO tblCourse VALUES('13542','DS',4200);
INSERT INTO tblCourse VALUES('12345','ECON',2010);

INSERT INTO tblStudent VALUES('T00034566','Sebjin','Kennedy');
SELECT COUNT(*) AS "Total Records" FROM tblCourse;
DROP TABLE tblCourse;
DROP TABLE tblStudent;
UPDATE tblCourse SET Department = 'DS' WHERE Department = 'CSC';