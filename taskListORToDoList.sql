CREATE TABLE tblTask
(
	TaskID VARCHAR (32),
    Description VARCHAR (4000),
    LocationID VARCHAR (32), 
    StatusID VARCHAR (32),
    Category VARCHAR (32),
    Priority INT,
    DueDateTime DATETIME,
    -- add dateCompleted for conveniences sake
    DateCompleted DATE,
    DateLastEdited DATETIME,
	PRIMARY KEY(TaskID)
);
-- DROP TABLE tblTask;
DESCRIBE tblTask;