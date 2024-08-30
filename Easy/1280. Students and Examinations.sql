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
-- Each row contains the ID and the name of one student in the school.

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
-- This table may contain duplicates and has no primary key.
-- Each row indicates that a student with student_id attended the exam of subject_name.

-- Problem Statement
-- Write a solution to find the number of times each student attended each exam.
-- The result should be ordered by student_id and subject_name.

-- Solution:
-- The query first generates a cross join between Students and Subjects to ensure every student-subject combination is included.
-- Then, it performs a LEFT JOIN with the Examinations table to count the number of times each student attended the exams for each subject.
-- Finally, the result is grouped by student_id, student_name, and subject_name, and ordered by student_id and subject_name.

SELECT 
    s.student_id, 
    s.student_name, 
    sub.subject_name, 
    COUNT(e.student_id) AS attended_exams 
FROM 
    Students AS s
CROSS JOIN 
    Subjects AS sub
LEFT JOIN 
    Examinations AS e 
ON 
    s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, s.student_name, sub.subject_name
ORDER BY 
    s.student_id, sub.subject_name;

-- Explanation:
-- 1. **CROSS JOIN**: The query begins with a cross join between the `Students` and `Subjects` tables. This ensures that every student has a record for every subject, regardless of whether they attended the exam or not.
-- 2. **LEFT JOIN**: The `Examinations` table is then left joined to match the student-subject pairs with their corresponding exam attendance.
-- 3. **COUNT**: The `COUNT(e.student_id)` function counts the number of exams attended by each student for each subject. If a student has never attended an exam for a subject, the count will be zero.
-- 4. **GROUP BY**: The query groups the results by `student_id`, `student_name`, and `subject_name` to ensure that the count is calculated correctly for each unique student-subject pair.
-- 5. **ORDER BY**: The results are ordered by `student_id` and `subject_name` to meet the problem's requirement of sorted output.

-- This solution efficiently handles the problem and provides the desired output with the correct format and ordering.
