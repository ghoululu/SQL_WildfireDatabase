-- Lucia Carli, Carolyn Xie, Bryce Almond

/*
.For each query, give a brief description of its purpose, summarize the results, and provide managerial implications/recommendations
based on the results of your query. This narrative should be included in your SQL script as comments
*/


USE Wildfire_db;


-- Query to find most frequent cause of Wildfires where property cost is greater than avg. - By Lucia Carli

SELECT TOP 1 sc.Specific_Cause,
-- Counting the number of instances of each "specific cause"
 COUNT(Specific_Cause) AS Specific_Cause_Count
FROM Wildfire w
JOIN Damage d ON w.WildfireID = d.WildfireID
JOIN WildfireCause wc ON  w.WildfireID = wc.WildfireID
JOIN SpecificCause sc ON wc.Specific_CauseID = sc.Specific_CauseID
-- subquery for finding WF with higher prop. cost than the avg
WHERE Property_Cost > 
(SELECT AVG(Property_Cost)
FROM Damage)
GROUP BY sc.Specific_Cause
ORDER BY Specific_Cause_Count DESC;

/*
Purpose: This querys purpose is to list the fire names of wildfires where the proprty cost is greater than the average property cost of all fires,
As well as find the most frequent cause of these more expensive fires (Sort by specific cause).

Results: The most frequent cause of fires that occured at places with property costs higher than the average property cost was "lightening",
with a Specific_Cause_Count of 3

Implications: This informs us that the wildfires that occurred at the most expensive properities were not caused by humans. 
This could lead to exploring better natural protections and sustainable architectures that prevent against these fires.

*/

-- Query to compute protected acres as a percentage of total acres - By Lucia Carli

WITH cte_ProtectedAcres
AS (
    SELECT w.Fire_Name, w.Acres, r.Protected_Acres,
    ((w.Acres + r.Protected_Acres)) AS lc_total_acres,
    ((r.Protected_Acres * 1.0)/((w.Acres + r.Protected_Acres))) AS PA_Percentage
    FROM Wildfire w
    JOIN Response r ON w.WildfireID = r. WildfireID
    WHERE ((w.Acres + r.Protected_Acres)) > 0
),
cte_PA_rank
AS(
    SELECT Fire_Name, lc_total_acres, Protected_Acres, PA_Percentage,
    DENSE_RANK() OVER (ORDER BY PA_Percentage DESC) AS PA_Ranking,
    FORMAT(PA_Percentage, 'P2') AS PA_Ranking_Percent
    FROM cte_ProtectedAcres
)
SELECT TOP 5 PA_Ranking, Fire_Name, lc_total_acres, Protected_Acres, PA_Ranking_Percent
FROM cte_PA_rank
ORDER BY PA_Ranking ASC;

/*
Purpose: This querys purpose was to create total acres as the sum of acres damaged in the wildfire (acres) and protected_acres,
and then rank the top 5 wildfires with the highest amount of protected acres as a percentage of total acres.

Results: The highest percentage of protected acres out of total acres was 100% which seems to be an outlier in the data. 
The rest of the top 5 were 50%, meaning that even the top 5 percentage of protected acres is almost never above 50%

Implications: This implies that the current system for protecting land mass isnt extremely effective, and their should be initiatives 
to raise the protected acre perentage through administrative work and aid

*/



-- Query for computing most popular severity ranking and the district with the highest casualty count (2005-2010) - By Lucia Carli

