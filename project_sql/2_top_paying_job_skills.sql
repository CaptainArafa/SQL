--Gets top skills for the highest salary job postings for Data Analysts


WITH top_paying_jobs AS(

SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id 
WHERE
    job_title = 'Data Analyst' AND
    job_location= 'Anywhere' AND  
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC

LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY 
    salary_year_avg

/*# SKILL FREQUENCY IN HIGH-PAYING DA POSTINGS ($135k-$165k Range):
# ----------------------------------------------------------------------
# Core Languages | python (7/9 roles), sql (6/9 roles), r (5/9 roles)
# BI / Viz Tools | tableau (3/9), looker (3/9), excel (3/9), power bi (2/9)
# Engineering/Cloud | aws (2/9), pandas (2/9), bigquery, gcp, kubernetes, mysql
# Specialist Ops | scikit-learn, golang, java, c++, sas, matlab
# Takeaway       | Python + SQL + 1 BI tool forms the baseline for $135k+ remote roles*/
