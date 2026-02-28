# Aged Care Safety & Risk Monitoring Analytics 
> **End-to-end Data Analytics Portfolio** 

This portfolio project analyses resident safety incidents, health monitoring metrics, and population risk profiles across 6 major Australian cities (Sydney, Melbourne, Perth, Adelaide, Canberra, and Brisbane). It shows a complete data analytics workflow: from synthetic dataset generation in Python based on real-world parameters sourced from existing literature and official sources, to an interactive Power BI dashboard, with SQL analysis and Microsoft Excel pivot reporting in between.

![Dashboard Preview](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/All-Risks-View.png)


## Tools I Used
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sqlite&logoColor=white)
![Microsoft Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)


## Dataset Summary

| File | Rows | Description |
|------|------|-------------|
| `seniors.csv` | 1,000 | Resident profiles: senior id, name, age, gender, location, admission date, risk category |
| `health_metrics.csv` | 365,000 | Daily health records: senior id, date, step count, heart rate, room temperature, smoke level |
| `incidents.csv` | 608 | Safety incident records: senior id, incident date, incident time, incident type, severity, response time in minutes, resolution status |

The variables in each file were selected based on existing research, government data, and industry standards in aged care safety, elderly health monitoring, and incident reporting within Australian residential aged care settings.  Below is a breadown of each file and the parameters used to create them.
### 1. SENIORS.CSV
| What I Used | Value in my Script | Why I need this | Research Proof | Exact Quote | Source/Link |
|-------------|--------------------|-----------------|----------------|-------------|--------------|
| **Number of Seniors** | 1,000 residents | Represents a large aged care facility or network of smaller facilities | Standard facility sizes in Australia | "Large facilities can house several hundred residents; network analysis requires substantial population" | https://www.gen-agedcaredata.gov.au/ |
| **Senior ID** | 1 to 1000 | Unique identifier to track each resident across all tables (like a patient ID) | Database best practice | Required for relational database design and data linkage | Standard database design |
| **Age range** | 65 to 95 years | Legal minimum age for aged care in Australia (realistic maximum lifespan) | AIHW 2024 Official Data | "Over half (54%) of admissions to permanent residential aged care were among people aged 85 and over" | https://www.gen-agedcaredata.gov.au/topics/admissions-into-aged-care |
| **Average age** | 83 to 85 years | Matches real admission patterns | AIHW 2025 Report | "For all admissions to permanent residential aged care in 2023–24, the average age at admission was 85 years for women and 83 years for men" | https://www.aihw.gov.au/reports/australias-welfare/aged-care |
| **Gender split** | 48% male, 52% female | Reflects real population as women live longer on average | Population demographics | Elderly population shows slight female majority due to longer life expectancy | https://www.abs.gov.au/ |
| **Location** | 6 major cities (Sydney, Melbourne, Brisbane, Perth, Adelaide, Canberra) | Most aged care facilities are in major cities | Geographic distribution data | Aged care facilities concentrated in capital cities and major regional centers | https://www.gen-agedcaredata.gov.au/ |
| **Risk Category - High** | Age 85+ years | Older seniors need more intensive care and have higher fall risk |  AIHW Admission Data | "21% of people aged 85 and over" are in permanent residential care (much higher than younger groups) | https://pmc.ncbi.nlm.nih.gov/articles/PMC12018721/ |
| **Risk Categoty - Medium** | Age 75-84 years | Moderate care needs | Clinical age stratification | Age-stratified risk assessment (65-79, 80-89, 90+) is standard in aged care research | https://bmcgeriatr.biomedcentral.com/articles/10.1186/s12877-019-1089-3 |
| **Risk Category - Low** | Age 65-74 years | Lower care needs, more independent | Clinical age stratification | Youngest aged care residents typically more independent | Standard clinical practice |

