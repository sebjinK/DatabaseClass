CREATE TABLE tblEvents
(
	event_id INT AUTO_INCREMENT NOT NULL,
    event_name VARCHAR(100),
    event_date DATE,
    venue VARCHAR(100),
    ticket_price DECIMAL(6, 2),
    PRIMARY KEY (event_id)
);
DROP TABLE tblEvents;
CREATE TABLE tblCustomers
(
	customer_id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    membership_level VARCHAR(20),
    PRIMARY KEY (customer_id)
);
DROP TABLE tblCustomers;
CREATE TABLE tblTickets
(
	ticket_id INT AUTO_INCREMENT NOT NULL,
    customer_id INT,
    event_id INT,
    purchase_date DATE,
    quantity INT,
    total_amount DECIMAL(8,2),
    PRIMARY KEY (ticket_id),
    FOREIGN KEY (customer_id) REFERENCES tblCustomers (customer_id) ON DELETE CASCADE,
	FOREIGN KEY (event_id) REFERENCES tblEvents (event_id) ON DELETE CASCADE
);
DROP TABLE tblTickets;
DROP TABLE tblCustomers;
DROP TABLE tblSeats;
CREATE TABLE tblSeats
(
	seat_id INT AUTO_INCREMENT NOT NULL,
    ticket_id INT,
    seat_number VARCHAR(10),
    seat_row VARCHAR(5),
    section VARCHAR(10),
    PRIMARY KEY (seat_id),
    FOREIGN KEY (ticket_id) REFERENCES tblTickets (ticket_id) ON DELETE CASCADE
);
DROP TABLE tblSeats;
INSERT INTO tblEvents (event_name, event_date, venue, ticket_price) VALUES
('Rock Concert', '2024-11-15', 'Grand Arena', 75.00),
('Tech Conference', '2024-12-01', 'Convention Center', 150.00),
('Comedy Show', '2024-11-22', 'Downtown Theater', 50.00),
('Jazz Night', '2024-12-10', 'Blue Note Club', 40.00),
('Sports Game', '2024-11-25', 'City Stadium', 100.00);


INSERT INTO tblCustomers (first_name, last_name, email, membership_level)
VALUES
('John', 'Doe', 'johndoe@example.com', 'Gold'),
('Jane', 'Smith', 'janesmith@example.com', 'Silver'),
('Alice', 'Johnson', 'alicej@example.com', 'Bronze'),
('Bob', 'Williams', 'bobw@example.com', 'Gold');


