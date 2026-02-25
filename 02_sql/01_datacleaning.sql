SELECT name
FROM Sqlite_master
WHERE type = 'table';

SELECT COUNT(*) AS seniors_rows FROM seniors;
SELECT COUNT(*) AS incidents_rows FROM incidents;
SELECT COUNT(*) AS health_metrics_rows FROM health_metrics;

SELECT * FROM seniors LIMIT 5;
SELECT * FROM incidents LIMIT 5;
SELECT * FROM health_metrics LIMIT 5;

PRAGMA table_info(seniors);
PRAGMA table_info(incidents);
PRAGMA table_info(health_metrics);

SELECT
	MIN(age) AS min_age,
	MAX(age) AS max_age
FROM seniors;

SELECT
	MIN(response_time_minutes) AS min_response,
	MAX(response_time_minutes) AS max_response
FROM incidents;

SELECT
	MIN(senior_id) AS min_id,
	MAx(senior_id) AS max_id
FROM seniors;

SELECT
	ROUND(AVG(age), 1) AS avg_age
FROM seniors;

SELECT
	gender,
	COUNT(*) AS count,
	ROUND(COUNT(*) * 100.0/(SELECT COUNT(*) FROM seniors), 1) AS percentage
FROM seniors
GROUP BY gender;

SELECT DISTINCT location
FROM seniors;

SELECT
	risk_category,
	MIN(age) AS min_age,
	MAX(age) AS max_age,
	COUNT(*) AS seniors
FROM seniors
GROUP BY risk_category;

SELECT COUNT(*) AS total_records
FROM health_metrics;

SELECT
	MIN(date) AS earliest_date,
	MAX(date) AS latest_date
FROM health_metrics;

SELECT
	MIN(step_count) AS min_steps,
	MAX(step_count) AS max_steps
FROM health_metrics; 

SELECT
  MIN(heart_rate) AS min_hr,
  MAX(heart_rate) AS max_hr
FROM health_metrics;

SELECT
  MIN(room_temp) AS min_temp,
  MAX(room_temp) AS max_temp,
  ROUND(AVG(room_temp), 1) AS avg_temp
FROM health_metrics;

SELECT
  smoke_level,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM health_metrics), 2) AS percentage
FROM health_metrics
GROUP BY smoke_level
ORDER BY smoke_level;

SELECT COUNT(*) AS total_incidents
FROM incidents;

SELECT
  incident_type,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM incidents), 1) AS percentage
FROM incidents
GROUP BY incident_type
ORDER BY percentage DESC;

SELECT
  severity,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM incidents), 1) AS percentage
FROM incidents
GROUP BY severity;

SELECT
  severity,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM incidents WHERE incident_type = 'Fall'), 1) AS percentage
FROM incidents
WHERE incident_type = 'Fall'
GROUP BY severity;

SELECT
  severity,
  MIN(response_time_minutes) AS min_response,
  MAX(response_time_minutes) AS max_response,
  ROUND(AVG(response_time_minutes), 1) AS avg_response
FROM incidents
GROUP BY severity;

SELECT
  resolved,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM incidents), 1) AS percentage
FROM incidents
GROUP BY resolved;


SELECT COUNT(*) AS null_ages
FROM seniors
WHERE age IS NULL;

-- CHECK MISSING VALUES
-- seniors
SELECT
  SUM(CASE WHEN senior_id IS NULL THEN 1 ELSE 0 END) AS null_senior_id,
  SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS null_first_name,
  SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_age,
  SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
  SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS null_location,
  SUM(CASE WHEN admission_date IS NULL THEN 1 ELSE 0 END) AS null_admission_date,
  SUM(CASE WHEN risk_category IS NULL THEN 1 ELSE 0 END) AS null_risk_category
FROM seniors;

--health_metrics TABLE
SELECT
  SUM(CASE WHEN metric_id IS NULL THEN 1 ELSE 0 END) AS null_metric_id,
  SUM(CASE WHEN senior_id IS NULL THEN 1 ELSE 0 END) AS null_senior_id,
  SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_date,
  SUM(CASE WHEN step_count IS NULL THEN 1 ELSE 0 END) AS null_step_count,
  SUM(CASE WHEN heart_rate IS NULL THEN 1 ELSE 0 END) AS null_heart_rate,
  SUM(CASE WHEN room_temp IS NULL THEN 1 ELSE 0 END) AS null_room_temp,
  SUM(CASE WHEN smoke_level IS NULL THEN 1 ELSE 0 END) AS null_smoke_level
