-- Problem 550: Game Play Analysis IV
-- Difficulty: Medium

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
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.

-- Problem Statement
-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.
-- In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date,
-- then divide that number by the total number of players.

-- SQL Solution 1
SELECT 
    ROUND(COUNT(player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM 
    Activity
WHERE 
    (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) IN (
        SELECT player_id, MIN(event_date) 
        FROM Activity 
        GROUP BY player_id
    );

-- Intuition:
-- We need to find players who logged in on the day after their first login. 
-- To do this, we first identify the first login date for each player.
-- Then, we check if the player logged in on the day following this first login date.
-- Finally, we calculate the fraction of such players relative to the total number of distinct players.

-- Explanation:
-- 1. The subquery `(SELECT player_id, MIN(event_date) FROM Activity GROUP BY player_id)` finds the earliest login date for each player.
-- 2. The main query checks if the player logged in on the day after their first login date using `DATE_SUB(event_date, INTERVAL 1 DAY)`.
-- 3. The `COUNT(player_id)` function counts the number of players who meet this condition.
-- 4. We divide this count by the total number of distinct players using `(SELECT COUNT(DISTINCT player_id) FROM Activity)`.
-- 5. The `ROUND()` function rounds the result to 2 decimal places.

-- SQL Solution 2 (Alternative with DISTINCT)
SELECT 
    ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM 
    Activity
WHERE 
    (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) IN (
        SELECT player_id, MIN(event_date) 
        FROM Activity 
        GROUP BY player_id
    );

-- Intuition:
-- This solution is similar to the first one but explicitly uses `COUNT(DISTINCT player_id)` to ensure we count each player only once.
-- It avoids counting duplicate entries if a player has multiple records on the same day.

-- Explanation:
-- 1. The subquery `(SELECT player_id, MIN(event_date) FROM Activity GROUP BY player_id)` identifies each player's first login date.
-- 2. The main query then filters records where the player logged in on the day after their first login date.
-- 3. `COUNT(DISTINCT player_id)` ensures that each player is counted only once.
-- 4. We compute the fraction by dividing this count by the total number of distinct players and rounding the result to 2 decimal places.

-- SQL Solution 3 (Simplified without DISTINCT)
SELECT 
    ROUND(COUNT(player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM 
    Activity
WHERE 
    (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) IN (
        SELECT player_id, MIN(event_date) 
        FROM Activity 
        GROUP BY player_id
    );

-- Intuition:
-- This solution assumes that each player can appear multiple times in the `Activity` table.
-- It uses a straightforward `COUNT(player_id)` to get the number of valid logins, potentially counting duplicate entries.

-- Explanation:
-- 1. The subquery determines the first login date for each player.
-- 2. The main query identifies players who logged in the day after their first login.
-- 3. `COUNT(player_id)` includes all matching records, which might count some players more than once if they have multiple entries.
-- 4. We calculate the fraction by dividing this count by the total number of distinct players and rounding the result to 2 decimal places.

-- Note: Solution 1 and Solution 2 ensure correct counting by considering each player only once. Solution 3 may overcount if players have multiple entries.
