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
-- Write a solution to show the unique ID of each user. If a user does not have a unique ID, return null instead.

-- Solution:
-- The query performs a RIGHT JOIN between the Employees table and the EmployeeUNI table to ensure all employees are included,
-- even those without a unique_id in the EmployeeUNI table. If there is no matching unique_id for an employee, the result should show NULL.

SELECT 
    eu.unique_id, 
    e.name 
FROM 
    EmployeeUNI AS eu 
RIGHT JOIN 
    Employees AS e 
ON 
    eu.id = e.id;

-- Explanation:
-- 1. **RIGHT JOIN**: We use a RIGHT JOIN to include all rows from the `Employees` table, and matching rows from the `EmployeeUNI` table.
--    If no match is found in `EmployeeUNI`, the result will include NULL for `unique_id`.
-- 2. **Selecting Columns**: The SELECT statement retrieves the `unique_id` from `EmployeeUNI` and the `name` from `Employees`.
-- 3. **ON Clause**: The join is based on the common `id` column present in both tables.

-- This solution ensures that every employee in the company is listed with their corresponding unique identifier if available,
-- or with NULL if they don't have a unique ID in the `EmployeeUNI` table.
