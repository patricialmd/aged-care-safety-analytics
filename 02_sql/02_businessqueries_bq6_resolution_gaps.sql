SELECT
    severity,
    resolved,
    COUNT(*) AS total_incidents
FROM clean_incidents
GROUP BY severity, resolved
ORDER BY severity, resolved;

SELECT
    incident_type,
    COUNT(*) AS unresolved_cases
FROM clean_incidents
WHERE resolved = 'No'
GROUP BY incident_type
ORDER BY unresolved_cases DESC;
