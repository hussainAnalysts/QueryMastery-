CREATE TABLE db_sql_tutorial.husaini(
id INT PRIMARY KEY AUTO_INCREMENT,
person VARCHAR(10) NOT NULL,
birth_day DATE,
phone_no VARCHAR(15) NOT NULL UNIQUE )

SELECT*
FROM husaini

CREATE TABLE db_sql_tutorial.ismail(
id INT PRIMARY KEY AUTO_INCREMENT,
human_name VARCHAR(10) NOT NULL,
human_last VARCHAR(30),
date_of_birth DATE,
phone VARCHAR(14) NOT NULL UNIQUE)

DESCRIBE husaini



CREATE TABLE db_sql_tutorial.Ahmad(
id INT PRIMARY KEY AUTO_INCREMENT,
human_name VARCHAR(10) NOT NULL,
human_last VARCHAR(30),
date_of_birth DATE,
phone VARCHAR(14) NOT NULL UNIQUE)

DROP ahmad





ALTER TABLE husaini
ADD address VARCHAR(80) NOT NULL UNIQUE

