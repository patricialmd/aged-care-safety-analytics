SELECT
    i.incident_type,
    ROUND(AVG(h.step_count), 0) AS avg_steps,
    ROUND(AVG(h.heart_rate), 1) AS avg_heart_rate
FROM clean_incidents i
JOIN clean_health_metrics h
  ON i.senior_id = h.senior_id
 AND i.incident_date = h.date
GROUP BY i.incident_type
ORDER BY avg_steps;
