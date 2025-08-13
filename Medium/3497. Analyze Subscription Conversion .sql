-- Problem 3497: Analyze Subscription Conversion
-- Difficulty: Medium

-- Table: UserActivity
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | user_id          | int     |
-- | activity_date    | date    |
-- | activity_type    | varchar |
-- | activity_duration| int     |
-- +------------------+---------+
-- (user_id, activity_date, activity_type) is the unique key for this table.
-- activity_type is one of ('free_trial', 'paid', 'cancelled').
-- activity_duration is the number of minutes the user spent on the platform that day.
-- Each row represents a user's activity on a specific date.

-- Problem Statement:
-- The company offers a 7-day free trial after which users may subscribe to a paid plan or cancel.
-- Find:
-- 1. Users who converted from free trial to paid subscription.
-- 2. Each user's average daily activity duration during their free trial (rounded to 2 decimal places).
-- 3. Each user's average daily activity duration during their paid subscription (rounded to 2 decimal places).
-- Return results ordered by user_id ascending.

-- Solution:

SELECT 
    user_id,
    ROUND(
        SUM(CASE WHEN activity_type = 'free_trial' THEN activity_duration ELSE 0 END) /
        NULLIF(SUM(CASE WHEN activity_type = 'free_trial' THEN 1 ELSE 0 END), 0)
    , 2) AS trial_avg_duration,
    ROUND(
        SUM(CASE WHEN activity_type = 'paid' THEN activity_duration ELSE 0 END) /
        NULLIF(SUM(CASE WHEN activity_type = 'paid' THEN 1 ELSE 0 END), 0)
    , 2) AS paid_avg_duration
FROM 
    useractivity
GROUP BY 
    user_id
HAVING 
    trial_avg_duration IS NOT NULL 
    AND paid_avg_duration IS NOT NULL
ORDER BY 
    user_id;

-- Intuition:
-- We need only users who had both free_trial and paid activities, so we filter them using HAVING on computed averages.
-- We calculate averages separately for trial and paid periods.

-- Explanation:
-- - The SUM(CASE WHEN ...) isolates total minutes spent during each activity type.
-- - The COUNT for each type is simulated by summing 1 for each matching row.
-- - NULLIF prevents division by zero for users who lack one of the activity types.
-- - HAVING ensures only users with both free_trial and paid averages appear in results.
-- - Rounding to 2 decimal places ensures clean reporting.
