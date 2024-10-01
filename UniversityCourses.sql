CREATE TABLE tblCourseDepartment
(
	Department VARCHAR(6),
    CourseDeptDescription VARCHAR(50),
    PRIMARY KEY(Department)
);
CREATE TABLE tblCourseInstructor
(
	Email VARCHAR(254),
    FirstName VARCHAR(25),
    LastName VARCHAR(35),
    CourseInstructorID VARCHAR(9),
    PRIMARY KEY(Email)
);
CREATE TABLE tblCourse
(
	CRN INT,
    Department VARCHAR(6),
    CourseNumber INT,
    CourseCapacity INT,
    CourseInstructorEmail VARCHAR(254),
    PRIMARY KEY(CRN),
    FOREIGN KEY (Department) REFERENCES tblCourseDepartment(Department),
    FOREIGN KEY (CourseInstructorEmail) REFERENCES tblCourseInstructor(Email)
);

DESCRIBE TABLE tblCourse;
-- Inserting into the tblCourseDepartment
INSERT INTO tblCourseDepartment VALUES('CSC','Computer Science');
-- Inserting into the tblCourseInstructor table
INSERT INTO tblCourseInstructor VALUES('bkubiak@tntech.edu','Beata','Kubiak','T00111111');
INSERT INTO tblCourseInstructor VALUES('bburchfield@tntech.edu','Benjamin','Burchfield','T00111112');
-- Inserting into the tblCourse table
INSERT INTO tblCourse VALUES(80805,'CSC',2400,36,'bkubiak@tntech.edu');
INSERT INTO tblCourse VALUES(80808,'CSC',2510,35,'bburchfield@tntech.edu');
INSERT INTO tblCourse VALUES(80819,'CSC',3300,36,'bburchfield@tntech.edu');

-- Select statement showcasing CRN, Dept name, Instructor First Name, Instructor Last Name, Email, Course Number, and Course Capacity
SELECT CRN, tblCourseDepartment.CourseDeptDescription AS Department, tblCourseInstructor.FirstName, tblCourseInstructor.LastName, tblCourseInstructor.Email AS CourseInstructorEmail, CourseNumber, CourseCapacity
FROM tblCourse
LEFT JOIN tblCourseDepartment ON tblCourse.Department = tblCourseDepartment.Department
LEFT JOIN tblCourseInstructor ON tblCourse.CourseInstructorEmail = tblCourseInstructor.Email;
-- Update classses that have CSC as the label to having DS as the lable; ISSUE - CANNOT UPDATE PARENT ROW
-- UPDATE tblCourseDepartment, tblCourse SET tblCourseDepartment.Department = 'DS', tblCourse.Department = 'DS', tblCourseDepartment.CourseDeptDescription = 'Decision Sciences' WHERE tblCourse.Department = 'CSC' AND tblCourseDepartment.Department = 'CSC';
INSERT INTO tblCourseDepartment VALUES('DS','Decision Sciences');
UPDATE tblCourse SET Department = 'DS' WHERE Department = 'CSC';
-- Select statement showcasing CRN, Dept name, Instructor First Name, Instructor Last Name where department is in Decision Sciences
SELECT CRN, tblCourseDepartment.CourseDeptDescription AS Department, tblCourseInstructor.FirstName, tblCourseInstructor.LastName
FROM tblCourse
LEFT JOIN tblCourseDepartment ON tblCourse.Department = tblCourseDepartment.Department
LEFT JOIN tblCourseInstructor ON tblCourse.CourseInstructorEmail = tblCourseInstructor.Email
WHERE tblCourse.Department = 'DS';
-- Delete Burchfield from any tables
DELETE FROM tblcourse WHERE CourseInstructorEmail = 'bburchfield@tntech.edu';
DELETE FROM tblcourseinstructor WHERE Email = 'bburchfield@tntech.edu';


