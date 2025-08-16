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
-- Ratings are on a scale of 1–5 where 5 is excellent and 1 is poor.

-- Problem Statement:
-- Find employees who have consistently improved their performance 
-- over their last three reviews.
-- Conditions:
-- • Employee must have at least 3 reviews. 
-- • The last 3 reviews (by review_date) must show strictly increasing ratings. 
-- • Improvement score = latest rating - earliest rating among the 3. 
-- Return results ordered by improvement score (descending), 
-- then by name (ascending).

-- Solution 1:

WITH CTE AS (
    SELECT 
        employee_id,
        review_date,
        rating
    FROM 
        performance_reviews
    WHERE 
        employee_id IN (
            SELECT employee_id 
            FROM performance_reviews 
            GROUP BY employee_id 
            HAVING COUNT(*) >= 3
        )
),
CTE1 AS (
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM 
        CTE
),
CTE2 AS (
    SELECT 
        c.employee_id,
        c.rating,
        c.rn
    FROM 
        CTE1 AS c
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
    (
        (SELECT rating FROM CTE2 WHERE rn = 1 AND employee_id = c2.employee_id) -
        (SELECT rating FROM CTE2 WHERE rn = 3 AND employee_id = c2.employee_id)
    ) AS improvement_score
FROM 
    CTE2 AS c2
LEFT JOIN 
    employees AS e 
    ON c2.employee_id = e.employee_id
GROUP BY 
    c2.employee_id
ORDER BY 
    improvement_score DESC, 
    name;

-- Intuition:
-- Use ROW_NUMBER to order reviews for each employee by recency.
-- Focus only on employees with at least 3 reviews.
-- Check if their last 3 ratings form a strictly increasing sequence.
-- If yes, compute improvement score as (latest - earliest rating) among the last 3.
-- Finally, join with employee names and order the results.

-- Explanation:
-- CTE filters employees with at least 3 reviews.
-- CTE1 assigns row numbers to reviews in descending order of review_date.
-- CTE2 validates that for each employee, rating at rn=1 > rn=2 > rn=3.
-- The main query computes the improvement score from those 3 ratings and joins with the employees table.
-- Results are grouped by employee and sorted as required.
