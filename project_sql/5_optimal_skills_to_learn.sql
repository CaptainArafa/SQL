--Optimal Skills for Data analysis based on demand for them especially with high paying salaries

WITH demanded_skills AS(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL

    GROUP BY 
        skills_dim.skill_id
  
),
average_salaries AS(
    SELECT 
        skills_job_dim.skill_id ,
      
    ROUND( AVG(salary_year_avg),0) AS average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id
    
)

SELECT 
    demanded_skills.skill_id,
    demanded_skills.skills,
    demand_count,
    average_salary

 FROM average_salaries 
 INNER JOIN demanded_skills
 ON average_salaries.skill_id = demanded_skills.skill_id
 WHERE
    demand_count > 10
 ORDER BY
    average_salary DESC,
    demand_count DESC
lIMIT 25