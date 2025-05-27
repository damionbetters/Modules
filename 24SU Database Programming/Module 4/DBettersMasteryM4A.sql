/* 1. Use the ap database to make a copy of the following tables:  vendors table as Vendors_Copy, invoices table as Invoices_Copy.*/
 
 USE ap;
 
 CREATE TABLE vendors_copy AS
 SELECT * FROM vendors;
 
 CREATE TABLE invoices_copy AS
 SELECT * FROM invoices;
 
/* 2. Write a statement that displays all vendors from the state of Texas.  Include the following tables: vendor's name, vendor's city, vendor's state.  Use the IN keyword.  Use Vendors_Copy table.*/

SELECT vendor_name, vendor_city, vendor_state
FROM vendors_copy
WHERE vendor_state IN
(
	SELECT vendor_state
    FROM vendors_copy
    WHERE vendor_state = 'TX'
);

/* 3. Write a statement that will display the name and phone number from the Vendors_Copy table that has an invoice number of Q545443 from the Invoices_Copy table.  Use an equal (=) sign when comparing and NOT the IN operator.*/

SELECT vendor_name, vendor_phone
FROM vendors_copy
WHERE vendor_id = 
(
	SELECT vendor_id
    FROM invoices
    WHERE invoice_number = 'Q545443'
);

/* 4. Write a statement that will display the following from the Vendors_Copy table:  vendor name, vendor address 1, vendor city, vendor state, vendor zip.  Use the Invoices_Copy table to get the invoice total of 10976.06.*/

SELECT vendor_name, vendor_address1, vendor_city, vendor_state, vendor_zip_code
FROM vendors_copy
WHERE vendor_id =
(
	SELECT vendor_id
    FROM invoices
    WHERE invoice_total = 10976.06
);

/* 5. Use the om database to make a copy of the following tables:  customers table as Customers_Copy, orders table as Orders_Copy.*/

USE om;

CREATE TABLE customers_copy AS
SELECT * from customers;

CREATE TABLE orders_copy AS
SELECT * FROM orders;

/* 6. Write a statement that will display the entire record of the customer in the Customers_Copy table that has the order ID of 631 from the Orders_Copy table.  The subquery is compared with the equal sign (=), not the IN operator.*/

SELECT *
FROM customers_copy
WHERE customer_id = 
(
	SELECT customer_id
    FROM orders_copy
    WHERE order_id = 631
);

/* 7. Write a statement that combines customer's first and last names as Customer Name from Customers_Copy.  Find customers that have existing orders in Orders_Copy.*/

SELECT CONCAT(customer_first_name, ' ', customer_last_name) AS 'Customer Name'
FROM customers_copy
WHERE EXISTS
(
	SELECT *
    FROM orders_copy
    WHERE customer_id = customers_copy.customer_id
);

/* 8. Use the ex database to make a copy of the following tables:  employees table as Employees_Copy.*/

USE ex;

CREATE TABLE employees_copy AS
SELECT *
FROM employees;

/* 9. Write a statement that combines employee's first and last names as Employee Name from Employees_Copy.  Find the employee whose manager is null.*/

SELECT CONCAT(first_name, ' ', last_name) AS 'Employee Name'
FROM employees_copy
WHERE manager_id IS NULL;

/* 10. Drop all Copy tables using the correct database and in the correct order.*/

/*order
vendor copy, invoice copy, customer copy, orders copy, employees copy
 */
USE ap;
DROP TABLE vendors_copy, invoices_copy;

USE om;
DROP TABLE customers_copy, orders_copy;

USE ex;
DROP TABLE employees_copy;
