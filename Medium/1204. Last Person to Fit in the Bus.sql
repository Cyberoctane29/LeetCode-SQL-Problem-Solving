-- Problem 1204: Last Person to Fit in the Bus
-- Difficulty: Medium

-- SQL Schema
-- Table: Queue
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | person_id   | int     |
-- | person_name | varchar |
-- | weight      | int     |
-- | turn        | int     |
-- +-------------+---------+
-- person_id column contains unique values.
-- The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
-- turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
-- weight is the weight of the person in kilograms.

-- Problem Statement
-- Find the person_name of the last person that can fit on the bus without exceeding the weight limit of 1000 kilograms.
-- The test cases are generated such that the first person does not exceed the weight limit.

-- SQL Solution
SELECT 
    q1.person_name
FROM 
    Queue AS q1
JOIN 
    Queue AS q2
    ON q1.turn >= q2.turn
GROUP BY 
    q1.turn
HAVING 
    SUM(q2.weight) <= 1000
ORDER BY 
    q1.turn DESC
LIMIT 1;

-- Intuition:
-- To find the last person who can fit on the bus without exceeding the weight limit, you need to check the cumulative weight for each person boarding and determine the last person who still fits within the limit.

-- Explanation:
-- 1. **Joining the Table**:
--    - Join the `Queue` table with itself using `q1.turn >= q2.turn`. This effectively allows you to compute the cumulative weight of people from the start of the queue up to each person `q1`.
-- 2. **Grouping**:
--    - Group the results by `q1.turn` to get the cumulative weight up to each person.
-- 3. **Filtering**:
--    - Use `HAVING SUM(q2.weight) <= 1000` to filter out the groups where the cumulative weight exceeds the limit.
-- 4. **Ordering and Limiting**:
--    - Order the results by `q1.turn DESC` to prioritize the last person who fits within the weight limit.
--    - Use `LIMIT 1` to select only the last person.

-- This solution ensures that you get the name of the last person who can fit on the bus before the weight limit is exceeded.