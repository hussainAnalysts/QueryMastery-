--CHANDOO ASSIGNMNET
1
SELECT 
FROM film as
WHERE rating = 'PG-13' and rental_rate = 2.99

2
SELECT *
FROM film 
WHERE special_features 
LIKE '%Deleted Scenes%'

3
SELECT
	customer_id,
	concat(first_name, ' ' , last_name) as 'customer_name',
	active
FROM customer
WHERE active = 1

4

SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    r.rental_date
FROM customer as c
INNER JOIN rental as r
ON c.customer_id = r.customer_id
WHERE DATE(rental_date) = '2005-07-26'
    
5

SELECT DISTINCT
	c.customer_id,
    c.first_name,
    c.last_name,
    r.rental_date
FROM customer as c
INNER JOIN rental as r
ON c.customer_id = r.customer_id
WHERE DATE(rental_date) = '2005-07-26'

6

SELECT DATE(rental_date) AS 'DATE',
COUNT(*) AS 'COUNTS' 
FROM rental
GROUP BY Date(rental_date)
ORDER BY rental_date
 
 7
--Method 1
SELECT 
	 fc.film_id,
	 ca.category_id,
     ca.name
FROM category as ca
INNER JOIN film_category as fc
ON ca.category_id = fc.category_id
WHERE ca.name = 'Sci-Fi'


--Method 2
SELECT 
	f.film_id,
    f.title,
    f.description,
    f.release_year,
    fc.category_id
FROM film as f
INNER JOIN film_category as fc
ON f.film_id = fc.film_id
WHERE category_id = 14

--Method 3
SELECT 
	f.film_id,
    fc.category_id,
    f.title,
    f.description,
    c.name,
    fc.category_id
FROM film as f
INNER JOIN film_category as fc
ON f.film_id = fc.film_id
INNER JOIN category as c 
ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'


8

SELECT 
	c.customer_id,
    COUNT(r.rental_id)AS rentals,
    c.first_name,
    c.last_name
FROM customer as c
INNER JOIN rental as r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rentals DESC

   9
SELECT * from rental
	film_id,
    title,
    description,
    release_year,
    rental_duration
FROM film
	WHERE rental_duration >= 5
    ORDER BY rental_duration DESC
10

  SELECT 
	  r.customer_id,
	  f.film_id,
      r.rental_id,
      f.title,
      f.description
  FROM rental  as r
  INNER JOIN inventory as i
  ON r.inventory_id = i.inventory_id
  INNER JOIN film as f
  ON f.film_id = i.film_id
  WHERE r.return_date is NULL
  ORDER BY f.title

    
11
SELECT DISTINCT 
	COUNT(last_name) AS count_of_last_name
FROM customer 


