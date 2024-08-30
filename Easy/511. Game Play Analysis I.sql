-- Problem 511: Game Play Analysis I
-- Difficulty: Easy

-- SQL Schema
-- Table: Activity
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key (combination of columns with unique values) of this table.
-- This table shows the activity of players of some games.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

-- Problem Statement
-- Write a solution to find the first login date for each player.

-- Solution 1: Using MIN() function with GROUP BY
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

-- Intuition:
-- To find the first login date for each player, we need to determine the earliest date recorded for each player.
-- The MIN() function helps us find the minimum (earliest) event_date for each player.

-- Explanation:
-- The query groups the results by player_id and uses the MIN() function to find the earliest event_date for each player.
-- This effectively returns the first login date for each player.

-- Solution 2: Using ROW_NUMBER() function with CTE
WITH cte AS (
    SELECT 
        player_id,
        event_date,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn 
    FROM 
        Activity
)
SELECT 
    player_id, 
    event_date AS first_login
FROM 
    cte
WHERE 
    rn = 1;

-- Intuition:
-- By using the ROW_NUMBER() function, we can assign a unique rank to each record for a player based on the event_date.
-- The earliest login date will have a rank of 1, allowing us to select it directly.

-- Explanation:
-- The CTE `cte` assigns a row number to each record within the partition of player_id, ordered by event_date.
-- The outer query selects the records where the row number is 1, which corresponds to the earliest (first) login date for each player.