-- stored proceedure with parameters for a select query
GO
CREATE PROCEDURE pop_sev_rank_dist_casualties2
@startyear INT,
@endyear INT
AS
BEGIN
    -- CTE for finding the most frequent severity
    WITH cte_sev_rank
    AS(
    -- use dense rank for finding the most frequent severity
        SELECT w.Severity, COUNT(w.WildfireID) AS lc_wildfire_count,
        DENSE_RANK() OVER (ORDER BY COUNT(w.WildfireID) DESC) AS lc_sev_rank
        FROM Wildfire w
        JOIN History h ON w.WildfireID = h.WildfireID
    -- making sure the frequency only considers the years 2005-2010
        WHERE YEAR(h.Ignition_Time) BETWEEN @startyear AND @endyear
        AND h.Ignition_Time IS NOT NULL and h.Ignition_Time != ''
        GROUP BY w.Severity
),
-- CTE for casualties for each district
cte_casualties_rank
    AS(
        SELECT l.District_Name, SUM(v.CasualtyNumber) AS lc_total_cas,
    -- Ranking district with the highest casualties 
        DENSE_RANK() OVER (ORDER BY SUM(v.CasualtyNumber) DESC) AS lc_cas_rank
        FROM Wildfire w
        JOIN History h ON w.WildfireID = h.WildfireID
        JOIN Response r ON w.WildfireID = r.WildfireID
        JOIN Victims v ON r.ResponseID = v.ResponseID
        JOIN LocationType lt ON W.WildfireID = lt.WildfireID
        JOIN [Location] l ON lt.LocationID = l.LocationID
    -- making sure the frequency only considers the years 2005-2010 using the stored proceedure
        WHERE YEAR(h.Ignition_Time) BETWEEN @startyear AND @endyear
        AND h.Ignition_Time IS NOT NULL and h.Ignition_Time != ''
        GROUP BY l.District_Name
)
-- final select statement for the most frequent severity (from cte1)
SELECT 'Most frequent severity' AS Title,
cte1.Severity AS 'Highest Frequency',
cte1.lc_wildfire_count AS tot_count
FROM cte_sev_rank cte1
WHERE cte1.lc_sev_rank = 1
-- combining both select statements 
-- use union all because we want all results of both queries even if duplicates
UNION ALL 
-- Select statement for the district with the highest number of casualties (from cte2)
SELECT 'District with highest casualty' AS Title,
cte2.District_Name AS 'Highest Frequency',
cte2.lc_total_cas AS tot_count
FROM cte_casualties_rank cte2
WHERE cte2.lc_cas_rank =1;
END
GO
-- Execute the query with the correct years
EXEC pop_sev_rank_dist_casualties2 2005, 2010;


/*
Purpose: The purpose of this query is to find the most popular severity ranking and the district with the highest casualty count
from wildfires between 2005 and 2010. This is to compare historical records of severity and casualtys from this time period.

Results: the most frequent severity was A, with a total count of 15 times (the highest severity on a rank of A,B,C), 
and the district with the highest casualty count over these years was Douglas with 4. 

Implications: This shows that from 2005 to 2010 the highest severity level was the most frequent. This can be compared to future severity frequencys 
to show progress in wildfire response methods. The same sentiment can be applied when looking at douglas county, comparing their casualty rates to those 
that they have in current times to see improvement, or lack thereof. 
*/


-- query to find acres affected by wildfires that were previously shutdown (non-human involvement) -- By Lucia Carli

SELECT w.Severity, SUM(w.Acres + r.Protected_Acres) AS 'total acres effected by wildfires with IR "shutdown", that was not the cause of humans'
FROM Wildfire w
JOIN Damage d ON w.WildfireID = d.WildfireID
JOIN WildfireCause wc ON w.WildfireID = wc.WildfireID
JOIN Response r ON w.WildfireID = r.WildfireID
WHERE d.Industrial_Restriction LIKE '%Shutdown%'
AND wc.Human = 0
GROUP BY w.Severity
ORDER BY 'total acres effected by wildfires with IR "shutdown", that was not the cause of humans' DESC;

/*
Purpose: The purpose of this query was to list the total acres effected by wildfires with an industrial_restriction that contains the word "shutdown" that was not the cause of humans.
They are grouped by severity as well. This would likely let us know if the shutdowns (preventing humans from entering) are useful,
or if resources could be allocated elsewhere.

Results: Severity B Wildires have a total of 3 'shutsdown' acres that were not the cause of humans, were as severity A has 0.54 Acres.
It seems that though they are less severe there is still a large amount of acres that while being shut down are still at risk due to non human forces

Implications: This should lead to further analysis of cause of these fires as well as efforts to refine the "shutdown proccess" 
and make it less of a hazard or animals, machinary, etc. that might cause wildfires.
*/


/* Query 1: Return the average acres affected by county - By Carolyn Xie */


SELECT
   l.County,
   AVG(w.Acres) AS Avg_Acres_Burned,
   COUNT(*) AS NumberOfWildfires
FROM Wildfire w
JOIN LocationType lt ON lt.WildfireID = w.WildfireID
JOIN Location l ON l.LocationID = lt.LocationID
GROUP BY l.County
HAVING AVG(w.Acres) > 1    
ORDER BY Avg_Acres_Burned DESC;

