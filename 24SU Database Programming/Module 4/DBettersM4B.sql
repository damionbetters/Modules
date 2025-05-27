/* 1. Use the ap database to make a copy of the following tables: invoice_line_items table as Invoice_Line_Items_Copy. */

USE ap;

CREATE TABLE Invoice_Line_Items_Copy AS
SELECT * FROM invoice_line_items;

/* 2. What is the total amount invoiced for each general ledger account number that has a total greater than $2000?  Return these columns:  the account number column from Invoice_Line_Items_Copy table, the sum of the line_item_amount columns from the Invoice_Line_Items_Copy table.  Use the WITH ROLLUP operator to include a row that gives the grand total.  Do not use aliases for your columns. */

SELECT li.account_number, SUM(line_item_amount)
FROM invoice_line_items_copy li JOIN general_ledger_accounts la
	ON li.account_number = la.account_number
GROUP BY li.account_number WITH ROLLUP
HAVING SUM(line_item_amount) > 2000;

/* 3. Write the statement to display the following columns in the Invoice_Line_Items_Copy table:  the line item description, the count of those line items (will not use a specific field), the average price of the line items. */

SELECT line_item_description, COUNT(*), AVG(line_item_amount)
FROM invoice_line_items_copy
GROUP BY line_item_description
ORDER BY line_item_description;

/* 4. Using the query from question 3, add a nested function that changes the output to have a rounded average price of line items.  Round to 2 decimal places. */

SELECT line_item_description, COUNT(*), ROUND(AVG(line_item_amount), 2)
FROM invoice_line_items_copy
GROUP BY line_item_description
ORDER BY line_item_description;

/* 5. Write the statement to display these columns in the Invoice_Line_Items_Copy table:  the line item description, the lowest price of the line items, the highest price of the line items, the average price of the line items rounded to 2 decimal places. */

SELECT line_item_description, MIN(line_item_amount), MAX(line_item_amount), ROUND(AVG(line_item_amount), 2)
FROM invoice_line_items_copy
GROUP BY line_item_description
ORDER BY line_item_description;

/* 6. Write a statement that will display the line item description from the Invoice_Line_Items_Copy table with these restrictions:  only include records that are greater than or equal to $1,000.00, only include groups that have a sum of all their remaining items that are greater than or equal to $3,000.00. */

SELECT line_item_description
FROM invoice_line_items_copy
WHERE line_item_amount >= 1000.00
GROUP BY line_item_description
HAVING SUM(line_item_amount) >=3000.00;

/* 7. Use the om database to make a copy of the following tables:  items table as Items_Copy. */

USE om;

CREATE TABLE Items_Copy AS
SELECT * FROM items;

/* 8. Write the statement to display the number of items and the average cost of all items in the Items_Copy table.  The aggregate function to get the total number of items will not use a specific field in the table.  Use a column alias of "Number of Items" for the number of records returned and "Average Cost" for the unit price. */

SELECT COUNT(*) AS 'Number of Items', AVG(unit_price) AS 'Average Cost'
FROM items_copy;

/* 9. Write the statement to display the total of unit price as Total from the Items_Copy table. */

SELECT SUM(unit_price) AS 'Total'
FROM items_copy;

/* 10. Drop all Copy tables using the correct database and in the correct order. */

USE ap;

DROP TABLE Invoice_Line_Items_Copy;

USE om;

DROP TABLE Items_Copy;