-- Problem 1280: Students and Examinations
-- Difficulty: Easy

-- SQL Schema
-- Table: Students
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | student_id    | int     |
-- | student_name  | varchar |
-- +---------------+---------+
-- student_id is the primary key for this table.
-- Each row contains the ID and name of one student in the school.

-- Table: Subjects
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | subject_name | varchar |
-- +--------------+---------+
-- subject_name is the primary key for this table.
-- Each row contains the name of one subject in the school.

-- Table: Examinations
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | student_id   | int     |
-- | subject_name | varchar |
-- +--------------+---------+
-- There is no primary key for this table. It may contain duplicates.
-- Each row indicates that a student with ID student_id attended the exam of subject_name.

-- Problem Statement
-- Write a solution to find the number of times each student attended each exam.
-- Return the result table ordered by student_id and subject_name.

-- SQL Solution
SELECT 
    s.student_id, 
    s.student_name, 
    sub.subject_name, 
    COUNT(e.student_id) AS attended_exams 
FROM 
    students s
CROSS JOIN 
    subjects sub
LEFT JOIN 
    examinations e 
ON 
    s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, s.student_name, sub.subject_name
ORDER BY 
    s.student_id, sub.subject_name;

-- Intuition:
-- The problem requires counting how many times each student attended each exam.
-- To ensure that every student-subject combination is represented, we use a CROSS JOIN between the Students and Subjects tables.
-- A LEFT JOIN is then used with the Examinations table to count the number of exams attended by each student for each subject.
-- If a student has not attended an exam for a subject, the count will be 0.

-- Explanation:
-- The CROSS JOIN generates all possible combinations of students and subjects.
-- The LEFT JOIN with the Examinations table ensures that we include every combination, even if no exams were attended.
-- The COUNT function is used to tally the number of exams attended for each student-subject pair.
-- The result is then grouped by student_id, student_name, and subject_name, and ordered by student_id and subject_name.
