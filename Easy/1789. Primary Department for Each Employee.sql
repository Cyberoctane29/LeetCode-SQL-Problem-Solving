-- Problem 1789: Primary Department for Each Employee
-- Difficulty: Easy

-- SQL Schema
-- Table: Employee
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | department_id | int     |
-- | primary_flag  | varchar |
-- +---------------+---------+
-- (employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
-- employee_id is the id of the employee.
-- department_id is the id of the department to which the employee belongs.
-- primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.

-- Problem Statement
-- Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.
-- Return the result table in any order.

-- Solution 1:
-- Using a UNION to combine results of employees with only one department and those with a primary department.

SELECT employee_id, department_id
FROM employee
GROUP BY employee_id
HAVING COUNT(department_id) = 1

UNION

SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y';

-- Intuition:
-- This solution aims to identify the primary department for each employee. Employees who only have one department do not need a flag to indicate their primary department because it is their only department. The UNION operation helps to combine these two conditions into one result set.

-- Explanation:
-- The first query part selects employees who belong to only one department. By grouping employees and checking if the count of their departments is equal to 1, it captures employees with a single department.
-- The second query part selects departments marked as primary for each employee where `primary_flag` is 'Y'.
-- The `UNION` operation combines both sets of results: the single department cases and the primary department cases, ensuring a comprehensive list of primary departments for all employees.

-- Solution 2:
-- Using a combination of conditions to fetch primary departments or the only department for employees.

SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y'
OR employee_id IN (
    SELECT employee_id
    FROM employee
    GROUP BY employee_id
    HAVING COUNT(department_id) = 1
);

-- Intuition:
-- This solution identifies primary departments and departments for employees with only one department in a single query using logical conditions and subqueries.

-- Explanation:
-- The query first selects departments where `primary_flag` is 'Y', ensuring that all primary departments are reported.
-- It then includes employees who belong to exactly one department by using a subquery to count departments and checking if this count equals 1.
-- This approach ensures that employees with only one department (which is inherently their primary department) are included in the result set.
