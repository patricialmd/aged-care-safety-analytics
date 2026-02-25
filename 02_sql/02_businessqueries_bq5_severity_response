SELECT
    severity,
    COUNT(*) AS total_incidents,
    ROUND(AVG(response_time_minutes), 1) AS avg_response_time
FROM clean_incidents
GROUP BY severity
ORDER BY severity;
