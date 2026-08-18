--Average salary for skills for Data Analyst job postings 
SELECT 
    skills,
   ROUND( AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    average_salary DESC
LIMIT 25
/*# ==============================================================================
# DATA ANALYST TOP SALARY SKILLS (AVG: $134K | RANGE: $115K-$179K EXCL. OUTLIERS)
# Key Insight: Highest salaries go to "Hybrid Analysts" bridging ML, DevOps & Big Data.
# ==============================================================================
# • Outlier:   svn ($400k) -> Anomaly due to legacy enterprise niche / low sample size.
# • Web3:      solidity ($179k)
# • Big Data:  couchbase ($160k) | kafka ($130k) | cassandra ($118k) | airflow ($116k)
# • ML/AI:     datarobot ($155k) | mxnet ($149k) | keras ($127k) | pytorch ($125k) | hugging face ($124k) | tensorflow ($121k)
# • DevOps:    vmware ($147k) | terraform ($147k) | gitlab ($134k) | puppet ($130k) | ansible ($124k)
# • Languages: golang ($155k) | dplyr ($148k) | perl ($125k) | scala ($115k)*/