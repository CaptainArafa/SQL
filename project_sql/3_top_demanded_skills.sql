--Count of demanded skills for Data Analyst job postings 
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5

/*# ==============================================================================
# MOST DEMANDED DATA ANALYST SKILLS (TOP 5 BY JOB POSTING COUNT)
# Key Insight: SQL and Excel lead sheer volume; SQL + Python + 1 Viz tool forms the core trifecta.
# ==============================================================================
# • 1. SQL:      92,628 postings (~30.6% share of top 5) | #1 baseline requirement
# • 2. Excel:    67,031 postings (~22.1% share of top 5) | Universal business tool
# • 3. Python:   57,326 postings (~18.9% share of top 5) | #1 scripting/analytics lang
# • 4. Tableau:  46,554 postings (~15.4% share of top 5) | Lead dedicated BI tool
# • 5. Power BI: 39,468 postings (~13.0% share of top 5) | Close second BI tool*/