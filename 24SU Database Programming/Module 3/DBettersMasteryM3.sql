/* 1. Use om database until instructed differently.  Create a copy of the customers table called Customers_Copy, orders table called Orders_Copy, items table called Items_Copy, and order_details table called Order_Details_Copy. */
 
USE om;
 
CREATE TABLE Customers_Copy AS
SELECT * FROM customers;
 
CREATE TABLE Orders_Copy AS
SELECT * FROM orders;

CREATE TABLE Items_Copy AS
SELECT * FROM items;
 
CREATE TABLE Order_Details_Copy AS
SELECT * FROM order_details;
 
/* 2. Write a statement that displays these fields:  Customer's first name, customer's last name, order ID, and order date of orders placed.  Use the default JOIN type, use table aliases of CC for Customers_Copy and OC for Orders_Copy, and use the ON keyword when joining.  The fields should be displayed in the order listed. Results 47 rows. */
 
SELECT customer_first_name, customer_last_name, order_id, order_date
FROM Customers_Copy CC 
	JOIN orders_copy OC
	ON CC.customer_id = OC.customer_id;
 
/* 3. Write a statement that displays these fields:  customer's first name, customer's last name, order ID, and shipped date for orders not yet shipped.  Use the default JOIN, use table aliases of CC for Customers_Copy and OC for Orders_Copy, and use the ON keyword when joining.  The fields should be displayed in the order listed.  Results 3 rows.*/
 
SELECT customer_first_name, customer_last_name, order_id, shipped_date
FROM Customers_Copy CC 
	JOIN orders_copy OC ON CC.customer_id = OC.customer_id
WHERE shipped_date IS NULL;
 
/* 4. Write a statement that displays these fields:  customer ID (from Customers_Copy table), customer's first name, customer's last name, title, and artist.  These fields are for all customers who have purchased items of artist 'Burt Ruggles' and order by customer ID.  The query will join these 4 tables together:  Customers_Copy, Orders_Copy, Order_Details_Copy, and Items_Copy. The fields should be displayed in the order listed.  Results 11 rows.*/
 
SELECT cc.customer_id, customer_first_name, customer_last_name, title, artist
FROM customers_copy CC
	JOIN orders_copy OC ON cc.customer_id = oc.customer_id
    JOIN order_details_copy OD ON OC.order_id = OD.order_id
    JOIN items_copy IC ON OD.item_id = IC.item_id
WHERE artist = 'Burt Ruggles'
ORDER BY CC.customer_id;
 
/* 5. Write a statement that displays the following fields:  title, customer's first name, customer's last name, item ID (from Order_Details_Copy table),  The statement will determine which items Yash Randall has purchased and order by item ID descending.  Perform the search using the customer name, not the customer number.  The query will join these 4 tables together: Customers_Copy, Orders_Copy, Order_Details_Copy, and Items_Copy.  The fields should be displayed in the order listed. Results 5 rows.*/
 
SELECT title, customer_first_name, customer_last_name, od.item_id
FROM customers_copy cc
	JOIN orders_copy oc ON cc.customer_id = oc.customer_id
    JOIN order_details_copy od ON oc.order_id = od.order_id
    JOIN items_copy ic ON od.item_id = ic.item_id
WHERE CONCAT(customer_first_name, ' ', customer_last_name) = 'Yash Randall'
ORDER BY od.item_id DESC;

/* 6. Write a statement that, using a left outer join, lists the title of all items and if an item(s) has been ordered, also list its order ID.  The query will join these 2 tables:  Items_Copy, Order_Details_Copy.  Result 68 rows.*/
 
SELECT title, order_qty, order_id
FROM items_copy ic LEFT JOIN order_details_copy od
	ON ic.item_id = od.item_id
WHERE order_qty > 0;
 
/* 7. Write a statement that displays the following fields:  customer's first name, customer's last name, order date.  Use a WHERE clause to join the following tables:  Customers_Copy, Orders_Copy.  Order by customer's first name then customer's last name.  The fields should be displayed in the order listed. Result 47 rows.*/
 
SELECT customer_first_name, customer_last_name, order_date
FROM customers_copy cc, orders_copy oc
WHERE cc.customer_id = oc.customer_id
ORDER BY customer_first_name, customer_last_name;
 
/* 8. Write a statement that displays the following fields:  customer's first name, customer's last name, title, unit price of item, order quantity of item for  the records. It should only return records where the quantity ordered is 2 or more and the unit price is greater than or equal to 17.00. Order by customer's last name in descending order.  The fields should be displayed in the order listed.  Result 42 rows.*/

SELECT customer_first_name, customer_last_name, title, unit_price, order_qty
FROM customers_copy cc
	JOIN orders_copy oc ON cc.customer_id = oc.customer_id
    JOIN order_details_copy od ON oc.order_id = od.order_id
    JOIN items_copy ic ON od.item_id = ic.item_id
WHERE order_qty > 1 OR unit_price >= 17.00
ORDER BY customer_last_name DESC;

/* 9. Write a statement that displays ALL the fields for all 4 copy tables.  Order by artist ascending.  Results 68 rows.*/

SELECT *
FROM customers_copy cc
	JOIN orders_copy oc ON cc.customer_id = oc.customer_id
    JOIN order_details_copy od ON oc.order_id = od.order_id
    JOIN items_copy ic ON od.item_id = ic.item_id
ORDER BY artist;

/* 10. Drop all 4 copy tables in correct order.*/

DROP TABLE Customers_Copy, orders_copy, items_copy, order_details_copy;
