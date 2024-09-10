-- Problem 1934: Confirmation Rate
-- Difficulty: Medium

-- SQL Schema
-- Table: Signups
-- +----------------+----------+
-- | Column Name    | Type     |
-- +----------------+----------+
-- | user_id        | int      |
-- | time_stamp     | datetime |
-- +----------------+----------+
-- user_id is the column of unique values for this table.
-- Each row contains information about the signup time for the user with ID user_id.

-- Table: Confirmations
-- +----------------+----------+
-- | Column Name    | Type     |
-- +----------------+----------+
-- | user_id        | int      |
-- | time_stamp     | datetime |
-- | action         | ENUM     |
-- +----------------+----------+
-- (user_id, time_stamp) is the primary key.
-- user_id is a foreign key to the Signups table.
-- action is an ENUM of type ('confirmed', 'timeout').
-- Each row indicates the user requested a confirmation message, and the message was either confirmed or timed out.

-- Problem Statement
-- Write a solution to find the confirmation rate of each user.
-- The confirmation rate is the number of 'confirmed' messages divided by the total number of requested confirmation messages.
-- If a user did not request any confirmation messages, the confirmation rate is 0.
-- The result should round the confirmation rate to two decimal places.

-- SQL Solution
SELECT 
    s.user_id,
    COALESCE(ROUND(cs.confirmed_count / cs.total_requests, 2), 0) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN (
    SELECT 
        user_id,
        SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS confirmed_count,
        COUNT(*) AS total_requests
    FROM 
        Confirmations
    GROUP BY 
        user_id
) cs ON s.user_id = cs.user_id;

-- Intuition:
-- To determine the confirmation rate for each user, we need to calculate the ratio of confirmed messages to total confirmation requests.
-- Here's the step-by-step approach:
-- 1. **Categorize Confirmation Actions:** First, we need to categorize each confirmation request as either 'confirmed' or 'timeout'. We will count the number of 'confirmed' messages and total confirmation requests for each user.
-- 2. **Handle Users with No Requests:** We also need to consider users who haven't made any confirmation requests. For these users, the confirmation rate should be 0.
-- 3. **Join and Calculate Rate:** We use a `LEFT JOIN` to combine the `Signups` table with our calculated confirmation data. This ensures we include all users from the `Signups` table, even if they haven't made any requests.
-- 4. **Calculate Confirmation Rate:** We compute the confirmation rate by dividing the count of 'confirmed' messages by the total number of requests. We round this result to two decimal places.
-- 5. **Handle Null Values:** We use `COALESCE` to handle cases where a user made no confirmation requests, ensuring their confirmation rate is recorded as 0.

-- Explanation:
-- 1. We first perform a LEFT JOIN between the `Signups` table and a subquery that calculates the confirmation data from the `Confirmations` table.
--    The `LEFT JOIN` ensures that all users from the `Signups` table are included, even if they haven't requested any confirmations.

-- 2. In the subquery, we calculate two things for each user:
--    a. `confirmed_count`: This is the count of confirmations where the action was 'confirmed'. We use a `SUM(CASE WHEN ...)` statement to achieve this.
--    b. `total_requests`: This is the total number of confirmation requests made by the user. We use `COUNT(*)` to count all rows, regardless of the action.

-- 3. After performing the join, we calculate the `confirmation_rate` by dividing `confirmed_count` by `total_requests`, rounding the result to two decimal places using `ROUND()`.
--    - We use `COALESCE()` to handle cases where a user did not request any confirmations (i.e., `cs.total_requests` is NULL). In such cases, the `confirmation_rate` is set to 0.

-- 4. The result is returned in any order, as specified in the problem.

