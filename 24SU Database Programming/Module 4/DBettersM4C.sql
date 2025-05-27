/* 1. Use the om database to make a copy of the following tables: customers table as Customers_Copy, orders table as Orders_Copy, items table as Items_Copy, order_details as Order_Details_Copy. */

USE om;

CREATE TABLE Customers_Copy AS SELECT * FROM customers;
CREATE TABLE Orders_Copy AS SELECT * FROM orders;
CREATE TABLE Items_Copy AS SELECT * FROM items;
CREATE TABLE Order_Details_Copy AS SELECT * FROM order_details;

/* 2. Write a statement that will display the Customer ID and Last Name of all customers who have shipments shipped out on the first shipment date.  Use a Join and a Subquery. */

SELECT cc.customer_id, customer_last_name
FROM customers_copy cc JOIN orders_copy oc
	ON cc.customer_id = oc.customer_id
WHERE shipped_date = 
	(SELECT MIN(shipped_date)
    FROM orders_copy
    );

/* 3. Write a statement that will display title as Item Name and unit price as Item Price.  Write a nested function (a function inside a function) that displays the Item Price with a dollar sign.
For example: 14.43 as $14.43. */

SELECT title AS "Item Name", INSERT(ROUND(unit_price, 2), 1, 0, "$") AS "Item Price" 
FROM items_copy;

/* 4. Write a statement that will round the total of all orders as Rounded Total Orders.  It will take several joins. */

SELECT ROUND(SUM(order_qty * unit_price), 0) AS "Rounded Total Orders"
FROM customers_copy cc 
 	JOIN orders_copy oc
 		ON cc.customer_id = oc.customer_id
	JOIN order_details_copy od
 		ON oc.order_id = od.order_id
	JOIN items_copy ic
		ON od.item_id = ic.item_id;

/* 5. Write a statement that will display the following: customer last name, city, state.  Find the data where order date is in the 4th quarter of the year. */

SELECT customer_last_name AS "Last Name", customer_city AS "City", customer_state AS "State"
FROM customers_copy cc JOIN orders_copy oc
	ON cc.customer_id = oc.customer_id
WHERE QUARTER(order_date) = 4; 

/* 6. Use the ap database to make a copy of the following tables: invoices as Invoices_Copy, vendors as Vendors_Copy. */

USE ap;

CREATE TABLE Invoices_copy AS SELECT * FROM invoices;
CREATE TABLE Vendors_copy AS SELECT * FROM vendors;

/* 7. Write a statement that formats the invoice_due_date as "Month Day, Year"(ex. July 10th, 2020) as New Date Format. */

SELECT DATE_FORMAT(invoice_due_date, ' %M, %D, %Y') AS "New Date Format"
FROM invoices_copy;

/* 8. Write a statement that displays the following: vendor_name as Vendor Name, vendor_phone as Vendor Phone.  Display No Phone for any missing phone numbers.  Use a single function. */

SELECT vendor_name AS "Vendor Name", COALESCE(vendor_phone, "No Phone") AS "Vendor Phone"
FROM vendors_copy;


/* 9. Write a statement that returns the following columns:  invoice number as Invoice Number, invoice date as Invoice Date, invoice date plus 30 days as Date Plus 30, payment date as Payment Date, number of days between the invoice date and payment date as Days To Pay.  List columns in the correct order as shown and use the date and date difference functions. */

SELECT invoice_number AS "Invoice Number", invoice_date AS "Invoice Date", 
	DATE_ADD(invoice_date, INTERVAL 30 DAY) AS "Date Plus 30", 
	payment_date AS "Payment Date", 
    DATEDIFF(payment_date, invoice_date) AS "Days To Pay"
FROM invoices_copy;

/* 10. Drop all Copy tables using the correct database and in the correct order. */

USE om;

DROP TABLE Customers_Copy, Orders_Copy, Items_Copy, Order_Details_Copy;

USE ap;

DROP TABLE invoices_copy, vendors_copy;
