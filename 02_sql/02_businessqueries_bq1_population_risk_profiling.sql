SELECT 
	location,
	risk_category,
	COUNT(*) AS total_seniors,
	ROUND(AVG(age), 1) AS avg_age
FROM clean_seniors
GROUP BY location, risk_category
ORDER BY location, risk_category;
