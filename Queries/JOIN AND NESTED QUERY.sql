-- exercise 1: List the titles of all films in the "Action" category.
SELECT 
	f.title,
    f.description,
    f.release_year,
    c.name AS film_category,
    CONCAT(a.first_name, ' ', a.last_name) AS 'actor_name'
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN film_actor AS ac
ON f.film_id = ac.film_id
INNER JOIN actor AS a
ON a.actor_id = ac.actor_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
HAVING c.name = 'Action'

-- exercise 2: Retrieve the titles of all films in which the actor with the last name "GUINESS" has appeared (uisng Joins).
SELECT 
	f.title,
    f.description,
    f.release_year,
    c.name AS film_category,
     a.last_name
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN film_actor AS ac
ON f.film_id = ac.film_id
INNER JOIN actor AS a
ON a.actor_id = ac.actor_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE a.last_name = 'GUINESS'
HAVING  a.last_name  = "GUINESS" 
ORDER BY f.title

-- exercise 2: Retrieve the titles of all films in which the actor with the last name "GUINESS" has appeared (uisng Nested query)
SELECT * FROM film
SELECT * FROM actor
SELECT * FROM film_actor
SELECT * FROM 
SELECT 
	title
FROM film
WHERE film_id IN ( SELECT 
						film_id
                        FROM film_actor AS fa
                        INNER JOIN actor AS a
                        ON fa.actor_id = a.actor_id
                        WHERE a.last_name = "GUINESS" )

-- exercise 3: List the first and last names of customers who rented the film titled "ACADEMY DINOSAUR" using 'joins'

SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
    f.title
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR'


-- exercise 3: List the first and last names of customers who rented the film titled "ACADEMY DINOSAUR" nested query
SELECT * FROM customer
SELECT * FROM rental
SELECT * FROM film
SELECT * FROM inventory

SELECT 
	first_name,
    last_name
FROM customer
WHERE customer_id IN ( SELECT 
							customer_id 
                            FROM rental
                            WHERE inventory_id IN ( SELECT
														    inventory_id
                                                            from inventory
                                                            WHERE film_id IN ( SELECT
															film_id 
                                                            FROM film
                                                            WHERE title =  "ACADEMY DINOSAUR" )))
                                                            
 -- exercise 4 List the titles of the top 5 longest films in the database (NESTED QUERY).
SELECT
	title,
    length
FROM film 
ORDER BY length DESC
LIMIT 5

-- exercise 5: : Customers Who Rented More Than the Average Number of Films
	SELECT customer.customer_id, first_name, last_name, COUNT(rental.inventory_id) AS count_of_avg_rentals
FROM customer 
JOIN rental ON customer.customer_id = rental.customer_id 
GROUP BY customer.customer_id
HAVING COUNT(*) > (SELECT AVG(rental_count) 
                   FROM (SELECT COUNT(*) AS rental_count 
                         FROM rental 
                         GROUP BY customer_id) AS avg_rental);
                         
SELECT 
	a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    COUNT(fa.film_id) AS film_count 
FROM film_actor AS fa 
INNER JOIN actor AS a
ON fa.actor_id  = a.actor_id
GROUP BY a.actor_id, actor_name
ORDER BY film_count DESC 
LIMIT 1
SELECT actor_id 
FROM film_actor 
GROUP BY actor_id 
HAVING COUNT(film_id) = (SELECT MAX(film_count) 
                         FROM (SELECT actor_id, COUNT(film_id) AS film_count 
                               FROM film_actor 
                               GROUP BY actor_id) AS actor_counts);

SELECT MAX(film_count) 
FROM (SELECT actor_id, COUNT(film_id) AS film_count 
      FROM film_actor 
      GROUP BY actor_id) AS actor_counts;
SELECT film_id, COUNT(inventory_id) AS rental_count
FROM rental 
GROUP BY film_id 
HAVING COUNT(rental_id) > 100;

-- Find films that have been rented by more than 100 customers.
SELECT 
	
    f.title,
    COUNT(r.customer_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental As r
ON i.inventory_id = r.inventory_id
GROUP BY
    f.title
ORDER BY rental_count DESC

SELECT 
	CONCAT(c.first_name, ' ', c.last_name) AS name_of_customer,
    COUNT(r.rental_id) AS rental_count
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY name_of_customer

SELECT 
	f.film_id,
    f.title,
	COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id 
GROUP BY 
	f.film_id,
    f.title
ORDER BY rental_count DESC
    

SELECT 
    f.film_id,
    f.title,
    COUNT(DISTINCT r.customer_id) AS customer_count
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id,
    f.title
ORDER BY customer_count DESC

  
SELECT 
    f.film_id,
    f.title,
    COUNT(DISTINCT r.customer_id) AS customer_count
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id,
    f.title
HAVING 
    COUNT(DISTINCT r.customer_id) > 100;

-- You want to find the title of the film with the longest duration.
SELECT 
	title,
    length
FROM film 
ORDER BY length DESC
LIMIT 5

-- You want to find the title of the film with the longest duration (using nested query).

SELECT 
	title,
    length
FROM film
WHERE length =( SELECT MAX(length) FROM film)

-- Find the actor who appeared in the most films.
SELECT
	CONCAT(a.first_name, ' ',
    a.last_name) AS actor_name,
    COUNT(f.film_id) AS film_count
FROM actor AS a
INNER JOIN film_actor AS ac
ON a.actor_id = ac.actor_id
INNER JOIN film AS f
ON ac.film_id = f.film_id
GROUP BY 
	a.first_name,
    a.last_name
Having film_count =30
ORDER BY film_count DESC



-- Find the actor who appeared in the most films(using nested query).

SELECT 
	SELECT film_id 
FROM rental 
GROUP BY film_id 
HAVING COUNT(rental_id) > 100;










