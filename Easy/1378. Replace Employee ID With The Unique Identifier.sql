-- Problem 1378: Replace Employee ID With The Unique Identifier
-- Difficulty: Easy

-- SQL Schema
-- Table: Employees
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the id and the name of an employee in a company.

-- Table: EmployeeUNI
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | unique_id     | int     |
-- +---------------+---------+
-- (id, unique_id) is the primary key for this table.
-- Each row of this table contains the id and the corresponding unique id of an employee in the company.

-- Problem Statement
-- Write a solution to show the unique ID of each user. If a user does not have a unique ID, show null.

-- SQL Solution
SELECT 
    eu.unique_id,
    e.name 
FROM 
    EmployeeUNI eu 
RIGHT JOIN 
    Employees e 
ON 
    eu.id = e.id;

-- Intuition:
-- To list the employees along with their unique IDs, we need to join the `Employees` table with the `EmployeeUNI` table.
-- Since we want to include all employees even if they don't have a unique ID, we use a RIGHT JOIN.

-- Explanation:
-- The RIGHT JOIN ensures that every employee in the `Employees` table is included in the result, even if there is no matching entry in the `EmployeeUNI` table.
-- If an employee does not have a unique ID, the `unique_id` field will be NULL.
