SELECT * FROM db_sql_tutorial.employees;


SELECT *
FROM customers
WHERE country in(
SELECT
country
 FROM db_sql_tutorial.employees
 where country ='USA')
 
 -- nested query
 SELECT *
 FROM customers
 where customer_id in (
 SELECT customer_id from orders
 where quantity > 500)
 
 
 
 