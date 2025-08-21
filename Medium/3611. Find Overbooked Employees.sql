-- Problem 3611: Find Overbooked Employees
-- Difficulty: Medium

-- Table: employees
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | employee_name | varchar |
-- | department    | varchar |
-- +---------------+---------+
-- employee_id is the unique identifier for this table.
-- Each row contains information about an employee and their department.

-- Table: meetings
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | meeting_id    | int     |
-- | employee_id   | int     |
-- | meeting_date  | date    |
-- | meeting_type  | varchar |
-- | duration_hours| decimal |
-- +---------------+---------+
-- meeting_id is the unique identifier for this table.
-- Each row represents a meeting attended by an employee.

-- Problem Statement:
-- Find employees who are meeting-heavy:
-- - A standard work week = 40 hours (Mon–Sun).
-- - An employee is meeting-heavy in a week if their meeting hours > 20.
-- - Count how many weeks each employee was meeting-heavy.
-- - Only include employees with at least 2 such weeks.
-- - Return results ordered by meeting_heavy_weeks descending, 
--   then by employee_name ascending.

-- Solution:

WITH CTE AS (
    SELECT 
        employee_id,
        WEEK(meeting_date, 1) AS week_number, -- week starts Monday
        SUM(duration_hours) AS totwk_hrs
    FROM meetings
    GROUP BY employee_id, week_number
),
CTE1 AS (
    SELECT 
        employee_id,
        SUM(IF(totwk_hrs > 20, 1, 0)) AS meeting_heavy_weeks
    FROM CTE
    GROUP BY employee_id
    HAVING SUM(IF(totwk_hrs > 20, 1, 0)) >= 2
)
SELECT 
    c1.employee_id,
    e.employee_name,
    e.department,
    c1.meeting_heavy_weeks
FROM CTE1 AS c1
LEFT JOIN employees AS e 
    ON c1.employee_id = e.employee_id
ORDER BY meeting_heavy_weeks DESC, employee_name ASC;

-- Intuition:
-- We want to measure per-week meeting load per employee, 
-- then flag "meeting-heavy" weeks where meeting hours exceed 20.
-- Finally, count how many such weeks exist per employee and 
-- filter for those with at least 2.

-- Explanation:
-- - CTE: Aggregate total weekly meeting hours per employee using WEEK(date,1).
-- - CTE1: Convert each weekly total into a binary flag (1 if >20 hours, else 0),
--         then sum across weeks to count how many times an employee was "meeting-heavy".
--         Only keep employees with >=2 such weeks.
-- - Final SELECT: Join with employees table to show name + department,
--   and order by number of meeting-heavy weeks (desc) then name (asc).
