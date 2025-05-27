-- Programmer: Damion Betters
-- Course: ITSE-2309-7P1

-- Database

CREATE DATABASE IF NOT EXISTS Betters_Module6;

USE Betters_Module6;

-- Tables

CREATE TABLE IF NOT EXISTS employees
(
	employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    employee_first_name VARCHAR(100) NOT NULL,
    employee_last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    street_address VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS clients
(
	customer_ID int PRIMARY KEY AUTO_INCREMENT,
    customer_first_name VARCHAR(100) NOT NULL,
    customer_last_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS discount
(
	discount_ID INT PRIMARY KEY AUTO_INCREMENT,
    discount DECIMAL(8,2) NOT NULL,
    discount_type VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS menu_items
(
	menu_item INT PRIMARY KEY AUTO_INCREMENT,
    item_price DECIMAL(8,2) NOT NULL,
    item_description VARCHAR(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS ticket_orders
(
	order_ID int PRIMARY KEY AUTO_INCREMENT,
    customer_ID INT NOT NULL,
    discount_ID int NOT NULL,
    grand_total DECIMAL(8,2) NOT NULL,
    order_date DATE NOT NULL,
    waiter INT NOT NULL,
    FOREIGN KEY (customer_ID) REFERENCES clients(customer_ID),
    FOREIGN KEY (discount_ID) REFERENCES discount(discount_ID),
    FOREIGN KEY (waiter) REFERENCES employees(employee_ID)
);

CREATE TABLE IF NOT EXISTS ticket_order_line_items
(
	order_ID int NOT NULL,
    menu_item_sequence_ID int NOT NULL,
    grand_total DECIMAL(8,2) NOT NULL,
    CONSTRAINT pk_line_items PRIMARY KEY (order_ID, menu_item_sequence_ID)
);

-- Data Insertion

INSERT INTO employees VALUES
(DEFAULT, "John", "Doe", "(555) 292-4141", "123 Main Street", "Cashville", "MP", "98237"),
(DEFAULT, "John", "Deaux", "(952) 777-5311", "1981 Time Circle", "Chanhassen", "MN", "55317"),
(DEFAULT, "Jason", "Deaux", "(512) 498-4984", "9513 South 3rd Street", "Waco", "TX", "76712"),
(DEFAULT, "Devin", "Taylor", "(313) 776-7274", "49585 Eleven Mile Rd", "Southfield", "MI", "48033"),
(DEFAULT, "Damazo", "Betra", "(248) 544-9595", "24242 Dante Street", "Oak Park", "MI", "48237")
;

INSERT INTO clients VALUES
(DEFAULT, "Damazo", "Betra"),
(DEFAULT, "Aviana", "Horn"),
(DEFAULT, "Quin", "Ford"),
(DEFAULT, "Reign", "Brock"),
(DEFAULT, "Quentin", "Allen")
;

INSERT INTO discount VALUES
(DEFAULT, 0.00, "None"),
(DEFAULT, 0.05, "Birthday"),
(DEFAULT, 0.10, "Student"),
(DEFAULT, 0.125, "AAA"),
(DEFAULT, 0.15, "Veteran")
;

INSERT INTO menu_items VALUES
(DEFAULT, 175.00, "Chateabriand Dinner for Two"),
(DEFAULT, 75.00, "10 ounce Certified Akaushi Beef tenderloin filet"),
(DEFAULT, 41.00, "Grilled Ora King Salmon"),
(DEFAULT, 32.00, "Southern Fried Chicken"),
(DEFAULT, 73.28, "Chilean Sea Bass A La Prime")
;

INSERT INTO ticket_orders VALUES
(DEFAULT, 2, 3, 213.12, "2024-06-02", 3),
(DEFAULT, 3, 1, 187.56, "2024-06-03", 1),
(DEFAULT, 5, 5, 29.45, "2024-06-04", 4),
(DEFAULT, 1, 1, 212.88, "2024-06-05", 2),
(DEFAULT, 2, 2, 231.38, "2024-06-06", 4)
;

INSERT INTO ticket_order_line_items VALUES
(1, 1, 236.79),
(2, 1, 73.28),
(2, 2, 114.28),
(2, 3, 187.56),
(3, 1, 32.00),
(4, 1, 175.00),
(4, 2, 207.00),
(5, 1, 75.00),
(5, 2, 150.00),
(5, 3, 225.00)
;

-- SQL Select Statements: Database-table SQL select demonstration statements

/* 1. Display the following fields for all employees in Michigan: employee's first and last name, employee's city, and employee's state. */
USE betters_module6;

SELECT CONCAT(employee_first_name, " ", employee_last_name) AS "Employee Name", city AS "City", state AS "State"
FROM employees
WHERE state = 'MI';

/* 2. Display all the ticket orders that were filled between the first day of June and the last day of June 2024 from the ticket order table. */

SELECT order_ID, order_date
FROM ticket_orders
WHERE order_date BETWEEN '2024-06-01' AND '2024-06-30';

/* 3. Write a statement that will display menu_items as Menu Item and item_price as "Item Price" from the menu_items table. */

SELECT menu_item AS "Item Name", INSERT(ROUND(item_price, 2), 1, 0, "$") AS "Item Price" 
FROM menu_items;

/* 4. Write a statement that displays these fields:  Customer's first name, customer's last name, order ID, and order date of orders placed.*/
 
SELECT customer_first_name, customer_last_name, order_id, order_date
FROM clients cc
	JOIN ticket_orders tt
	ON cc.customer_id = tt.customer_id;

/* 5. Display customer ID (from clients table), customer's first name, customer's last name, order_ID, and order_total. */
 
SELECT cc.customer_id, customer_first_name, customer_last_name, tt.order_ID
FROM clients cc
	JOIN ticket_orders tt ON cc.customer_id = tt.customer_id
    JOIN ticket_order_line_items li ON tt.order_id = li.order_id
WHERE tt.order_id >= 2 AND tt.order_id <= 3 
ORDER BY cc.customer_id;

-- Drop statements: Tables
-- USE betters_module6;

-- DROP TABLE IF EXISTS employees, clients, discount, menu_items, ticket_orders, ticket_order_line_items;


-- Drop statements: Database
-- USE betters_module6;

-- DROP DATABASE betters_module6;