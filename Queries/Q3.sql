SELECT * FROM db_sql_tutorial.customers;


INSERT INTO customers
VALUES(default,'Manhattan','Billion R', 'USA',100)

UPDATE customers
	SET first_name = 'Fatima',
	last_name = 'Yusuf',
	country = 'Qatar',
	score = 4000
where customer_id = 13

DELETE FROM customers
WHERE customer_id = 11


To delete everything fast USE TRUNCATE function

