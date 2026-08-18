--Gets top 10 highest paying remote jobs for Data Analysts 


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
    job_location= 'Anywhere' AND  
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC

LIMIT 10

/*# ==============================================================================
# TOP 10 REMOTE DATA ANALYST JOBS (MEDIAN: $145K | RANGE: $135K-$165K EXCL. OUTLIER)
# Key Insight: Remote DA pay clusters heavily around $135k-$165k across Tech/Recruiting.
# ==============================================================================
# • Outlier:   Mantys ($650k) -> Severe statistical anomaly / data entry skew.
# • Top Tier:  Get It Recruit - IT ($165k) | Plexus Resource Solutions ($165k)
# • Mid-High:  Get It Recruit - Healthcare ($151.5k) | Level ($145k) | CyberCoders ($145k)
# • Tech/Corp: Uber ($140.5k) | Overmind ($138.5k)
# • Baseline:  InvestM Tech ($135k) | EPIC Brokers ($135k)*/