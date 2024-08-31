-- Problem 1527: Patients With a Condition
-- Difficulty: Easy

-- SQL Schema
-- Table: Patients
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | patient_id   | int     |
-- | patient_name | varchar |
-- | conditions   | varchar |
-- +--------------+---------+
-- patient_id is the primary key for this table.
-- 'conditions' contains 0 or more codes separated by spaces.
-- This table contains information about the patients in the hospital.

-- Problem Statement
-- Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes.
-- Type I Diabetes always starts with DIAB1 prefix.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    patient_id,
    patient_name,
    conditions
FROM 
    Patients
WHERE 
    conditions LIKE 'DIAB1%' 
    OR conditions LIKE '% DIAB1%';

-- Intuition:
-- To find patients with Type I Diabetes, we need to check if the 'conditions' field contains the prefix 'DIAB1'.
-- This is done by checking if 'DIAB1' appears at the start or in the middle of the 'conditions' string.

-- Explanation:
-- The `LIKE` operator is used to match the 'conditions' field against patterns.
-- 'DIAB1%' matches conditions where 'DIAB1' is at the start of the string.
-- '% DIAB1%' matches conditions where 'DIAB1' appears somewhere in the middle of the string, prefixed by a space.
-- This ensures that all patients with Type I Diabetes are included in the result.
