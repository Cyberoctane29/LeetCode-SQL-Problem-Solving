-- Problem 596: Classes More Than 5 Students
-- Difficulty: Easy

-- SQL Schema
-- Table: Courses
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | student     | varchar |
-- | class       | varchar |
-- +-------------+---------+
-- (student, class) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table indicates the name of a student and the class in which they are enrolled.

-- Problem Statement
-- Write a solution to find all the classes that have at least five students.

-- SQL Solution
SELECT class
FROM (
    SELECT class, COUNT(student) AS cnt
    FROM Courses
    GROUP BY class
    HAVING COUNT(student) >= 5
) AS der_tab;

-- Intuition:
-- To find classes with at least five students, we need to count the number of students in each class.
-- We then filter the results to include only those classes where the student count is five or more.

-- Explanation:
-- The inner query groups the `Courses` table by `class` and counts the number of students in each class.
-- The `HAVING` clause filters the results to keep only those classes where the count of students is at least 5.
-- The outer query selects the `class` from these filtered results.
