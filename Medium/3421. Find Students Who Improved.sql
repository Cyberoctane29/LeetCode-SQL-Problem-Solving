-- Problem 3421: Find Students Who Improved
-- Difficulty: Medium

-- Table: Scores
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | student_id  | int     |
-- | subject     | varchar |
-- | score       | int     |
-- | exam_date   | varchar |
-- +-------------+---------+
-- (student_id, subject, exam_date) is the primary key for this table.
-- Each row contains information about a student's score in a specific subject on a particular exam date. Scores are between 0 and 100.

-- Problem Statement:
-- Find students who have shown improvement in any subject.
-- A student is considered improved if:
-- - They have taken exams in the same subject on at least two different dates.
-- - Their latest score in that subject is higher than their first score.
-- Return the result table ordered by student_id and subject ascending.

-- Solution 1

SELECT 
    s.student_id,
    s.subject, 
    MAX(CASE WHEN exam_date = (SELECT MIN(exam_date) FROM scores WHERE student_id = s.student_id AND subject = s.subject) THEN score END) AS first_score,
    MAX(CASE WHEN exam_date = (SELECT MAX(exam_date) FROM scores WHERE student_id = s.student_id AND subject = s.subject) THEN score END) AS latest_score
FROM 
    scores AS s
GROUP BY 
    student_id, subject
HAVING 
    first_score < latest_score
ORDER BY 
    s.student_id, s.subject;

-- Intuition:
-- I want to find students with at least two exams in the same subject and a higher latest score than the first.

-- Explanation:
-- I use correlated subqueries inside CASE WHEN statements to get the first and latest exam scores for each student and subject.
-- Then, I group by student_id and subject and filter those with latest_score > first_score.
-- Finally, I order by student_id and subject ascending.

-- Solution 2

WITH Ranked AS (
    SELECT
        student_id,
        subject,
        FIRST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date) AS first_score,
        FIRST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_score
    FROM Scores
)
SELECT DISTINCT *
FROM Ranked
WHERE first_score < latest_score
ORDER BY student_id, subject;

-- Intuition:
-- Using window functions to directly fetch first and latest scores for each student and subject.

-- Explanation:
-- FIRST_VALUE window function obtains the earliest and latest scores by ordering exam_date ascending and descending.
-- I then filter rows where latest_score is greater than first_score and select distinct to avoid duplicates.
-- Ordering by student_id and subject as required.

-- Solution 3

WITH CTE AS (
    SELECT student_id, subject
    FROM scores
    GROUP BY student_id, subject
    HAVING COUNT(*) > 1
),
CTE1 AS (
    SELECT *
    FROM scores
    WHERE (student_id, subject) IN (
        SELECT student_id, subject FROM CTE
    )
)
SELECT 
    s.student_id,
    s.subject,
    MAX(CASE 
        WHEN exam_date = (SELECT MIN(exam_date) FROM scores WHERE student_id = s.student_id AND subject = s.subject)
        THEN score
        ELSE NULL
    END) AS first_score,
    MAX(CASE 
        WHEN exam_date = (SELECT MAX(exam_date) FROM scores WHERE student_id = s.student_id AND subject = s.subject)
        THEN score
        ELSE NULL
    END) AS latest_score
FROM 
    CTE1 s
GROUP BY 
    s.student_id, s.subject
HAVING 
    first_score < latest_score
ORDER BY 
    s.student_id, s.subject;

-- Intuition:
-- Filter students and subjects with multiple exams, then find and compare first and latest scores.

-- Explanation:
-- The first CTE identifies student-subject pairs with more than one exam.
-- The second CTE filters the main table to only those pairs.
-- Then, the main SELECT calculates first and latest scores with correlated subqueries inside CASE.
-- Finally, filter for improvements and order results.
