SELECT *
FROM job_postings_fact
SELECT job_title,
CASE 
	WHEN job_title = 'Data Analyst' THEN 'COOL'
	WHEN job_title = 'Data Scientist'  THEN 'CODING'
	ELSE 'PEACE OUT'
END AS TEST
FROM job_postings_fact
/* Create a query that categorizes jobs in the job_postings_fact table based on the salary_rate.
Classify jobs as 'High', 'Medium', or 'Low' based on different salary thresholds. */
SELECT  DISTINCT salary_year_avg FROM job_postings_fact WHERE salary_year_avg IS NOT NULL ORDER BY salary_year_avg DESC
SELECT * FROM job_postings_fact LIMIT 6

SELECT 
	salary_year_avg,
	CASE 	
	WHEN salary_year_avg  BETWEEN 500000 AND 960000 THEN 'high earner'
	WHEN salary_year_avg  BETWEEN 250000 AND 499000 THEN 'medium earner'
	WHEN salary_year_avg  BETWEEN 5000 AND 249000 THEN 'low earner'
	
END AS Salary_category
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY Salary_category DESC


/* Write a query that adds a new column indicating whether a job in the job_postings_fact table 
is a "Remote" or "On-site" position based on
the job_work_from_home column. */
SELECT * FROM job_postings_fact  
SELECT
	job_work_from_home,
CASE
	WHEN job_work_from_home = false THEN 'On-site'
	WHEN job_work_from_home = true THEN 'Remote'
END AS Options
FROM job_postings_fact

ALTER job_postings_fact
ADD COLUMN Work_from_Home_status TEXT

UPDATE job_postings_fact
SET Work_from_Home_status = 
CASE
	WHEN job_work_from_home = false THEN 'On-site'
	WHEN job_work_from_home = true THEN 'Remote'
END

/* Construct a query that categorizes jobs in the 
job_postings_fact table as 'Full-Time', 'Part-Time', or 'Other' 
based on the job_schedule_type column. */
SELECT DISTINCT job_schedule_type FROM job_postings_fact LIMIT 5

SELECT 
	job_schedule_type,
CASE 
	WHEN job_schedule_type = 'Contractor and Full-time' THEN 'Full-time'
	WHEN job_schedule_type = 'Contractor and Part-time' THEN 'Part-time'
	WHEN job_schedule_type = 'Full-time' THEN 'Full-time'
	ELSE 'Other'
END AS job_category
FROM job_postings_fact

/* Create a query that adds a new column to the job_postings_fact table indicating whether 
the job posting explicitly mentions a degree requirement ('Degree Required' or 'Degree Not Required') 
based on the job_no_degree_mention column. */

-- Creatng the table
ALTER TABLE job_postings_fact
ADD COLUMN deg_classification TEXT
SELECT * FROM job_postings_fact
-- Writing the the logical statement
SELECT 
	job_no_degree_mention,
CASE
	WHEN job_no_degree_mention = 'false' THEN 'Degree Required'
	WHEN job_no_degree_mention = 'true' THEN  'Degree Not Required'
END  
FROM job_postings_fact

-- insering it to the column
UPDATE job_postings_fact
SET deg_classification =
	CASE
	WHEN job_no_degree_mention = 'false' THEN 'Degree Required'
	WHEN job_no_degree_mention = 'true' THEN  'Degree Not Required'
END 

/* Write a query that classifies job postings 
in the job_postings_fact table as 'Offers Health Insurance' or 'No Health Insurance' 
based on the job_health_insurance column.*/
SELECT * FROM job_postings_fact limit 6

SELECT 
	job_health_insurance,
CASE 
	WHEN job_health_insurance = 'true' THEN 'Offers Health Insurance'
	WHEN job_health_insurance = 'false' THEN  'No Health Insurance' 
END AS HEALTH_CAT
FROM job_postings_fact

/* Write a query that counts the number of job postings for each company in the company_dim table and 
categorizes companies as 'High Job Count', 'Medium Job Count', or 'Low Job Count' based on 
the total number of job postings.*/

SELECT * FROM company_dim LIMIT 6
SELECT * FROM job_postings_fact LIMIT 6
SELECT 
	COUNT(j.job_id) AS job_count,
	c.name,
	j.job_title,
	j.job_location,
	j.job_via,
	j.job_schedule_type,
	j.job_work_from_home,
	j.job_country,
	j.salary_year_avg,
	j.job_no_degree_mention
FROM job_postings_fact AS j
INNER JOIN company_dim AS c
ON j.company_id = c.company_id
GROUP BY 
		c.name,
	j.job_title,
	j.job_location,
	j.job_via,
	j.job_schedule_type,
	j.job_work_from_home,
	j.job_country,
	j.salary_year_avg,
	j.job_no_degree_mention
HAVING c.name = 'EY'  
ORDER BY job_count DESC






