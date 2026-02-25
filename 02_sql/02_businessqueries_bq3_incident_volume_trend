SELECT
    strftime('%Y-%m', incident_date) AS month,
    COUNT(*) AS total_incidents,
    SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END) AS high_severity_incidents
FROM clean_incidents
GROUP BY month
ORDER BY month;