### 2. HEALTH-METRICS.CSV
| What I Used | Value in my Script | Why I need this | Research Proof | Exact Quote | Source/Link |
|-------------|--------------------|-----------------|----------------|-------------|--------------|
| **Number of days** | 365 days | One full year of continuous monitoring to show trends | Annual reporting standard | Quality indicators reported quarterly; annual analysis shows trends | https://www.health.gov.au/our-work/qi-program |
| **Total records** | 365,000 (1000×365) | Realistic volume for IoT health monitoring in large facility | Big data in healthcare | Continuous health monitoring generates daily records per resident | Healthcare IoT standards |
| **Date range** | Past 365 days | Shows seasonal patterns, trends over time | Time-series analysis need | Annual data allows quarterly comparisons and trend analysis | Standard analytical practice |
| **Step count - Range** | 500 to 10,000 steps/day | Realistic activity levels for elderly; 500 = very frail, 10,000 = very active | Elderly Activity Research | "Older adults average 2,000-9,000 steps per day" depending on health status | https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6481017/ |
| **Step count - Formula** | 8000 - (age-65)×80 | Older people walk less (activity declines with age) | Age-Activity Research | "Physical activity levels decline with age, with significant reductions in daily step counts among the oldest old" | https://journals.lww.com/acsm-msse/fulltext/2011/04000/how_many_steps_day_are_enough__for_older_adults.23.aspx |
| **Step count - Validation** | Links to Activities of Daily Living QI | Government tracks resident mobility as quality indicator | AIHW 2023-24 Report | Activities of daily living 20.3%" showed decline in Q4 2023-24 | AIHW Annual Report 2023-24, Table 2, page 8 |
| **Heart rate - Range** | 55 to 110 bpm | Normal range for elderly, with slight buffer for monitoring variations | Medical Standards (Mayo Clinic) | "A normal resting heart rate for adults ranges from 60 to 100 beats per minute" | https://www.mayoclinic.org/healthy-lifestyle/fitness/expert-answers/heart-rate/faq-20057979 |
| **Heart rate - Base** | 70 bpm average | Typical resting heart rate for seniors | Clinical Average | "Average resting heart rate for seniors typically centers around 70 bpm" | https://www.griswoldcare.com/blog/normal-heart-rate-for-elderly-adults/ |
| **Heart rate - Age adjustment** | +0.3 bpm per year of age | Heart rate slightly increases with advanced age | Cardiovascular Aging | "Resting heart rate may increase slightly with age as the heart compensates for reduced cardiac output" | https://www.heart.org/en/health-topics/arrhythmia/about-arrhythmia/bradycardia--slow-heart-rate |
| **Room temperature - Range** | 19 to 25°C (avg 22°C) | Safe, comfortable temperature for elderly residents | WHO Recommendations | "Vulnerable groups including older people need warmer temperatures"; recommended 20-24°C | https://www.who.int/news-room/fact-sheets/detail/ambient-(outdoor)-air-quality-and-health |
| **Room temperature - Base** | 22°C | Standard aged care facility temperature | Aged Care Standards | Typical room temperature maintained in aged care facilities for comfort and safety | https://www.health.gov.au/resources/publications/aged-care-quality-standards |
| **Smoke level - Normal** | 0 (98% of time) | No smoke detected most of the time | Fire Safety Normal | Smoke detectors remain at zero when no fire/smoke present | Fire safety standards |
| **Smoke level - Alert** | 10-40 (2% of time) | Occasional false alarms from cooking, steam, dust | Fire Alarm Statistics | "False alarm rates in residential settings typically 2-10% of monitoring periods" | https://www.usfa.fema.gov/prevention/outreach/smoke_alarms.html |

