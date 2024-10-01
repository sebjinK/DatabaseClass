CREATE TABLE tblTransactions
(
	TransactionID VARCHAR (32),
    WhoCheckedOut VARCHAR (32),
    WhatCheckedOut VARCHAR (32),
    WhenCheckedOut date,
    WhenIsDue date,
    PRIMARY KEY (TransactionID),
    FOREIGN KEY (WhoCheckedOut) REFERENCES tblPatron(LibraryCardNumber),
    FOREIGN KEY (WhatCheckedOut) REFERENCES tblItems(ItemID)
);
CREATE TABLE tblCategories
(
	CategoryID VARCHAR(32),
    Description VARCHAR(50),
    CheckoutPeriod INT,
    PRIMARY KEY (CheckoutPeriod)
);
CREATE TABLE tblItems
(
	ItemID VARCHAR(32),
    Description VARCHAR(50),
    Category VARCHAR(32),
    MonetaryValues VARCHAR(7),
    PRIMARY KEY(ItemID),
    FOREIGN KEY (Category) REFERENCES tblCategories (CategoryID)
);
CREATE TABLE tblPatron
(
	LibraryCardNumber VARCHAR(32),
    FirstName VARCHAR(25),
    LastName VARCHAR(35),
    PhoneNumber VARCHAR(10),
    PRIMARY KEY (LibraryCardNumber),
);

INSERT INTO tblPatron VALUES('AAA111','Sebjin','Kennedy','6156156767');
INSERT INTO tblPatron VALUES('AAA112','Benjamin','Burchfield','9028569700');
INSERT INTO tblPatron VALUES('AAA113','Sans','Undertale','8888888888');

INSERT INTO tblCategories VALUES('M12','Childrens Book',35);
INSERT INTO tblCategories VALUES('B3','Computer DVD',14);
INSERT INTO tblCategories VALUES('C4','CD',7);

INSERT INTO tblItems VALUES('M12111AAA','The Giving Tree','M12','5.99');
INSERT INTO tblItems VALUES('B3111AAA','How to Train Your Dragon','B3','20.99');
INSERT INTO tblItems VALUES('C4111AAA','Baby Shark','C4','1.99');

INSERT INTO tblTransactions VALUES('1A1A1A','AAA111','C4111AAA','2024-09-23','2024-09-30');
INSERT INTO tblTransactions VALUES('1A1A1B','AAA113','M12111AAA','2024-09-23','2024-10-07');
INSERT INTO tblTransactions VALUES('1A1A1C','AAA112','B3111AAA','2024-09-23','2024-10-28');
