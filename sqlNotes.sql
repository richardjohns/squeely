-- * History *

-- IBM started out SQL as SEQUEL (Structured English QUEry Language) in the 70's to query databases.

SELECT DISTINCT * FROM PUF_ORD_CTL
INNER JOIN INF_SUPPLIER
  ON PUF_ORD_CTL.supp_accnbri = INF_SUPPLIER.accnbri
WHERE pgrp_name = 'SHD18A'
AND PORD_PRDATEI > '2016-12-31';

SELECT * FROM INF_SUPPLIER;

SELECT * FROM AllSuppliers
INNER JOIN SuppliersUsedAfterDec2016
  ON AllSuppliers.accnbri = SuppliersUsedAfterDec2016.supp_accnbri;

SELECT DISTINCT
  t.accnbri,
  c.stat_ind
FROM glf_ldg_acc_trans t
JOIN glf_chart_acct c
  ON t.accnbri = c.accnbri
  AND c.chart_name = 'APSHL'
  AND c.stat_ind <> 'I'
WHERE ldg_name = 'AP'
EXCEPT
SELECT DISTINCT
  t.accnbri,
  c.stat_ind
FROM glf_ldg_acc_trans t
JOIN glf_chart_acct c
  ON t.accnbri = c.accnbri
  AND c.chart_name = 'APSHL'
  AND c.stat_ind <> 'I'
WHERE ldg_name = 'AP'
AND t.pdatei > '31-Dec-2016';

-- Main T1 financial select is – 

SELECT * FROM glf_ldg_acct 
where ldg_name = 'GL1A0018'

SELECT * FROM glf_bat_doc
where doc_datei1 between '2018-05-01 00:00:00' and '2018-06-01 00:00:00'

-- Access DB schema maps from –

-- \\techone\techone\Suites\CES\Prod\software\distribution\system\rts\schema\html

-- Select row

SELECT name AS 'Movies', genre, year
FROM movies;
-- will apply alias of Movies to name – doesn’t overwrite underlying table.

SELECT DISTINCT tools 
FROM inventory;
-- will select tools column but will filter out all duplicate values.

SELECT *
FROM movies
WHERE imdb_rating > 8;
-- will select all columns and filter all rows where rating > 8
WHERE name LIKE 'Se_en';
-- will select all fitting word but with wildcard ‘_’ in the middle.
WHERE name LIKE 'A%';
-- will select all starting with ‘A’. Note LIKE is not case-sensitive.
WHERE name LIKE '%A%'; 
-- will select all containing ‘A’
WHERE imdb_rating IS NOT NULL;
-- will select where a movie has an imdb rating. 
WHERE name BETWEEN 'A' AND 'J';

WHERE year BETWEEN 1990 AND 1999
   AND genre = 'romance'
   OR genre = 'action';

SELECT COUNT(*) 
SELECT MAX(price) -- or SELECT MIN
SELECT AVG(downloads)
SELECT SUM(downloads) -- where downloads is a column
SELECT name, ROUND(price, 0)
SELECT ROUND(AVG(price), 2)
FROM fake_apps;

SELECT price, COUNT(*) 
FROM fake_apps
WHERE downloads > 20000
GROUP BY price;

SELECT category, SUM(downloads) 
FROM fake_apps
GROUP BY category;

SELECT category, 
   price,
   AVG(downloads)
FROM fake_apps
GROUP BY 1, 2; -- where 1 & 2 are shorthand for column 1 (category) and column 2 (price)

SELECT year,
   genre,
   COUNT(name)
FROM movies
GROUP BY 1, 2
HAVING COUNT(name) > 10;
•	When we want to limit the results of a query based on values of the individual rows, use WHERE.
•	When we want to limit the results of a query based on an aggregate property, use HAVING.
SELECT price, 
   ROUND(AVG(downloads)),
   COUNT(*)
FROM fake_apps
GROUP BY price
HAVING COUNT(*) > 10;

-- Sort

SELECT name, year, imdb_rating
FROM movies
ORDER BY imdb_rating DESC;
-- leave off to just get ASC
LIMIT 3; 
-- gets top 3

-- Case

SELECT name,
    CASE
    WHEN genre = 'romance' THEN 'Chill'
    WHEN genre = 'comedy' THEN 'Chill'
    ELSE 'Intense'
  END AS 'Mood'
FROM movies;
-- note how the case is essentially a new column called by SELECT

-- Update row

UPDATE celebs 
SET age = 22 
WHERE id = 1; 

SELECT * FROM celebs;

-- Add column:

ALTER TABLE celebs ADD COLUMN twitter_handle TEXT; 
SELECT * FROM celebs;
Delete select rows:
DELETE FROM celebs WHERE twitter_handle IS NULL; 
SELECT * FROM celebs;

-- Create table

CREATE TABLE celebs (
   id INTEGER PRIMARY KEY, 
   name TEXT UNIQUE,
   date_of_birth TEXT NOT NULL,
   date_of_death TEXT DEFAULT 'Not Applicable',
);

CREATE TABLE awards (
  id INTEGER PRIMARY KEY,
  recipient TEXT NOT NULL,
  award_name TEXT DEFAULT "Grammy"
);

select * FROM orders
JOIN subscriptions
	ON orders.subscription_id = subscriptions.subscription_id
WHERE description = 'Fashion Magazine';

SELECT COUNT(*) FROM newspaper
JOIN online
	ON newspaper.id = online.id;

select * FROM newspaper
LEFT JOIN online
ON newspaper.id = online.id
WHERE online.id IS NULL;