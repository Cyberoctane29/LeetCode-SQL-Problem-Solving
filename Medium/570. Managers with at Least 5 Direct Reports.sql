-- Problem 570: Managers with At Least 5 Direct Reports
-- Difficulty: Medium

-- SQL Schema
-- Table: Employee
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | department  | varchar |
-- | managerId   | int     |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the name of an employee, their department, and the id of their manager.
-- If managerId is null, then the employee does not have a manager.
-- No employee will be the manager of themselves.

-- Problem Statement
-- Write a solution to find managers with at least five direct reports.
-- Return the result table in any order.

-- SQL Solution 1: More readable and intuitive due to COUNT(manager_id)
WITH CTE AS (
    SELECT 
        a.id AS id,
        a.managerId AS manager_id,
        b.name AS manager_name
    FROM 
        Employee AS a
    INNER JOIN 
        Employee AS b ON a.managerId = b.id
),
FILTCSE AS (
    SELECT 
        manager_id,
        COUNT(manager_id) AS cnt
    FROM 
        CTE
    GROUP BY 
        manager_id
    HAVING 
        cnt >= 5
)
SELECT 
    name 
FROM 
    Employee 
WHERE 
    id IN (SELECT manager_id FROM FILTCSE);

-- Intuition:
-- To find managers with at least 5 direct reports, we need to count how many direct reports each manager has.
-- We join the Employee table with itself to get the mapping of employees to their managers.
-- Then, we count the number of direct reports for each manager and filter those with 5 or more direct reports.

-- Explanation:
-- 1. The CTE (`WITH CTE AS (...)`) creates a temporary result set that pairs each employee with their manager.
-- 2. In the `FILTCSE` CTE, we group by `manager_id` and count the number of direct reports for each manager.
-- 3. We filter out managers with fewer than 5 direct reports using the `HAVING cnt >= 5` clause.
-- 4. Finally, we select the names of these managers from the Employee table using a subquery.

-- SQL Solution 2: More efficient as it does not check for NULLs due to COUNT(*)
WITH CTE AS (
    SELECT 
        a.id AS id,
        a.managerId AS manager_id,
        b.name AS manager_name
    FROM 
        Employee AS a
    INNER JOIN 
        Employee AS b ON a.managerId = b.id
),
FILTCSE AS (
    SELECT 
        manager_id,
        COUNT(*) AS cnt
    FROM 
        CTE
    GROUP BY 
        manager_id
    HAVING 
        cnt >= 5
)
SELECT 
    name 
FROM 
    Employee 
WHERE 
    id IN (SELECT manager_id FROM FILTCSE);

-- Intuition:
-- This solution is similar to the first one but uses `COUNT(*)` to count all rows for each manager, which can be more efficient.
-- It avoids counting NULLs explicitly because `COUNT(*)` counts all rows in the group.

-- Explanation:
-- 1. The CTE (`WITH CTE AS (...)`) creates a temporary result set that links employees with their managers.
-- 2. The `FILTCSE` CTE counts the number of direct reports for each manager using `COUNT(*)`.
-- 3. Managers with at least 5 direct reports are selected using the `HAVING cnt >= 5` clause.
-- 4. We then retrieve the names of these managers from the Employee table using a subquery.

-- Note: Both solutions effectively solve the problem, with the second being slightly more efficient by avoiding NULL checks.
