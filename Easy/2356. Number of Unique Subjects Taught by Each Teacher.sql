-- Problem 2356: Number of Unique Subjects Taught by Each Teacher
-- Difficulty: Easy

-- SQL Schema
-- Table: Teacher
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | teacher_id  | int  |
-- | subject_id  | int  |
-- | dept_id     | int  |
-- +-------------+------+
-- (subject_id, dept_id) is the primary key (combination of columns with unique values) of this table.
-- Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.

-- Problem Statement
-- Write a solution to calculate the number of unique subjects each teacher teaches in the university.
-- Return the result table in any order.

-- Solution:
-- We need to count the number of distinct subjects each teacher teaches. 
-- To achieve this, we'll use the `COUNT(DISTINCT subject_id)` function to count unique subjects for each teacher_id.

-- Solution Steps:
-- 1. Group the records by `teacher_id` to aggregate the results for each teacher.
-- 2. For each group (i.e., each teacher), count the number of distinct `subject_id`s.
-- 3. Return the result with `teacher_id` and the count of unique subjects.

SELECT teacher_id,
       COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

-- Intuition:
-- To determine the number of unique subjects each teacher teaches, we need to:
-- 1. Group the records by `teacher_id` so that we can aggregate data for each teacher.
-- 2. Use the `COUNT(DISTINCT subject_id)` function to count how many unique subjects each teacher is teaching.
-- 3. Return the result with the `teacher_id` and the count of distinct subjects.

-- Explanation:
-- The `GROUP BY teacher_id` clause groups the data by each teacher.
-- The `COUNT(DISTINCT subject_id)` function counts the number of unique subjects for each teacher.
-- This result is returned as `cnt`, representing the number of unique subjects each teacher teaches.
