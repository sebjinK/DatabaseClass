CREATE TABLE tblEmployeeSalary
(
	employee_id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(25),
    last_name VARCHAR(35),
    occupation VARCHAR(50),
    salary INT,
    PRIMARY KEY (employee_id)
);
CREATE TABLE tblEmployeeDemographics
(
	employee_id INT,
    first_name VARCHAR(25),
    last_name VARCHAR(35),
    age INT,
    gender VARCHAR(50),
    birth_date DATE,
    PRIMARY KEY (employee_id)
);

-- Insert
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON tblEmployeeSalary
    FOR EACH ROW 
	BEGIN
		INSERT INTO tblEmployeeDemographics (employee_id, first_name, last_name)
		VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
	END $$
DELIMITER ;
    
-- Delete
DELIMITER $$
CREATE TRIGGER employee_delete
	BEFORE DELETE ON tblEmployeeSalary
    FOR EACH ROW 
    BEGIN
		DELETE FROM tblEmployeeDemographics 
        WHERE employee_id = OLD.employee_id;
    END $$
DELIMITER ;


