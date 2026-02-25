SELECT
    s.risk_category,
    i.incident_type,
    COUNT(*) AS total_incidents
FROM clean_incidents i
JOIN clean_seniors s
  ON i.senior_id = s.senior_id
GROUP BY s.risk_category, i.incident_type
ORDER BY s.risk_category, total_incidents DESC;
