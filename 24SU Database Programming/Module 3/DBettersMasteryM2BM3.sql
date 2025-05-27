/* 1.Use the om database until instructed differently. Create a complete copy of the customers table named Customers_Copy.  Create a complete copy of the items table named Items_Copy. */

USE om;

CREATE TABLE Customers_Copy AS
SELECT * FROM customers;

CREATE TABLE Items_Copy AS
SELECT * FROM items;

/* 2.Enter the statement to add a customer record to the Customers_Copy table with a customer id of 30.  The customer is Johnny Jones, 1001 Racer, Adams, TX 76513.  His phone number is 123-123-1234.  He doesn't have a fax number, set it to NULL.  Write the statement without a column list. */

INSERT INTO Customers_Copy
VALUES ('30', 'Johnny', 'Jones', '1001 Racer','Adams', 'TX', '76513', '1231231234', NULL);

/* 3.Enter the statements to add 5 items to the Items_Copy table.  The item_id ranges from 11-15.  Make up the rest of the data but make it appropriate to the Items_Copy table.  Use a column list. */

INSERT INTO Items_copy
	(item_id, title, artist, unit_price)
VALUES
	(11, 'Session 7', 'The Birdflaps', 15.99),
    (12, '02/14/03', 'Ruben Mustard', 14.99),
    (13, 'Tell Me Your Policy', 'ADN', 29.99),
    (14, 'Glue and Metal Shavings', 'King', 10.99),
    (15, 'Empathy for an Angel', 'The Immovable Clouds', 19.68);

/* 4.Enter the statement to modify Johnny Jones' address to 202 S. Racer.  Use the Customers_Copy table.  Make sure you specify the record to update the primary key field rather than name because you could have two or more customers with the same name. */

UPDATE Customers_Copy
SET customer_address = '202 S. Racer'
WHERE customer_id = 30;

/* 5.Enter the statement to delete Johnny Jones' record.  Use the Customers_Copy table.  Make sure you specify the record to delete using the primary key field rather than first and last name because you could have two or more customers with the same name. */

DELETE FROM Customers_copy
WHERE customer_id = 30;

/* 6.USE ap database.  Create company_contact table from vendors with the following fields:  vendor id as id, vendor name as company,  vendor contact first name as first_name, vendor contact last name as last_name, vendor phone as phone.  Then run a select statement to see all data in the company_contact table. */

USE ap;

CREATE TABLE company_contact AS
SELECT 
	vendor_id AS id, vendor_name AS company, 
	vendor_contact_first_name AS first_name, vendor_contact_last_name AS last_name, vendor_phone AS phone
FROM vendors;

SELECT * FROM company_contact;

/* 7.Using a single command, delete all the records in the company_contact table that has a company name containing the sequence of characters 'data' anywhere in its name.  Do not use REGEXP. */

DELETE FROM company_contact
WHERE company LIKE '%data%';

/* 8.Enter the statement to modify company of Nielson to a phone number of 800-535-9856 in the company_contact table. */

UPDATE company_contact
SET phone = '(800) 535-9856'
WHERE company = 'Nielson';

/* 9.Using the ap database, drop the company_contact table. */

USE ap;

DROP TABLE company_contact;

/* 10.Using the om database, drop both of the following tables:  Customers_Copy, Items_Copy. */

USE om;

DROP TABLE Customers_Copy, Items_Copy;
