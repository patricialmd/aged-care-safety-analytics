SELECT
    s.senior_id,
    s.location,
    s.risk_category,
    COUNT(i.incident_id) AS total_incidents,
    SUM(CASE WHEN i.severity = 'High' THEN 1 ELSE 0 END) AS high_severity_incidents,
    ROUND(AVG(h.step_count), 0) AS avg_steps
FROM clean_seniors s
LEFT JOIN clean_incidents i
  ON s.senior_id = i.senior_id
LEFT JOIN clean_health_metrics h
  ON s.senior_id = h.senior_id
WHERE s.risk_category = 'High'
GROUP BY s.senior_id, s.location, s.risk_category
HAVING total_incidents >= 3
   AND avg_steps < 3000
ORDER BY high_severity_incidents DESC, total_incidents DESC;


