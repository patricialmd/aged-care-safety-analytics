SELECT
    s.location,
    i.severity,
    COUNT(*) AS total_incidents,
    ROUND(AVG(i.response_time_minutes), 1) AS avg_response_time
FROM clean_incidents i
JOIN clean_seniors s
  ON i.senior_id = s.senior_id
GROUP BY s.location, i.severity
ORDER BY s.location, total_incidents DESC;
