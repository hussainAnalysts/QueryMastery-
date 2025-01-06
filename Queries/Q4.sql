--  Q1 Count Rentals Per Customer
SELECT 
	customer_id,
    COUNT(rental_id)AS rental_count
FROM rental
GROUP BY customer_id
order by COUNT(rental_id) DESC

-- Q2 Find the Average Rental Duration Per Customer

SELECT 
	customer_id,
	CONCAT(ROUND(AVG(DATEDIFF(return_date, rental_date))), ' ', 'days') AS avg_rental_duration
from rental
GROUP BY customer_id
ORDER BY AVG(DATEDIFF(return_date, rental_date)) DESC;


-- Q3 Number of Films in Each Category
SELECT 
	category_id,
    COUNT(film_id) AS count_of_films
FROM film_category
GROUP BY category_id
ORDER BY COUNT(film_id) DESC
    
-- Q4 Find the Most Frequently Rented Films

SELECT 
    f.title,
    f.description,
	COUNT(r.inventory_id) AS count_of_rentals
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title,
    f.description
ORDER BY COUNT(r.inventory_id)  DESC

-- method  2
SELECT 
    f.title,
    f.description,
    COUNT(r.rental_id) AS count_of_rentals
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title,
    f.description
ORDER BY count_of_rentals DESC

-- Q5 Count Rentals by Store

SELECT 
	i.store_id,
    COUNT(r.inventory_id) AS count_of_rentals
FROM rental AS r
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
GROUP BY i.store_id

-- Q6 List Customers with More Than 30 Rentals

SELECT 
	customer_id,
	COUNT(inventory_id) AS rentals_count
from rental
GROUP BY customer_id
HAVING COUNT(inventory_id) > 30
ORDER BY COUNT(inventory_id) DESC

-- 7Q Find the Longest Average Rental Duration by Film

SELECT
	f.title,
    f.description,
	CONCAT(ROUND(AVG(DATEDIFF(r.return_date, r.rental_date))), ' ', 'days') AS avg_rental_duration
FROM rental AS r
INNER JOIN inventory as i
ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
ON f.film_id = i.film_id
GROUP BY 
	f.title,
	f.description
ORDER BY AVG(DATEDIFF(r.return_date, r.rental_date)) DESC
    
-- Q8 dentify Customers with the Highest Spending

SELECT 
    cf.category_id,
    c.name AS category_name,
    CONCAT('$',FORMAT(SUM(p.amount), 0)) AS total_revenue
FROM film_category AS cf
INNER JOIN film AS f
    ON cf.film_id = f.film_id
INNER JOIN category AS c
    ON cf.category_id = c.category_id
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
INNER JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY
    cf.category_id,
    c.name
    
-- Q10 Find Films with low  rentals 

SELECT
	f.title,
    f.description,
    f.release_year,
    COUNT(r.inventory_id) AS count_of_rentals
FROM film AS f
INNER JOIN inventory as i
ON f.film_id = i.film_id
INNER JOIN rental as r
ON r.inventory_id = i.inventory_id
GROUP BY 
	f.title,
    f.description,
    f.release_year
ORDER BY COUNT(r.inventory_id)



-- Q 11 Identify the top 5 customers who have rented the most films

    SELECT
		r.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.inventory_id) AS count_rentals
	FROM rental AS r
    INNER JOIN customer AS c
    ON r.customer_id = c.customer_id
    GROUP BY 
		r.customer_id,
        c.first_name,
        c.last_name
ORDER BY 
    count_rentals DESC
LIMIT 5