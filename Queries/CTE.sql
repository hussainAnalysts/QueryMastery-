-- EXERCISE 1: Find the top 5 films with the highest rental rates.

WITH most_rented_film AS ( SELECT 
							film_id,
                            title,
                            rental_rate
                            FROM film 
                            ORDER BY rental_rate DESC
							LIMIT 5)
 SELECT 
	film_id,
	title,
	rental_rate
FROM most_rented_film

-- exercise 2: Find customers who have rented more than 20 films.
WITH more_than_rentals_by_customers AS ( SELECT 
											c.first_name,
                                            c.last_name,
                                            COUNT(r.rental_id) AS rental_count
                                            FROM customer AS c
                                            INNER JOIN rental AS r
                                            ON c.customer_id = r.customer_id 
                                            GROUP BY 
                                                   c.first_name,
                                                   c.last_name
											HAVING rental_count > 20
                                            ORDER BY rental_count DESC )
SELECT 
	first_name,
	last_name,
    rental_count
FROM more_than_rentals_by_customers

-- exercise 3: List the top 3 most popular film categories based on the number of rentals
SELECT * FROM rental
	c.name,
    COUNT(r.rental_id) AS rental_count
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id 
INNER JOIN inventory AS i
ON INNER JOIN fc.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY 	
	c.name

	











