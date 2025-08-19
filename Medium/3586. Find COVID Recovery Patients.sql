-- Problem 3586: Find COVID Recovery Patients
-- Difficulty: Medium

-- Table: patients
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | patient_id  | int     |
-- | patient_name| varchar |
-- | age         | int     |
-- +-------------+---------+
-- patient_id is the unique identifier for this table.
-- Each row contains information about a patient.

-- Table: covid_tests
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | test_id     | int     |
-- | patient_id  | int     |
-- | test_date   | date    |
-- | result      | varchar |
-- +-------------+---------+
-- test_id is the unique identifier for this table.
-- Each row represents a COVID test result. Result can be 'Positive', 'Negative', or 'Inconclusive'.

-- Problem Statement:
-- Find patients who have recovered from COVID:
-- - A patient is considered recovered if they have at least one Positive test followed by at least one Negative test on a later date.
-- - Calculate recovery_time in days as the difference between the first positive test and the first negative test after that positive test.
-- - Only include patients who have both Positive and Negative test results.
-- - Return results ordered by recovery_time ascending, then by patient_name ascending.

-- Solution:

WITH CTE AS (
    SELECT DISTINCT 
        ct.patient_id,
        DATEDIFF(
            (
                SELECT MIN(test_date) 
                FROM covid_tests 
                WHERE patient_id = ct.patient_id 
                  AND result = 'Negative' 
                  AND test_date > (
                      SELECT MIN(test_date) 
                      FROM covid_tests 
                      WHERE result = 'Positive' 
                        AND patient_id = ct.patient_id
                  )
                GROUP BY patient_id
            ),
            (
                SELECT MIN(test_date) 
                FROM covid_tests 
                WHERE patient_id = ct.patient_id 
                  AND result = 'Positive' 
                GROUP BY patient_id
            )
        ) AS recovery_time
    FROM covid_tests AS ct
)
SELECT 
    c.patient_id,
    p.patient_name,
    p.age,
    c.recovery_time
FROM 
    (SELECT * FROM CTE WHERE recovery_time IS NOT NULL) AS c
LEFT JOIN 
    patients AS p 
    ON c.patient_id = p.patient_id
ORDER BY 
    recovery_time ASC,
    patient_name ASC;

-- Intuition:
-- Identify the first Positive test date and the first Negative test date after that for each patient.
-- Calculate the difference in days to determine recovery_time.
-- Only consider patients who have both a Positive and a subsequent Negative test.

-- Explanation:
-- - The first CTE computes recovery_time using nested SELECTs to find the earliest Positive and subsequent Negative test dates.
-- - DISTINCT ensures each patient is counted once.
-- - The outer query filters out NULL recovery_time values and joins with the patients table for patient details.
-- - Results are ordered by recovery_time ascending and then patient_name for tie-breaking.
