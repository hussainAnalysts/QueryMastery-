--Q1 what are the top paying jobs for my role as  a Data Analyst
SELECT
	j.job_title_short AS job_title,
	c.name AS company_name,
	j.job_country,
	TO_CHAR(j.salary_year_avg, '$999,999,999') AS salary
FROM 
	job_postings_fact AS j
JOIN
	company_dim AS c
ON 
	j.company_id = c.company_id
WHERE
	j.job_title_short = 'Data Analyst' AND j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC

--Q2 what are the skills required for those job

SELECT
	j.job_title_short AS job_title,
	c.name AS company_name,
	s.skills AS skills_required,
	s.type AS skill_type,
FROM 
	job_postings_fact AS j
JOIN
	company_dim AS c
ON 
	j.company_id = c.company_id
JOIN
	skills_job_dim AS sj
ON
	sj.job_id = j.job_id
JOIN
	skills_dim AS s
ON
	s.skill_id = sj.skill_id
	
WHERE
	j.job_title_short = 'Data Analyst' AND j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC

--Q3 
SELECT DISTINCT
	j.job_title_short AS job_title,
	s.skills AS skills_required,
	s.type AS skill_type
FROM 
	job_postings_fact AS j
JOIN
	company_dim AS c
ON 
	j.company_id = c.company_id
JOIN
	skills_job_dim AS sj
ON
	sj.job_id = j.job_id
JOIN
	skills_dim AS s
ON
	s.skill_id = sj.skill_id
	
WHERE
	j.job_title_short = 'Data Analyst' AND s.type = 'analyst_tools'

-- Q4 what are the top skills based on salary
SELECT
	j.job_title_short AS job_title,
	s.skills AS skills_required,
	s.type AS skill_type,
	TO_CHAR(j.salary_year_avg, '$999,999,999') AS salary
FROM 
	job_postings_fact AS j
JOIN
	company_dim AS c
ON 
	j.company_id = c.company_id
JOIN
	skills_job_dim AS sj
ON
	sj.job_id = j.job_id
JOIN
	skills_dim AS s
ON
	s.skill_id = sj.skill_id
	
WHERE
	j.job_title_short = 'Data Analyst' AND j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 20

