# Aged Care Safety & Risk Monitoring Analytics 

![Dashboard Preview](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/All-Risks-View.png)

## 1. Introduction
This end-to-end data analytics portfolio project analyses resident safety incidents, health monitoring metrics, and population risk profiles across 6 major Australian cities (Sydney, Melbourne, Perth, Adelaide, Canberra, and Brisbane). It shows a complete data analytics workflow: from synthetic dataset generation in Python based on real-world parameters sourced from existing literature and official sources, to an interactive Power BI dashboard, with SQL analysis and Microsoft Excel pivot reporting in between.

---

## 2. Tools Used
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sqlite&logoColor=white)
![Microsoft Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

---

## 3. Dataset Summary

| File | Rows | Description |
|------|------|-------------|
| `seniors.csv` | 1,000 | Resident profiles: senior id, name, age, gender, location, admission date, risk category |
| `health_metrics.csv` | 365,000 | Daily health records: senior id, date, step count, heart rate, room temperature, smoke level |
| `incidents.csv` | 608 | Safety incident records: senior id, incident date, incident time, incident type, severity, response time in minutes, resolution status |

The variables in each dataset were selected based on existing research, government data, and industry standards in aged care safety, elderly health monitoring, and incident reporting within Australian residential aged care settings.  Below is a breadown of each dataset and the parameters I used to create them:

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
| **Risk Category - Medium** | Age 75-84 years | Moderate care needs | Clinical age stratification | Age-stratified risk assessment (65-79, 80-89, 90+) is standard in aged care research | https://bmcgeriatr.biomedcentral.com/articles/10.1186/s12877-019-1089-3 |
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
| **Number of incidents** | 608 incidents | Scaled to 1000 seniors over 365 days (realistic incident rate) | Incident rate calculation | Approximately 5 incidents per 100 resident-months is realistic for aged care | Clinical incident reporting standards |
| **Incident Type: FALLS** | 36% of all incidents | Falls are the most common safety incident in aged care | Australian Health Review 2021 | "Of the 60,268 adverse incidents, falls were the most common event (36%), followed by behaviour-related events (33%)" | https://www.publish.csiro.au/ah/AH21090 |
| **Falls - Resident rate** | ~32% of all residents fall quarterly | Matches government quality indicator data | AIHW 2023-24 Official Report | "Falls 32.6%" of residents experienced falls in Q4 2023-24 | AIHW Residential Aged Care Quality Indicators Annual Report 2023-24, Table 2, page 8 |
| **Falls - Peak hours** | 6-8am and 6-9pm | Most falls happen during morning/evening transitions (getting up, going to bed) | Shaw 2008 Research Study | "A statistically significant higher percentage of falls (27%) occurred between 4 pm and 8 pm" | https://pubmed.ncbi.nlm.nih.gov/18992702/ |
| **Falls - Morning peak** | 6-8am | Falls common when residents wake up and go to bathroom | López-Soto et al. 2017 | "greatest fall rate around dawn in association with morning bathroom activities" | https://pubmed.ncbi.nlm.nih.gov/27801714/ |
| **Falls - Evening peak** | 6-9pm | Falls increase during evening routines | Age and Ageing 2016 | "Fall occurrence was higher during the night (46%) compared to either the morning (30%) or afternoon (24%) shift" | https://academic.oup.com/ageing/article/45/suppl_2/ii16/2195306 |
| **Incident Type: FIRE ALARM** | 15% of incidents | Fire alarms (including false alarms) are monitored incidents | Fire Safety Monitoring | Fire alarms in residential care facilities including false alarms contribute to safety incidents | https://www.nfpa.org/education-and-research/research/nfpa-research/fire-statistical-reports |
| **Incident Type: MEDICAL EMERGENCY** | 26% of incidents | Heart attacks, breathing problems, sudden illness common in elderly | Emergency Response Data | Medical emergencies including cardiac events, breathing difficulties common in aged care | https://www.aihw.gov.au/reports/australias-welfare/australias-welfare-2023-data-insights/contents/measuring-quality-in-aged-care|
| **Medical Emergency - ED visits** | Links to hospitalization QI | Government tracks emergency department presentations | AIHW 2023-24 Report | "Hospitalisations - ED presentations 12.2%" of residents had emergency department visits in Q4 2023-24 | AIHW Annual Report 2023-24, Table 2, page 8 |
| **Incident Type: WANDERING** | 15% of incidents | Dementia residents may wander and get lost - major safety risk | Dementia Care Research | "Just over half of people in permanent residential aged care have dementia" - wandering is significant concern | https://www.aihw.gov.au/reports-data/health-welfare-services/aged-care/overview |
| **Incident Type: MEDICATION ERROR** | 8% of incidents | Wrong dose, wrong time, wrong medication - common incidents | Australian Health Review 2021 | "medication errors (9%)" of adverse incidents in the research study | https://www.publish.csiro.au/ah/AH21090 |
| **Medication - Polypharmacy** | Many residents take 9+ medications | Government tracks as quality indicator | AIHW 2023-24 Report | "Polypharmacy 34.3%" of residents prescribed nine or more medications in Q4 2023-24 | AIHW Annual Report 2023-24, Table 2, page 8 |
| **Medication - Antipsychotics** | Used for dementia/behavioral issues | Government monitors appropriate use | AIHW 2023-24 Report | "Antipsychotic use 17.7%" of residents received antipsychotic medication in Q4 2023-24 | AIHW Annual Report 2023-24, Table 2, page 8|
| **Severity: LOW** | 50% overall incidents | Most incidents are minor - no hospitalization needed | Clinical Classification | Majority of incidents are low severity requiring minimal intervention | Standard clinical practice |
| **Severity: MEDIUM** | 35% overall incidents | Moderate injuries - need treatment but not critical | Clinical Classification | Medium-severity incidents require professional attention but not emergency care | Standard clinical practice |
| **Severity: HIGH** | 15% overall incidents | Serious injuries requiring immediate medical attention | Clinical Classification | High-severity incidents require rapid response and often hospitalization | Standard clinical practice |
| **Falls - LOW severity** | 50% of falls | Half of falls result in no injury or minor bruising | Fall Severity Distribution | Most falls in elderly result in no serious injury | Clinical research |
| **Falls - MEDIUM severity** | 44% of falls | Moderate injuries from falls - cuts, sprains, minor fractures | Fall Severity Distribution | Significant portion of falls cause moderate injuries requiring care | Clinical research |
| **Falls - HIGH severity (major injury)** | 6% of falls | Serious fractures, head injuries requiring hospitalization | AIHW 2023-24 Report | "Falls that resulted in major injury 1.8%" of all residents in Q4 2023-24 (this is ~5.5% of the 32.6% who fell) | AIHW Annual Report 2023-24, Table 2, page 8 |
| **Response time: HIGH severity** | 1-8 minutes | Critical incidents need immediate response | Emergency Response Standards | High-severity incidents require rapid response; 5-10 minute response goal in residential care | Clinical care standards |
| **Response time: MEDIUM severity** | 3-15 minutes | Moderate incidents addressed quickly | Care Facility Protocols | Medium-severity incidents addressed within 15 minutes | Aged care operational standards |
| **Response time: LOW severity** | 5-30 minutes | Low-priority incidents handled in normal workflow | Operational Efficiency | Low-severity incidents managed within routine care workflows | Standard aged care practice |
| **Resolved status** | 75% Yes, 25% No | Most incidents are resolved, some need ongoing care | Clinical Documentation | Some incidents require ongoing monitoring or treatment; not all resolve immediately | Clinical documentation practice |

As a summary, the parameters in the datasets I have created using Python are all research-backed. Nothing is made up randomly. The exact percentages (such as fall, medication, and the like) matches official AIHW 2023-24 government data. The fall timing, activity levels and heart rates use peer-reviewed studies. The WHO temperature guidelines and Mayo Clinic rates follow medical standards. Merged together, the three datasets contain a combined total of 366,608 records across 3 files which shows a realistic data volume. They also follow proper database design principles, including foreign keys, normalisation, and relational structure.

---

## 4. 8 SQL Queries Used
| Query | Business Question | Key Finding |
|-------------|-------------------|-------------|
| **Query 1: Risk Profiling**| Where is risk concentrated? | Risk is most concentrated in Perth, which has the highest number of high-risk residents at 75 residents with an average age of 89 to 90. |
| **Query 2: Geographic Demand & Resource Planning** | Which cities generate the highest operational load? | Perth and Adelaide have highest volumes, and Brisbane and Sydney show higher high-severity counts. |
| **Query 3: Incident Volume & Safety Performance** | Is safety improving or deteriorating over time? | Monthly totals range 34 to 62 which means there is no sustained trend. Safety performance is stable. |
| **Query 4: Incident Type Patterns** | What types of incidents are most common by risk group? | Falls dominate all risk groups, and wandering is concentrated in high-risk residents. |
| **Query 5: Severity & Response Effectiveness** | Are high-severity incidents responded to fast enough? | Yes, high-severity incidents are responded to in 4.8 mins, medium in 9.1 mins, and low in 18.6 mins, all within SIRS standards. |
|**Query 6: Resolution Success & Operational Gaps** | Where are incidents not being resolved and why? | High-severity resolution rate is 77.4% and falls have the most unresolved cases. Some incidents remain unresolved because ongoing care is needed. |
| **Query 7: Health Behaviour & Early Warning Indicators** | Can health metrics help predict incidents? | Step counts (6,596–6,996) and heart rates (73–75 bpm) are consistent across all incident types, suggesting health metrics alone cannot predict incidents. |
| **Query 8: High-Risk Individual Monitoring** | Which individuals need enhanced monitoring? | No residents were identified as extreme risk. | 

## Dashboard Previews
### Excel
![Excel Dashboard](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Excel_Dashboard.png)
This Excel dashboard shows data from February 2025 to January 2026, one full year of monitoring 1,000 elderly residents across 6 Australian cities. It has a total of 5 charts and a key insights & findings section:
- **Monthly Safety trends**:  The number of incidents goes up and down slightly each month but stays within a similar range throughout the year. There are no dramatic spikes or drops. High-severity incidents follow a similar pattern, peaking in the middle of the year then going down toward the end.
- **Resolution Rates by Severity**: Most incidents across all severity levels are being resolved as the resolved portion is much bigger than the unresolved portion in all 3 groups.
- **Response Performance by Severity**: The more serious the incident, the faster the response. High-severity incidents get the quickest attention while low-severity incidents take the longest to respond to.
- **Population by Risk & Location**: Perth stands out as the city with the most high-risk residents compared to all other cities.
- **Incident Types by Category**: Falls are the most common type of incident across all risk groups. High-risk residents have the most incidents overall compared to medium and low-risk residents.
- **Key Insights and Findings**: Summarises the most important findings from the dashboard, written in plain text for quick and easy reading.

### Power BI - Low Risk View
![Power BI Low Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Low-Risk-View.png)
This dashboard filters data to show only **low-risk residents aged 65-74**. Safety performance is generally stable with no clear upward or downward trend in incidents throughout the year. Falls are the most common incident type across all cities, and most incidents are being resolved. However, the serious incident rate is above threshold, suggesting that even low-risk residents still need careful monitoring.

### Power BI - Medium Risk View
![Power BI Medium Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/Medium-Risk-View.png)

### Power BI - High Risk View
![Power BI High Risk](https://github.com/patricialmd/aged-care-safety-analytics/blob/main/06_screenshots/High-Risk-View.png)
This dashboard filters data to show only **high-risk residents aged 85 and above**. Despite being the highest risk group, the serious incident rate is relatively low at 8.48% though still above threshold, and high-severity incidents have the best resolution rate at 84.21%. Falls remain the most common incident type across all cities, with Perth having the highest incident volume. Monthly incidents fluctuate throughout the year with high-severity incidents showing more dramatic ups and downs compared to total incidents.


## Key Insights
- **Stable safety performance**: monthly incidents range 34 to 62 with no sustained upward trend
- **Falls are the #1 incident type** across ALL risk groups, accounting for 36% of total incidents (233 cases)
- **Fast emergency response**: high-severity incidents receive an average response of 4.8 minutes, meeting SIRS expectations
- **Strong resolution outcomes**: 77.4% resolution rate for high-severity incidents
- **Perth is the highest-demand city**: largest high-risk cohort (75 residents) and highest incident volume
- **No extreme-risk cases identified**: no residents simultaneously met all high-risk thresholds