### 3. INCIDENTS.CSV
| What I Used | Value in my Script | Why I need this | Research Proof | Exact Quote | Source/Link |
|-------------|--------------------|-----------------|----------------|-------------|--------------|
| **Number of incidents** | 608 incidents | | | | |
| **Incident Type: FALLS** | 36% of all incidents | | | | |
| **Falls - Resident rate** | ~32% of all residents fall quarterly| | | | |
| **Falls - Peak hours** | 6-8am and 6-9pm | | | | |
| **Falls - Morning peak** | | | | | |
| **Falls - Evening peak** | | | | | |
| **Incident Type: FIRE ALARM** | | | | | |
| **Incident Type: MEDICAL EMERGENCY** | | | | | |
| **Medical Emergency - ED visits** | | | | | |
| **Incident Type: WANDERING** | | | | | |
| **Incident Type: MEDICATION ERROR** | | | | | |
| **Medication - Polypharmacy** | | | | | |
| **Medication - Antipsychotics** | | | | | |
| **Severity: LOW** | | | | | |
| **Severity: MEDIUM** | | | | | |
| **Severity: HIGH** | | | | | |
| **Falls - LOW severity** | | | | | |
| **Falls - MEDIUM severity** | | | | | |
| **Falls - HIGH severity (major injury)** | | | | | |
| **Response time: HIGH severity** | | | | | |
| **Response time: MEDIUM severity** | | | | | |
| **Response time: LOW severity** | | | | | |
| **Resolved status** | | | | | |

| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |
| **** | | | | | |

## 8 SQL Queries at a Glance
**Query 1: Population & Risk Profiling**
| Business Question | Key Finding |
|-------------------|-------------|
| Who are we caring for and where is risk concentrated? | Perth has the largest high-risk cohort (75 residents, avg age 89 to 90) |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query1.png)

---

**Query 2: Geographic Demand & Resource Planning** 
| Business Question | Key Finding |
|-------------------|-------------|
| Which cities generate the highest operational load? | Perth and Adelaide have highest volumes; Brisbane and Sydney show higher high-severity counts |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query2.png)

---

**Query 3: Incident Volume & Safety Performance** 
| Business Question | Key Finding |
|-------------------|-------------|
| Is safety improving or deteriorating over time? | Monthly totals range 34 to 62 which means no sustained trend, safety performance is stable |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query3.png)

---

**Query 4: Incident Type Patterns** 
| Business Question | Key Finding |
|-------------------|-------------|
| What types of incidents are most common by risk group? | Falls dominate all risk groups; wandering is concentrated in high-risk residents |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query4.png)

---

**Query 5: Severity & Response Effectiveness** 
| Business Question | Key Finding |
|-------------------|-------------|
| Are high-severity incidents responded to fast enough? | High: 4.8 mins, Medium: 9.1 mins, Low: 18.6 mins; meets SIRS standards |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query5.png)

---

**Query 6: Resolution Success & Operational Gaps** 
| Business Question | Key Finding |
|-------------------|-------------|
| Where are incidents not being resolved and why? | High-severity resolution rate 77.4%; falls have most unresolved cases |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query6.png)

---

**Query 7: Health Behaviour & Early Warning Indicators** 
| Business Question | Key Finding |
|-------------------|-------------|
| Can health metrics help predict incidents? | Step counts and heart rates normal across all incident types |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query7.png)

---

**Query 8: High-Risk Individual Monitoring** 
| Business Question | Key Finding |
|-------------------|-------------|
| Which individuals need enhanced monitoring? | No residents met all extreme-risk thresholds; thresholds adjusted for early-warning cases |

![](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/query8.png)

---

## Dashboard Previews
### Excel
![Excel Dashboard](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Excel_Dashboard.png)

### Power BI - Low Risk View
![Power BI Low Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Low-Risk-View.png)

### Power BI - Medium Risk View
![Power BI Medium Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Medium-Risk-View.png)

### Power BI - High Risk View
![Power BI High Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/High-Risk-View.png)


## Key Insights
- **Stable safety performance**: monthly incidents range 34 to 62 with no sustained upward trend
- **Falls are the #1 incident type** across ALL risk groups, accounting for 36% of total incidents (233 cases)
- **Fast emergency response**: high-severity incidents receive an average response of 4.8 minutes, meeting SIRS expectations
- **Strong resolution outcomes**: 77.4% resolution rate for high-severity incidents
- **Perth is the highest-demand city**: largest high-risk cohort (75 residents) and highest incident volume
- **No extreme-risk cases identified**: no residents simultaneously met all high-risk thresholds
