# Data Analyst Job Market & Skill Optimization Analysis (SQL Project)

Welcome to the **Data Analyst Job Market & Skill Optimization Analysis** project! This repository contains a structured, end-to-end SQL analysis designed to uncover the highest-paying Data Analyst positions, the specific technical skills demanded by top-tier employers, and the optimal skill set required to maximize earning potential and marketability in the current job ecosystem.

---

## 📁 Repository Structure

* [`project_sql/1_top_paying_jobs.sql`](./project_sql/1_top_paying_jobs.sql) — Query 1: Top 10 highest-paying remote Data Analyst jobs
* [`project_sql/2_top_paying_job_skills.sql`](./project_sql/2_top_paying_job_skills.sql) — Query 2: Skills required for the highest-paying Data Analyst jobs
* [`project_sql/3_top_demanded_skills.sql`](./project_sql/3_top_demanded_skills.sql) — Query 3: Most in-demand skills by overall job posting volume
* [`project_sql/4_top_paying_skills.sql`](./project_sql/4_top_paying_skills.sql) — Query 4: Skills associated with the highest average compensation
* [`project_sql/5_optimal_skills_to_learn.sql`](./project_sql/5_optimal_skills_to_learn.sql) — Query 5: High-demand, high-salary optimal skills matrix

```text
project_sql/
├── 1_top_paying_jobs.sql
├── 2_top_paying_job_skills.sql
├── 3_top_demanded_skills.sql
├── 4_top_paying_skills.sql
└── 5_optimal_skills_to_learn.sql
```

---

## 🎯 Executive Summary & Key Insights

1. **Remote Salary Benchmarks**: Remote Data Analyst salaries cluster strongly between **$135,000 and $165,000** annually, led by tech giants and specialized recruitment firms (excluding extreme statistical outliers).
2. **The Core Analytics Trifecta**: **SQL, Python, and a primary BI tool (Tableau or Power BI)** form the absolute baseline requirement across both high-volume job postings and premium-paying positions.
3. **The Premium Skill Premium**: High compensation ($130k–$180k+) heavily favors **"Hybrid Analysts"** who bridge traditional analytics with **Data Engineering, DevOps, Cloud Infrastructure (GCP/AWS/Snowflake), and Machine Learning frameworks** (e.g., PyTorch, TensorFlow, Airflow, Kafka).
4. **Optimal Career Focus**: **Snowflake, Spark, and Databricks** represent the ultimate "sweet spot" for data analysts—offering high market demand coupled with salaries exceeding **$110,000+**.

---

## 🔍 Detailed File Breakdowns & Analysis

---

### 1. Top 10 Highest-Paying Remote Data Analyst Jobs
* **File:** [`project_sql/1_top_paying_jobs.sql`](./project_sql/1_top_paying_jobs.sql)
* **Objective:** Identify the top 10 highest-paying remote Data Analyst positions to understand compensation ceilings and high-value hiring companies.

#### SQL Query
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id 
WHERE
    job_title = 'Data Analyst' AND
    job_location = 'Anywhere' AND  
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

#### Key Insights & Findings
> **Note on Outliers:** Mantys ($650k) was excluded from primary analysis due to statistical anomaly / data entry skew.

* **Salary Range**: Remote compensation for top-tier Data Analyst roles spans from **$135,000 to $165,000**.
* **Top Hiring Entities**:
  * **Top Tier ($165,000)**: Get It Recruit - IT, Plexus Resource Solutions.
  * **Mid-High Tier ($145,000 - $151,500)**: Get It Recruit - Healthcare, Level, CyberCoders.
  * **Tech / Corporate ($138,500 - $140,500)**: Uber, Overmind.
  * **Baseline High Tier ($135,000)**: InvestM Tech, EPIC Brokers.

---

### 2. Skills Required for Top-Paying Roles
* **File:** [`project_sql/2_top_paying_job_skills.sql`](./project_sql/2_top_paying_job_skills.sql)
* **Objective:** Uncover the specific tech stack requested in the job descriptions of the top 10 highest-paying Data Analyst roles.

#### SQL Query
```sql
WITH top_paying_jobs AS (
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
        job_location = 'Anywhere' AND  
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
    salary_year_avg;
```

#### Key Insights & Findings
* **Core Languages**: **Python** (featured in 7/9 evaluated roles) and **SQL** (6/9 roles) dominate high-paying positions, followed by **R** (5/9 roles).
* **BI / Viz Tools**: **Tableau** (3/9), **Looker** (3/9), **Excel** (3/9), and **Power BI** (2/9) represent essential dashboarding capabilities.
* **Engineering & Cloud**: AWS, Pandas, BigQuery, GCP, Kubernetes, and MySQL appear frequently for higher-compensated roles requiring raw data pipeline handling.

---

### 3. Top Demanded Skills by Job Volume
* **File:** [`project_sql/3_top_demanded_skills.sql`](./project_sql/3_top_demanded_skills.sql)
* **Objective:** Identify the top 5 skills most frequently requested across *all* Data Analyst job postings to establish baseline market requirements.

#### SQL Query
```sql
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
LIMIT 5;
```

#### Key Insights & Market Distribution
| Rank | Skill | Demand Count | % Share (Top 5 Total) | Primary Category |
| :---: | :--- | :---: | :---: | :--- |
| **1** | **SQL** | 92,628 | ~30.6% | Database Querying / Foundational Baseline |
| **2** | **Excel** | 67,031 | ~22.1% | General Business & Spreadsheet Analytics |
| **3** | **Python** | 57,326 | ~18.9% | Scripting, Automation & Advanced Data Science |
| **4** | **Tableau** | 46,554 | ~15.4% | Enterprise BI Visualization |
| **5** | **Power BI** | 39,468 | ~13.0% | Enterprise BI Visualization |

---

### 4. Highest-Paying Skills for Data Analysts
* **File:** [`project_sql/4_top_paying_skills.sql`](./project_sql/4_top_paying_skills.sql)
* **Objective:** Analyze which skills yield the highest average annual salaries for Data Analysts when specified in job postings.

#### SQL Query
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
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
LIMIT 25;
```

#### Key Insights & High-Salary Segments
* **Web3 / Blockchain**: **Solidity** ($179,000 avg).
* **Big Data & Streaming**: **Couchbase** ($160,000), **Kafka** ($130,000), **Cassandra** ($118,000), **Airflow** ($116,000).
* **Machine Learning & AI**: **DataRobot** ($155,000), **MXNet** ($149,000), **Keras** ($127,000), **PyTorch** ($125,000), **Hugging Face** ($124,000), **TensorFlow** ($121,000).
* **DevOps & Infrastructure**: **VMware** ($147,000), **Terraform** ($147,000), **GitLab** ($134,000), **Ansible** ($124,000).

---

### 5. Optimal Skills Strategy (High Demand + High Salary)
* **File:** [`project_sql/5_optimal_skills_to_learn.sql`](./project_sql/5_optimal_skills_to_learn.sql)
* **Objective:** Determine the most strategic skills to learn by filtering for high job availability (`demand_count > 10`) paired with high average compensation.

#### SQL Query
```sql
WITH demanded_skills AS (
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
average_salaries AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id =