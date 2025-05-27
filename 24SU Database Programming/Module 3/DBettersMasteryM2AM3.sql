/*1.Display all fields in the vendors table. Use the * to represent all fields. Results 122 rows.*/

SELECT * FROM ap.vendors;

/*2.Display the following fields from the vendors table:  vendor's name, vendor's city, and vendor's state.  The fields need to be displayed in the order requested (This applies to all questions). Results 122 rows.*/

SELECT vendor_name, vendor_city, vendor_state
FROM ap.vendors;

/*3.Display the following fields for all vendors in California: vendor's name, vendor's city, and vendor's state.  Results 75 rows.*/

SELECT vendor_name, vendor_city, vendor_state 
FROM ap.vendors
WHERE vendor_state = 'CA';

/*4.Display the vendor name and zip code of all vendors in Fresno, California.  Restrict the rows first by state, then by city.  Results 41 rows.*/

SELECT vendor_name, vendor_zip_code 
FROM ap.vendors
WHERE vendor_state = 'CA' AND vendor_city = 'Fresno';

/*5.Display all the invoice numbers and due dates.  Only indicate records that have a due date between the first day of May and the last day of June 2018 from the invoices table.  Use the BETWEEN and AND keywords.  Results 46 rows.*/

SELECT invoice_number, invoice_due_date
FROM ap.invoices
WHERE invoice_due_date BETWEEN '2018-05-01' AND '2018-06-30';

/*6.Display the vendor's names from the vendors table that are missing their phone numbers.  Results 25 rows.*/

SELECT vendor_name
FROM ap.vendors
WHERE vendor_phone IS NULL;

/*7.Display the vendor's name, vendor's city, vendor's state, and vendor's zip from the vendors table for all who reside in Arizona.  Place in descending order by vendor's name.  Results 3 rows.*/

SELECT vendor_name, vendor_city, vendor_state, vendor_zip_code
FROM ap.vendors
WHERE vendor_state = 'AZ'
ORDER BY vendor_name DESC;

/*8.Combine the vendor's contact first name and last name as Vendor Contact in the following format: Jane Doe. Display the vendor's name, vendor's contact, and the vendor's phone for the state of New Jersey.  Place in ascending order by last name.  Results 4 rows.*/

SELECT vendor_name,
	CONCAT(vendor_contact_first_name, ' ' , vendor_contact_last_name) AS "Vendor Contact",
    vendor_phone
FROM ap.vendors
WHERE vendor_state = 'NJ'
ORDER BY vendor_contact_last_name;

/*9.Display the invoice number, invoice date, and invoice total from the invoices table that have no payment date.  Display in descending order by invoice total.  Result 11 rows.*/

SELECT invoice_number, invoice_date, invoice_total 
FROM ap.invoices
WHERE payment_date IS NULL
ORDER BY invoice_total DESC;

/*10.Display the following fields for the vendors table for account numbers great and equal to 500:  name as Vendor Name, city as City, state as State, Contact first name, and last name as Vendor Contact (ex. Jane Doe).  Display in ascending order by name.  Results 102 rows.*/

SELECT vendor_name AS "Vendor Name", vendor_city AS "City", vendor_state AS "State",
	CONCAT(vendor_contact_first_name, ' ', vendor_contact_last_name) AS "Vendor Contact"
FROM ap.vendors
WHERE default_account_number >= 500
ORDER BY vendor_name;
