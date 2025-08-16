-- Problem 3580: Find Consistently Improving Employees
-- Difficulty: Medium

-- Table: employees
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | name        | varchar |
-- +-------------+---------+
-- employee_id is the unique identifier for this table.
-- Each row contains information about an employee.

-- Table: performance_reviews
-- +-------------+------+ 
-- | Column Name | Type | 
-- +-------------+------+ 
-- | review_id   | int  | 
-- | employee_id | int  | 
-- | review_date | date | 
-- | rating      | int  | 
-- +-------------+------+ 
-- review_id is the unique identifier for this table.
-- Each row represents a performance review for an employee.
-- Rating is on a scale of 1-5, where 5 is excellent and 1 is poor.

-- Problem Statement:
-- Find employees who have consistently improved their performance over their last three reviews:
-- - Employee must have at least 3 reviews.
-- - Last 3 reviews must show strictly increasing ratings (most recent review has the highest rating).
-- - Improvement score = difference between latest rating and earliest rating among last 3 reviews.
-- Return results ordered by improvement_score descending, then by name ascending.

-- Solution 1 (Using scalar subqueries relying on MySQL’s lenient GROUP BY (may fail if ONLY_FULL_GROUP_BY is enabled)):

WITH CTE AS (
    SELECT employee_id, review_date, rating
    FROM performance_reviews
    WHERE employee_id IN (
        SELECT employee_id
        FROM performance_reviews
        GROUP BY employee_id
        HAVING COUNT(*) >= 3
    )
),
CTE1 AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM CTE
),
CTE2 AS (
    SELECT c.employee_id, c.rating, c.rn
    FROM CTE1 AS c
    WHERE 
        (SELECT rating FROM CTE1 WHERE rn = 1 AND employee_id = c.employee_id) >
        (SELECT rating FROM CTE1 WHERE rn = 2 AND employee_id = c.employee_id)
        AND
        (SELECT rating FROM CTE1 WHERE rn = 2 AND employee_id = c.employee_id) >
        (SELECT rating FROM CTE1 WHERE rn = 3 AND employee_id = c.employee_id)
)
SELECT 
    c2.employee_id,
    e.name,
    ((SELECT rating FROM CTE2 WHERE rn = 1 AND employee_id = c2.employee_id) - 
     (SELECT rating FROM CTE2 WHERE rn = 3 AND employee_id = c2.employee_id)) AS improvement_score
FROM CTE2 AS c2
LEFT JOIN employees AS e ON c2.employee_id = e.employee_id
GROUP BY c2.employee_id, e.name
ORDER BY improvement_score DESC, e.name;

-- Intuition (Solution 1):
-- Use scalar subqueries to pick the last 3 reviews of each employee and check for strictly increasing ratings.
-- Relies on MySQL allowing columns in SELECT that are not in GROUP BY (may fail if ONLY_FULL_GROUP_BY is enabled).
-- Compute improvement_score as the difference between the most recent (rn=1) and earliest (rn=3) review rating.

-- Explanation (Solution 1):
-- - Filter employees with at least 3 reviews.
-- - ROW_NUMBER ranks reviews per employee in descending order of review_date.
-- - CTE2 selects only employees whose top 3 reviews have strictly increasing ratings.
-- - The final SELECT computes improvement_score and joins with employee names.
-- - GROUP BY prevents duplicates; results are ordered by improvement_score descending and name ascending.

-- Solution 2 (Using pivoted ROW_NUMBER into columns — standard SQL portable approach):

WITH CTE AS (
    SELECT employee_id, review_date, rating
    FROM performance_reviews
    WHERE employee_id IN (
        SELECT employee_id
        FROM performance_reviews
        GROUP BY employee_id
        HAVING COUNT(*) >= 3
    )
),
CTE1 AS (
    SELECT 
        employee_id,
        review_date,
        rating,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM CTE
),
CTE_PIVOT AS (
    SELECT
        employee_id,
        MAX(CASE WHEN rn = 1 THEN rating END) AS rating1,
        MAX(CASE WHEN rn = 2 THEN rating END) AS rating2,
        MAX(CASE WHEN rn = 3 THEN rating END) AS rating3
    FROM CTE1
    GROUP BY employee_id
),
CTE2 AS (
    SELECT
        employee_id,
        rating1,
        rating2,
        rating3
    FROM CTE_PIVOT
    WHERE rating1 > rating2 AND rating2 > rating3
)
SELECT 
    c2.employee_id,
    e.name,
    (c2.rating1 - c2.rating3) AS improvement_score
FROM CTE2 c2
LEFT JOIN employees e ON c2.employee_id = e.employee_id
ORDER BY improvement_score DESC, e.name;

-- Intuition (Solution 2):
-- Convert each employee’s last three reviews into separate columns (rating1, rating2, rating3) for easier comparison.
-- Only keep employees whose ratings strictly increase.
-- Compute improvement_score as the difference between most recent and earliest of the last three reviews.

-- Explanation (Solution 2):
-- - ROW_NUMBER ranks reviews per employee by descending review_date.
-- - CTE_PIVOT uses MAX(CASE...) to pivot top 3 reviews into columns.
-- - Filter strictly increasing ratings with rating1 > rating2 > rating3.
-- - Compute improvement_score as rating1 - rating3.
-- - Join employee names and order results by improvement_score descending, then name ascending.
