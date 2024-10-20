-- Problem 262: Trips and Users
-- Difficulty: Hard

-- SQL Schema
-- Table: Trips
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | id          | int      |
-- | client_id   | int      |
-- | driver_id   | int      |
-- | city_id     | int      |
-- | status      | enum     |
-- | request_at  | varchar  |     
-- +-------------+----------+
-- id is the primary key for this table.
-- The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
-- Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').

-- Table: Users
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | users_id    | int      |
-- | banned      | enum     |
-- | role        | enum     |
-- +-------------+----------+
-- users_id is the primary key for this table.
-- The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
-- banned is an ENUM (category) type of ('Yes', 'No').

-- Problem Statement
-- The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.
-- Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03".
-- Round Cancellation Rate to two decimal points.
-- Return the result table in any order.

-- Solution:

WITH CTE AS (
    -- Filter trips with unbanned clients and drivers
    SELECT id, client_id, driver_id, request_at, status
    FROM Trips 
    WHERE client_id NOT IN (SELECT users_id FROM Users WHERE banned = 'Yes')
      AND driver_id NOT IN (SELECT users_id FROM Users WHERE banned = 'Yes')
),
CTE1 AS (
    -- Count the number of cancellations per day
    SELECT request_at, COUNT(*) AS cnt
    FROM CTE 
    WHERE status LIKE 'cancelled%'
    GROUP BY request_at
),
CTE2 AS (
    -- Count the total trips per day
    SELECT request_at, COUNT(*) AS cnt1
    FROM CTE
    GROUP BY request_at
)
SELECT 
    c2.request_at AS Day,
    ROUND(COALESCE(c1.cnt, 0) / NULLIF(c2.cnt1, 0), 2) AS "Cancellation Rate"
FROM 
    CTE2 c2
LEFT JOIN 
    CTE1 c1 ON c1.request_at = c2.request_at
WHERE 
    c2.request_at BETWEEN '2013-10-01' AND '2013-10-03'
ORDER BY 
    Day;

-- Intuition:
-- I aim to calculate the cancellation rate for trips, focusing specifically on unbanned clients and drivers.
-- To simplify the final calculation, two CTEs are used to aggregate counts of cancellations and total trips for each day.

-- Explanation:
-- 1. In the first CTE, trips are filtered to exclude those with banned clients or drivers, which creates a clean dataset of valid trips.
-- 2. The second CTE counts the number of canceled trips for each day by checking if the status starts with 'cancelled'.
-- 3. The third CTE counts the total number of trips per day.
-- 4. In the main query, the two CTEs are joined to calculate the cancellation rate by dividing the number of canceled trips by the total number of trips for each day.
-- 5. I use the `COALESCE` function to handle cases where there are no cancellations, ensuring that null values are avoided.
-- 6. The `NULLIF` function is used to prevent division by zero when there are no total trips.
-- 7. Finally, the result is ordered by the request date in ascending order to meet the problem requirements.

