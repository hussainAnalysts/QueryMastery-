SELECT *
FROM
	job_postings_fact
LIMIT 10
--- job postings by year
SELECT
	EXTRACT(YEAR FROM job_posted_date) AS YEAR,
	TO_CHAR(COUNT(*),'999,999,999') AS job_count
FROM 
	job_postings_fact
GROUP BY 
	EXTRACT(YEAR FROM job_posted_date) 
ORDER BY 
	TO_CHAR(COUNT(*),'999,999,999') DESC

-- job postings by month

SELECT
	TO_CHAR(job_posted_date,'MONTH') AS month,
	TO_CHAR(COUNT(*),'999,999,999') AS job_count
FROM 
	job_postings_fact
GROUP BY 
	TO_CHAR(job_posted_date,'MONTH')
ORDER BY 
	TO_CHAR(COUNT(*),'999,999,999') DESC


-- job postings by quarter
SELECT
	TO_CHAR(job_posted_date,'QUARTER') AS month,
	TO_CHAR(COUNT(*),'999,999,999') AS job_count
FROM 
	job_postings_fact
GROUP BY 
	TO_CHAR(job_posted_date,'QUARTER')
ORDER BY 
	TO_CHAR(COUNT(*),'999,999,999') DESC

-- job postings weekly
SELECT
	TO_CHAR(job_posted_date,'WEEK') AS month,
	TO_CHAR(COUNT(*),'999,999,999') AS job_count
FROM 
	job_postings_fact
GROUP BY 
	TO_CHAR(job_posted_date,'WEEK')
ORDER BY 
	TO_CHAR(COUNT(*),'999,999,999') DESC

-- job postings by DAY
SELECT
	TO_CHAR(job_posted_date,'DAY') AS month,
	TO_CHAR(COUNT(*),'999,999,999') AS job_count
FROM 
	job_postings_fact
GROUP BY 
	TO_CHAR(job_posted_date,'DAY')
ORDER BY 
	TO_CHAR(COUNT(*),'999,999,999') DESC
	
-- job postings by HOUR

SELECT
	TO_CHAR(job_posted_date,'hours') AS month,
	TO_CHAR(COUNT(*),'999,999,999') AS job_count
FROM 
	job_postings_fact
GROUP BY 
	TO_CHAR(job_posted_date,'hours')
ORDER BY 
	TO_CHAR(COUNT(*),'999,999,999') DESC

-- total posted by job_title
SELECT 
	TO_CHAR(COUNT(*), '999,999,999') AS total_jobs_posted,
	job_title
FROM 
	job_postings_fact
GROUP BY 
	job_title
ORDER BY 
	TO_CHAR(COUNT(*), '999,999,999') DESC
	
-- Job postings by skill
SELECT
	TO_CHAR(COUNT(*), '999,999,999') AS total_jobs_posting,
	s.skills,
	s.type
FROM 
	job_postings_fact j
INNER JOIN 
	skills_job_dim as sj
ON 
	j.job_id = sj.job_id
INNER JOIN 
	skills_dim as s
ON
	sj.skill_id = s.skill_id	
GROUP BY 
	s.skills,
	s.type
ORDER BY 
	TO_CHAR(COUNT(*), '999,999,999') DESC

-- Job postings by skill in nigeria
SELECT
	TO_CHAR(COUNT(*), '999,999,999') AS total_jobs_posting,
	s.skills,
	s.type
FROM 
	job_postings_fact j
INNER JOIN 
	skills_job_dim as sj
ON 
	j.job_id = sj.job_id
INNER JOIN 
	skills_dim as s
ON
	sj.skill_id = s.skill_id
WHERE 
	job_country = 'Nigeria'
GROUP BY 
	s.skills,
	s.type
ORDER BY 
	TO_CHAR(COUNT(*), '999,999,999') DESC
	
-- Job postings by skill for data analyst
SELECT
	TO_CHAR(COUNT(*), '999,999,999') AS total_jobs_posting,
	s.skills,
	s.type
FROM 
	job_postings_fact j
INNER JOIN 
	skills_job_dim as sj
ON 
	j.job_id = sj.job_id
INNER JOIN 
	skills_dim as s
ON
	sj.skill_id = s.skill_id
WHERE 
	j.job_title = 'Data Analyst'
GROUP BY 
	s.skills,
	s.type
ORDER BY 
	TO_CHAR(COUNT(*), '999,999,999') DESC


	SELECT DISTINCT job_title FROM job_postings_fact

	
-- Job postings by skill for data analyst in Nigeria
SELECT
	TO_CHAR(COUNT(*), '999,999,999') AS total_jobs_posting,
	s.skills,
	s.type
FROM 
	job_postings_fact j
INNER JOIN 
	skills_job_dim as sj
ON 
	j.job_id = sj.job_id
INNER JOIN 
	skills_dim as s
ON
	sj.skill_id = s.skill_id
WHERE 
	j.job_title = 'Data Analyst' AND job_country = 'Nigeria'
GROUP BY 
	s.skills,
	s.type
ORDER BY 
	TO_CHAR(COUNT(*), '999,999,999') DESC

-- total job postings by company 
SELECT 
	TO_CHAR(COUNT(*), '999,999,999') AS total_jobs_posted,
	c.name
FROM 
	job_postings_fact j
INNER JOIN 
	company_dim c
ON 
	j.company_id = c.company_id
GROUP BY 
	c.name
ORDER BY 
	TO_CHAR(COUNT(*), '999,999,999') DESC

-- total job postings by company in Nigeria
SELECT 
	TO_CHAR(COUNT(*), '999,999,999') AS total_jobs_posted,
	c.name
FROM 
	job_postings_fact j
INNER JOIN 
	company_dim c
ON 
	j.company_id = c.company_id
WHERE job_country = 'Nigeria'
GROUP BY 
	c.name
ORDER BY 
	TO_CHAR(COUNT(*), '999,999,999') DESC


-- total posted 
SELECT 
	CONCAT(TO_CHAR(COUNT(*), '999,999,999'), ' ', 'postings' )AS total_jobs_posted
FROM 
	job_postings_fact