/*
Purpose: This query calculates the average acres affected by wildfires in each Oregon county, which helps us identify which counties are most at risk.
Results: Returned a table with a ranked list of three counties: Union, Linn, and Clatsop, with the average acres burned for each county that is >1.
Managerial implications/recommendations: Counties with higher average acres burned may need additional restoration efforts, increased firefighter and detection resources, or greater land management efforts. Resources should be prioritized to these most at risk counties.
*/


/* Query 2: Return the wildfires with the highest damage costs -- By Carolyn Xie */


SELECT TOP 10
   w.Fire_Name,
   w.Severity,
   d.Property_Cost,
   l.County,
   lt.RiskLevel
FROM Damage d
JOIN Wildfire w ON d.WildfireID = w.WildfireID
JOIN LocationType lt ON lt.WildfireID = w.WildfireID
JOIN Location l ON lt.LocationID = l.LocationID
ORDER BY d.Property_Cost DESC;

/*
Purpose: This query helps us identify the top 10 most expensive wildfires by property damage cost. It helps us understand which wildfires resulted in the biggest financial losses.
Results: The query results in a table with 10 wildfire names, severity class, property cost (in $), county, and risk level.
Managerial implications/recommendations: Wildfires with the highest financial damage should be prioritized and the areas investigated for potential delayed response factors. These results can help restoration efforts in insurance planning or emergency budget allocation.
*/

/* Query 3: Return the wildfires with greater than average acres burned from 2010 to 2022
and the counties with the highest human caused wildfires -- By Carolyn Xie */


-- CTE to calculate the average acres burned between 2010 and 2022
WITH cte_avgacres AS (
   SELECT AVG(w.Acres) AS Avg_Acres
   FROM Wildfire w
   JOIN History h ON w.WildfireID = h.WildfireID
   WHERE YEAR(h.Ignition_Time) BETWEEN 2010 AND 2022
),


-- CTE to count human-caused wildfires by county
cte_humanCausedByCounty AS (
   SELECT
       l.County,
       COUNT(*) AS HumanCausedFires
   FROM WildfireCause wc
   JOIN Wildfire w ON wc.WildfireID = w.WildfireID
   JOIN LocationType lt ON lt.WildfireID = w.WildfireID
   JOIN Location l ON l.LocationID = lt.LocationID
   WHERE wc.Human = 1
   GROUP BY l.County
)


SELECT
   w.Fire_Name,
   w.Acres,
   l.County,
   hcb.HumanCausedFires
FROM Wildfire w
JOIN History h ON w.WildfireID = h.WildfireID
JOIN LocationType lt ON lt.WildfireID = w.WildfireID
JOIN Location l ON l.LocationID = lt.LocationID
JOIN cte_avgacres a ON w.Acres > a.Avg_Acres
JOIN cte_humanCausedByCounty hcb ON l.County = hcb.County
WHERE YEAR(h.Ignition_Time) BETWEEN 2010 AND 2022
ORDER BY w.Acres DESC, hcb.HumanCausedFires DESC;


/*
Purpose: This identifies wildfires from 2010 to 2022 that burned more acres than the overall
average within this time period as well as the counties with the highest human-caused wildfires.
Results: The table's output results in 2 fires, Ritter and Bass 497 as well as the acres, county, and human causes involved. These isolated the unusually large outliers in fire events.
Managerial implications/recommendations: Counties with frequent human-caused fires and large burn areas should be targeted for public education campaigns and fireworks regulations. These results help us understand where prevention funding will have the highest benefit in reducing wildfire frequency and scale.
*/


/* Query 4: Return the firefighters who have responded to the most wildfires - by Carolyn Xie */


SELECT
   f.Firefighter_Name,
   f.Firefighter_Experience,
   COUNT(f.WildfireID) AS TotalFiresResponded
FROM Firefighter f
GROUP BY f.Firefighter_Name, f.Firefighter_Experience
HAVING COUNT(f.WildfireID) = (
--Subquery: Find the maximum number of fires responded to
       SELECT MAX(FireCount)
       FROM (
             SELECT COUNT(responder.WildfireID) AS FireCount
             FROM Firefighter responder
             GROUP BY responder.FirefighterID
            ) AS Responder
     )
ORDER BY TotalFiresResponded DESC;


/*
Purpose: The purpose of this query is to identify the firefighters who have responded to the most fires, in order to identify those who have the most experience.
Return: This query returns a table listing firefighter name, experience in years, and total fires responded to.
Managerial implications/recommendations: This query is important as it identifies the top experts in the field, and who to prioritize for other high-risk assignments or leadership roles. Monitoring firefighter workload can also help prevent overworking and burnout.
*/