FROM health_metrics;

--incidents TABLE
SELECT
  SUM(CASE WHEN incident_id IS NULL THEN 1 ELSE 0 END) AS null_incident_id,
  SUM(CASE WHEN senior_id IS NULL THEN 1 ELSE 0 END) AS null_senior_id,
  SUM(CASE WHEN incident_date IS NULL THEN 1 ELSE 0 END) AS null_incident_date,
  SUM(CASE WHEN incident_time IS NULL THEN 1 ELSE 0 END) AS null_incident_time,
  SUM(CASE WHEN incident_type IS NULL THEN 1 ELSE 0 END) AS null_incident_type,
  SUM(CASE WHEN severity IS NULL THEN 1 ELSE 0 END) AS null_severity,
  SUM(CASE WHEN response_time_minutes IS NULL THEN 1 ELSE 0 END) AS null_response_time,
  SUM(CASE WHEN resolved IS NULL THEN 1 ELSE 0 END) AS null_resolved
FROM incidents;

--CHECK OUTLIERS
--seniors
SELECT *
FROM seniors
WHERE age < 65 OR age > 95
   OR gender NOT IN ('Male', 'Female')
   OR risk_category NOT IN ('Low', 'Medium', 'High')
   OR admission_date IS NULL;

--health_metrics
--will not use this code because it showed so many outliers so im using the clean view instead
--SELECT *
--FROM health_metrics
--WHERE step_count < 500 OR step_count > 10000
--   OR heart_rate < 55 OR heart_rate > 110
--   OR room_temp < 19 OR room_temp > 25
--   OR smoke_level < 0 OR smoke_level > 100
--   OR date IS NULL
--   OR senior_id NOT IN (SELECT senior_id FROM seniors);

CREATE VIEW clean_health_metrics AS
SELECT *
FROM health_metrics
WHERE step_count BETWEEN 500 AND 10000
  AND heart_rate BETWEEN 55 AND 110
  AND room_temp BETWEEN 19 AND 25
  AND smoke_level BETWEEN 0 AND 100
  AND senior_id IN (SELECT senior_id FROM seniors)
  AND date IS NOT NULL;

-- SENIORS duplicate IDs
SELECT senior_id, COUNT(*) AS duplicate_count
FROM seniors
GROUP BY senior_id
HAVING COUNT(*) > 1;

-- HEALTH_METRICS duplicate (same senior & date)
SELECT senior_id, date, COUNT(*) AS duplicate_count
FROM health_metrics
GROUP BY senior_id, date
HAVING COUNT(*) > 1;

-- INCIDENTS duplicate incident IDs
SELECT incident_id, COUNT(*) AS duplicate_count
FROM incidents
GROUP BY incident_id
HAVING COUNT(*) > 1;

--referential integrity
-- INCIDENTS linked to seniors
SELECT i.*
FROM incidents i
LEFT JOIN seniors s ON i.senior_id = s.senior_id
WHERE s.senior_id IS NULL;

-- HEALTH_METRICS linked to seniors
SELECT h.*
FROM health_metrics h
LEFT JOIN seniors s ON h.senior_id = s.senior_id
WHERE s.senior_id IS NULL;


--incidents
SELECT *
FROM incidents
WHERE response_time_minutes < 1 OR response_time_minutes > 60
   OR severity NOT IN ('Low', 'Medium', 'High')
   OR incident_type NOT IN ('Fall','Fire Alarm','Medical Emergency','Wandering','Medication Error')
   OR incident_date IS NULL
   OR senior_id NOT IN (SELECT senior_id FROM seniors);

-- clean view
-- Clean seniors (valid age only)
CREATE VIEW clean_seniors AS
SELECT *
FROM seniors
WHERE age BETWEEN 65 AND 95;

-- Clean health metrics
--clean view for health metrics already exists

-- Clean incidents
CREATE VIEW clean_incidents AS
SELECT *
FROM incidents
WHERE response_time_minutes BETWEEN 1 AND 60
  AND incident_date IS NOT NULL;
  
--standardise categories
UPDATE seniors
SET risk_category = CASE
    WHEN age >= 85 THEN 'High'
    WHEN age >= 75 THEN 'Medium'
    ELSE 'Low'
END;

-- check result
SELECT risk_category, COUNT(*) AS count
FROM seniors
GROUP BY risk_category;
