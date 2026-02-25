# Aged Care Safety & Risk Monitoring Analytics (End-to-end Data Analytics Portfolio) 
This portfolio project analyses resident safety incidents, health monitoring metrics, and population risk profiles across 6 major Australian cities (Sydney, Melbourne, Perth, Adelaide, Canberra, and Brisbane). It shows a complete data analytics workflow: from synthetic dataset generation in Python based on real-world parameters backed up by research to an interactive Power BI dashboard, with SQL Analysis and Microsoft Excel pivot reporting in between.

![Dashboard Preview](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Dashboard_PowerBI_AllRisks.png)

---

## Why Aged Care?

### Growing Up in the Philippines

I grew up in a working-class family in the Philippines where both my parents were government employees. My dad retired as a registrar at a government university, and my mom as an auditor of government agencies. They taught me that accurate data affects real lives, a lesson that would later shape my career path.

As I got older and watched my parents age, I realised the biggest challenge was not just getting older. It was the system. In the last days of my dad's life, he was hospitalised and the bills were piling up. Healthcare in the Philippines was unaffordable, and there was no proper support for aging with dignity. Quality of life in senior years depended on whether you had money, not on data-driven care.

### Going to Australia and Discovering Aged Care

When I moved to Australia with my mom, a senior citizen, I learned about the country's healthcare and aged care systems through news and my sister's stories such as structured support, health monitoring, and government subsidies. My sister and her family had access to free healthcare as citizens. My mom didn't. That gap pushed me to build solutions.

For academic purposes, I built a **fire-prediction mobile app prototype** that alerts seniors when smoke is detected. As a personal project, I built a **step-count dashboard** tracking my mom's activity patterns. This personal project is my next step, a full analytics system that could directly prevent emergencies and improve independence for seniors. Through these small projects, I realised something powerful: **data could be the foundation of better care**.

### My Commitment

That's when my passion for data and aged care began. I saw how smarter systems and data-driven tools could better support older people and improve their quality of care.

**This project represents my commitment to using data to give seniors the proactive, dignified care my father never had access to.**

**My focus:** Data analytics for aged care safety, specialising in incident prevention and daily health monitoring.

---

## Tools I Used
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sqlite&logoColor=white)
![Microsoft Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

---

## Dataset Summary

| File | Rows | Description |
|------|------|-------------|
| `seniors.csv` | 1,000 | Resident profiles: senior id, name, age, gender, location, admission date, risk category |
| `health_metrics.csv` | 365,000 | Daily health records: senior id, date, step count, heart rate, room temperature, smoke level |
| `incidents.csv` | 608 | Safety incident records: senior id, incident date, incident time, incident type, severity, response time in minutes, resolution status |

---

## 8 SQL Queries at a Glance
| # | Query Name | Business Question | Key Finding |
|---|-----------|-------------------|-------------|
| Q1 | Population & Risk Profiling | Who are we caring for and where is risk concentrated? | Perth has the largest high-risk cohort (75 residents, avg age 89–90) |
| Q2 | Geographic Demand & Resource Planning | Which cities generate the highest operational load? | Perth and Adelaide have highest volumes; Brisbane and Sydney show higher high-severity counts |
| Q3 | Incident Volume & Safety Performance | Is safety improving or deteriorating over time? | Monthly totals range 34–62 which means no sustained trend, safety performance is stable |
| Q4 | Incident Type Patterns | What types of incidents are most common by risk group? | Falls dominate all risk groups; wandering is concentrated in high-risk residents |
| Q5 | Severity & Response Effectiveness | Are high-severity incidents responded to fast enough? | High: 4.8 mins, Medium: 9.1 mins, Low: 18.6 mins; meets SIRS standards |
| Q6 | Resolution Success & Operational Gaps | Where are incidents not being resolved and why? | High-severity resolution rate 77.4%; falls have most unresolved cases |
| Q7 | Health Behaviour & Early Warning Indicators | Can health metrics help predict incidents? | Step counts and heart rates normal across all incident types |
| Q8 | High-Risk Individual Monitoring | Which individuals need enhanced monitoring? | No residents met all extreme-risk thresholds; thresholds adjusted for early-warning cases |

---

## Dashboard Previews
### Excel
![Excel Dashboard](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Excel_Dashboard.png)

### Power BI - Low Risk View
![Power BI Low Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Dashboard_PowerBI_LowRisk.png)

### Power BI - Medium Risk View
![Power BI Medium Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Dashboard_PowerBI_MediumRisk.png)

### Power BI - High Risk View
![Power BI High Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Dashboard_PowerBI_HighRisk.png)

---

## Key Insights
- **Stable safety performance**: monthly incidents range 34–62 with no sustained upward trend
- **Falls are the #1 incident type** across ALL risk groups, accounting for 36% of total incidents (233 cases)
- **Fast emergency response**: high-severity incidents receive an average response of 4.8 minutes, meeting SIRS expectations
- **Strong resolution outcomes**: 77.4% resolution rate for high-severity incidents
- **Perth is the highest-demand city**: largest high-risk cohort (75 residents) and highest incident volume
- **No extreme-risk cases identified**: no residents simultaneously met all high-risk thresholds
