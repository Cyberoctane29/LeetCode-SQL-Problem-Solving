-- Problem 602: Friend Requests II: Who Has the Most Friends
-- Difficulty: Medium

-- SQL Schema
-- Table: RequestAccepted
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
-- This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.

-- Problem Statement
-- Write a solution to find the people who have the most friends and the most friends number.
-- The test cases are generated so that only one person has the most friends.

-- SQL Solution 1: Using UNION ALL to combine requester and accepter IDs
WITH Combined AS (
    SELECT requester_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS requester_id FROM RequestAccepted
),
Filt AS (
    SELECT 
        requester_id,
        COUNT(*) AS num
    FROM 
        Combined
    GROUP BY 
        requester_id
)
SELECT requester_id AS id, num 
FROM Filt 
WHERE num = (SELECT MAX(num) FROM Filt);

-- Intuition:
-- To find the person with the most friends, we need to count each user's occurrences as both requester and accepter.
-- We combine these occurrences into a single list and then count the number of times each user appears.
-- Finally, we select the user with the maximum count.

-- Explanation:
-- 1. The `Combined` CTE consolidates all friend relationships into a single list by using `UNION ALL` to include both `requester_id` and `accepter_id`.
-- 2. The `Filt` CTE groups the combined list by `requester_id` and counts the number of occurrences for each user, which represents their total number of friends.
-- 3. We then select the user with the maximum number of friends by comparing each user's count to the highest count found in the `Filt` CTE.

-- SQL Solution 2: Using explicit joins and subqueries
WITH RI AS (
    SELECT requester_id FROM RequestAccepted
),
AI AS (
    SELECT accepter_id AS requester_id FROM RequestAccepted
),
Filt AS (
    SELECT 
        requester_id,
        (SELECT COUNT(requester_id) FROM RI WHERE requester_id = F.requester_id) +
        (SELECT COUNT(requester_id) FROM AI WHERE requester_id = F.requester_id) AS num
    FROM 
        (SELECT DISTINCT requester_id FROM RequestAccepted) AS F
)
SELECT requester_id AS id, num 
FROM Filt 
WHERE num = (SELECT MAX(num) FROM Filt);

-- Intuition:
-- This solution separately counts requester and accepter occurrences and then combines these counts to determine the total number of friends for each user.
-- We use subqueries to count occurrences for each `requester_id` in both the `RI` and `AI` CTEs.

-- Explanation:
-- 1. The `RI` CTE collects all `requester_id`s from the `RequestAccepted` table.
-- 2. The `AI` CTE collects all `accepter_id`s, renaming them as `requester_id` to match.
-- 3. The `Filt` CTE calculates the total number of friends for each user by adding counts from `RI` and `AI`.
-- 4. We select the user with the maximum number of friends by comparing each user's total count to the highest count found in the `Filt` CTE.

-- Note: Solution 1 is typically more efficient and straightforward, while Solution 2 uses multiple subqueries which may be less efficient in practice.
