/* 1. Create a new database to store all your tables and name your database Module5_LastName (ex. Module5_Doe). */

CREATE DATABASE IF NOT EXISTS Module5_Betters;

/* 2. Make sure to select your database before creating any tables.  Create the Animation_Companies table with these fields: CompanyID-INT PRIMARY KEY AUTO_INCREMENT, CompanyName-VARCHAR(100) NOT NULL. */

USE Module5_Betters;

CREATE TABLE animation_companies
(
	companyID		int				primary key			auto_increment,
    companyName		varchar(100)	not null
);

/* 3. Create the Cartoon_Character table with these fields:  cartoonID-IN PRIMARY KEY AUTO_INCREMENT, cartoonName-VARCHAR(100) NOT NULL, yearCreated-INT, owningCompany-INT NOT NULL.  Don't forget the table level constraint:  Foreign Key that references CompanyID from your Animation_Companies table. */

CREATE TABLE cartoon_character
(
	cartoonID		INT				PRIMARY KEY			AUTO_INCREMENT,
    cartoonName		VARCHAR(100)	NOT NULL,
    yearCreated		INT,
    owningCompany	INT				NOT NULL,
    CONSTRAINT	owningCompany_fk_companyID
		FOREIGN KEY (owningCompany) REFERENCES animation_companies (companyID)
);

/* 4. Insert data into the Animation_Companies table.  Using only the CompanyName field, write the statement to insert the companies in the order provided.  Wrap string in single quotes. The Animation_Companies table will contain only these three (3) records:  1. Warner Bros., 2 Disney, 3. Nickelodeon. */

INSERT INTO animation_companies
	(companyName)
VALUES
	('Warner Bros.'),
    ('Disney'), 
    ('Nickelodeon')
;

/* 5. Insert data into the Cartoon_Characters table.  Without using a column list, write the statement to insert the cartoon name, the year it was created, and which company it belongs to.  Wrap strings in single quotes, auto incrementing values uses DEFAULT, and the company is referenced by the integer ID.  Data as follows: Porky Pig 1935 Warner Bros., Daffy Duck 1937 Warner Bros., Elmer Fudd 1937 Warner Bros., Bugs Bunny 1940 Warner Bros., Foghorn Leghorn 1946 Warner Bros., Mickey Mouse 1928 Disney, Goofy 1934 Disney, Donald Duck 1931 Disney, Elsa of Arendelle 2013 Disney, Anna of Arendelle 2013 Disney, Doug Funnie 1991 Nickelodeon, Arnold Shortman 1985 Nickelodeon, Tommy Pickles 1991 Nickelodeon, Aang 2005 Nickelodeon. */

INSERT INTO cartoon_character VALUES
	(DEFAULT, 'Porky Pig', '1935', 1),
    (DEFAULT, 'Daffy Duck', '1937', 1),
    (DEFAULT, 'Elmer Fudd', '1937', 1),
    (DEFAULT, 'Bugs Bunny', '1940', 1),
    (DEFAULT, 'Foghorn Leghorn', '1946', 1),
    (DEFAULT, 'Mickey Mouse', '1928', 2),
    (DEFAULT, 'Goofy', '1934', 2),
    (DEFAULT, 'Donald Duck', '1931', 2),
    (DEFAULT, 'Elsa of Arendelle', '2013', 2),
    (DEFAULT, 'Anna of Arendelle', '2013', 2),
    (DEFAULT, 'Doug Funnie', '1991', 3),
    (DEFAULT, 'Arnold Shortsman', '1985', 3),
    (DEFAULT, 'Tommy Pickles', '1991', 3),
    (DEFAULT, 'Aang', '2005', 3)
;

/* 6. Write a SELECT statement that joins the two previously created tables together displaying these columns: cartoonName, companyname, yearCreated.  Use aliases for the tables and must be displayed in the order provided. */

SELECT cartoonName, companyName, yearCreated
FROM animation_companies ac JOIN cartoon_character cc
	ON ac.companyID = cc.owningCompany;

/* 7. Create a new table by using a SELECT statement with an existing table.  Name the new table cartoonAge and includes these columns: cartoonName (exist in the cartoon_characters table), yearCreated (exist in the cartoon_characters table), cartoon_age (alias name for a non-existent column)-the cartoon can be found by using functions.  Try the YEAR() function with a date function as a parameter and subtract the year created by the character.  Do not wrap your formula in parentheses.  The data must be sorted in descending order. */

CREATE TABLE cartoonAge
SELECT cartoonName, yearCreated, 
	EXTRACT(YEAR FROM CURRENT_DATE) - yearCreated AS "Cartoon Age"
FROM cartoon_character;

/* 8. Write a statement that will get the count of all cartoon characters from Disney. */

SELECT COUNT(*) AS "Disney Characters" FROM cartoon_character
WHERE owningCompany IN
	(SELECT companyID
    FROM animation_companies
    WHERE companyName = 'Disney')
;

/* 9. Remove all the tables in your database in the correct order. */

DROP TABLE animation_companies, cartoon_character, cartoonage;

/* 10. Remove the Module5_LastName database you created earlier. */

DROP DATABASE IF EXISTS module5_betters;
