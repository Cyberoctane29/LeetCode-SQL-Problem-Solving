-- Problem 197: Rising Temperature
-- Difficulty: Easy

-- SQL Schema
-- Table: Weather
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | recordDate    | date    |
-- | temperature   | int     |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- There are no different rows with the same recordDate.
-- This table contains information about the temperature on a certain day.

-- Problem Statement
-- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

-- Solution 1: Using LAG() function
WITH prev_temp AS (
    SELECT 
        id, 
        recordDate, 
        temperature, 
        LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp 
    FROM 
        Weather
)
SELECT 
    id 
FROM 
    prev_temp 
WHERE 
    temperature > prev_temp;

-- Intuition:
-- The LAG() function allows us to access the temperature of the previous day in the result set.
-- By comparing the current day’s temperature with the previous day's temperature, we can identify days with rising temperatures.

-- Explanation:
-- The CTE `prev_temp` calculates the temperature of the previous day using `LAG()`, partitioned by recordDate.
-- We then select the ids where the current day's temperature is higher than the previous day's temperature.

-- Solution 2: Using self-join with DATEDIFF()
SELECT w2.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
AND w2.temperature > w1.temperature;

-- Intuition:
-- By joining the Weather table with itself, we can compare each day’s temperature with the temperature of the previous day.
-- The `DATEDIFF()` function helps to find records that are exactly one day apart.

-- Explanation:
-- This query joins the Weather table with itself where the difference in recordDate is exactly one day (i.e., the current recordDate is one day after the previous recordDate).
-- It selects the ids where the temperature of the current day (w2) is greater than the temperature of the previous day (w1).

-- Solution 3: Alternative self-join with DATEDIFF() (your provided query)
SELECT w2.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = -1
AND w2.temperature > w1.temperature;

-- Intuition:
-- This approach also uses a self-join to compare temperatures between consecutive days.
-- It specifically checks for records where the difference in `recordDate` is -1, indicating that `w2.recordDate` is one day after `w1.recordDate`.

-- Explanation:
-- The query joins the Weather table with itself based on the condition that the difference in recordDate is -1 (i.e., w2.recordDate is one day after w1.recordDate).
-- It selects ids where the temperature on w2 (the current day) is higher than on w1 (the previous day).