INSERT INTO tblTickets (customer_id, event_id, purchase_date, quantity,
total_amount)
VALUES
-- John Doe's ticket purchases
((SELECT customer_id FROM tblCustomers WHERE first_name = 'John' AND
last_name = 'Doe'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert'), '2024-10-01', 2, 150.00),
((SELECT customer_id FROM tblCustomers WHERE first_name = 'John' AND
last_name = 'Doe'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Tech Conference'), '2024-10-05', 1, 150.00),
((SELECT customer_id FROM tblCustomers WHERE first_name = 'John' AND
last_name = 'Doe'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Comedy Show'), '2024-10-10', 3, 150.00),
-- Jane Smith's ticket purchases
((SELECT customer_id FROM tblCustomers WHERE first_name = 'Jane' AND
last_name = 'Smith'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert'), '2024-09-25', 2, 150.00),((SELECT customer_id FROM tblCustomers WHERE first_name = 'Jane' AND
last_name = 'Smith'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Jazz Night'), '2024-09-30',
1, 40.00),
-- Alice Johnson's ticket purchases
((SELECT customer_id FROM tblCustomers WHERE first_name = 'Alice' AND
last_name = 'Johnson'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Sports Game'), '2024-10-08', 2, 200.00),
((SELECT customer_id FROM tblCustomers WHERE first_name = 'Alice' AND
last_name = 'Johnson'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert'), '2024-10-12', 1, 75.00),
-- Bob Williams's ticket purchases
((SELECT customer_id FROM tblCustomers WHERE first_name = 'Bob' AND
last_name = 'Williams'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Comedy Show'), '2024-10-15', 2, 100.00),
((SELECT customer_id FROM tblCustomers WHERE first_name = 'Bob' AND
last_name = 'Williams'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Jazz Night'), '2024-10-20',
2, 80.00),
((SELECT customer_id FROM tblCustomers WHERE first_name = 'Bob' AND
last_name = 'Williams'),
(SELECT event_id FROM tblEvents WHERE event_name = 'Sports Game'), '2024-10-22', 1, 100.00);


INSERT INTO tblSeats (ticket_id, seat_number, seat_row, section)
VALUES
-- tblSeats for John Doe
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'John' AND last_name = 'Doe')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert')), 'A1', 'A', 'Front'),
((SELECT ticket_id FROM tblTickets WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'John' AND last_name = 'Doe')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert')), 'A2', 'A', 'Front'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'John' AND last_name = 'Doe')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Tech Conference')), 'B10', 'B', 'Main'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'John' AND last_name = 'Doe')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Comedy Show')), 'C5', 'C', 'Balcony'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'John' AND last_name = 'Doe')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Comedy Show')), 'C6', 'C', 'Balcony'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'John' AND last_name = 'Doe')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Comedy Show')), 'C7', 'C', 'Balcony'),
-- tblSeats for Jane Smith
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Jane' AND last_name = 'Smith')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert')), 'A3', 'A', 'Front'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Jane' AND last_name = 'Smith')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert')), 'A4', 'A', 'Front'),
((SELECT ticket_id FROM tblTickets WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Jane' AND last_name = 'Smith')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Jazz Night')), 'D1', 'D', 'VIP'),
-- tblSeats for Alice Johnson
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Alice' AND last_name = 'Johnson')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Sports Game')), 'B20', 'B', 'Side'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Alice' AND last_name = 'Johnson')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Sports Game')), 'B21', 'B', 'Side'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Alice' AND last_name = 'Johnson')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Rock Concert')), 'A5', 'A', 'Front'),
-- tblSeats for Bob Williams
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Bob' AND last_name = 'Williams')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Comedy Show')), 'C1', 'C', 'Balcony'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Bob' AND last_name = 'Williams')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Comedy Show')), 'C2', 'C', 'Balcony'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Bob' AND last_name = 'Williams')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Jazz Night')), 'D5', 'D', 'Main'),
((SELECT ticket_id FROM tblTickets WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Bob' AND last_name = 'Williams')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Jazz Night')), 'D6', 'D', 'Main'),
((SELECT ticket_id FROM tblTickets
WHERE customer_id = (SELECT customer_id FROM tblCustomers WHERE
first_name = 'Bob' AND last_name = 'Williams')
AND event_id = (SELECT event_id FROM tblEvents WHERE event_name = 'Sports Game')), 'B15', 'B', 'Side');

-- Question 5
SELECT event_name, event_id, ticket_price, venue
FROM tblEvents
WHERE venue = 'Blue Note Club';
SELECT * FROM tblTickets;
-- Question 6
SELECT CONCAT(tblCustomers.first_name, ' ', tblCustomers.last_name) AS 'Customer Name', tblEvents.event_name AS 'Event Name', quantity AS "Ticket Qty"
FROM tblTickets
LEFT JOIN tblCustomers ON tblCustomers.customer_id = tblTickets.customer_id
LEFT JOIN tblEvents ON tblEvents.event_id = tblTickets.event_id;

-- Question 7
SELECT DISTINCT(COUNT(*)) AS "Number of Unique Customers"
FROM tblCustomers;

-- Question 8
SELECT tblCustomers.customer_id AS CustomerID, CONCAT(tblCustomers.first_name, ' ', tblCustomers.last_name) AS 'Customer Name', SUM(total_amount) AS 'Total Spent'
FROM tblTickets
INNER JOIN tblCustomers ON tblCustomers.customer_id = tblTickets.customer_id
GROUP BY tblCustomers.customer_id
ORDER BY SUM(total_amount) DESC;

-- Question 9
SELECT SUM(total_amount) AS "Total Revenue"
FROM tblTickets;

-- Question 10
SELECT first_name AS 'Customer Name', tblTickets.quantity
FROM tblCustomers
LEFT JOIN tblTickets ON tblCustomers.customer_id = tblTickets.customer_id
WHERE tblCustomers.customer_id IN
(SELECT quantity
FROM tblTickets);

-- Question 11
SELECT event_name AS 'Highest Priced Event', ticket_price AS 'Price'
FROM tblEvents
LIMIT 1;

-- Question 12
SELECT AVG(quantity) AS 'AVG Seats'
FROM tblTickets;


SELECT user, host, plugin FROM mysql.user WHERE user = 'root';
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'user_password';
FLUSH PRIVILEGES;