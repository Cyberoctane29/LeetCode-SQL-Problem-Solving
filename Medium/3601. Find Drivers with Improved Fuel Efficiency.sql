-- Problem 3601: Find Drivers with Improved Fuel Efficiency
-- Difficulty: Medium

-- Table: drivers
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | driver_id   | int     |
-- | driver_name | varchar |
-- +-------------+---------+
-- driver_id is the unique identifier for this table.
-- Each row contains information about a driver.

-- Table: trips
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | trip_id       | int     |
-- | driver_id     | int     |
-- | trip_date     | date    |
-- | distance_km   | decimal |
-- | fuel_consumed | decimal |
-- +---------------+---------+
-- trip_id is the unique identifier for this table.
-- Each row represents a trip made by a driver, including distance traveled and fuel consumed.

-- Problem Statement:
-- Find drivers whose fuel efficiency improved by comparing their average fuel efficiency 
-- in the first half of the year (Jan–Jun) with the second half (Jul–Dec).
-- - Fuel efficiency = distance_km / fuel_consumed
-- - Only include drivers who have trips in both halves.
-- - Calculate efficiency_improvement = (second_half_avg - first_half_avg).
-- - Round all results to 2 decimal places.
-- - Return results ordered by efficiency_improvement descending, then driver_name ascending.

-- Solution:

WITH CTE AS (
    SELECT 
        driver_id,
        trip_date,
        distance_km,
        fuel_consumed
    FROM trips 
    WHERE driver_id IN (
        SELECT driver_id 
        FROM trips 
        GROUP BY driver_id 
        HAVING MIN(MONTH(trip_date)) IN (1,2,3,4,5,6) 
           AND MAX(MONTH(trip_date)) IN (7,8,9,10,11,12)
    )
),
CTE1 AS (
    SELECT 
        driver_id,
        trip_date,
        distance_km,
        fuel_consumed,
        (distance_km / fuel_consumed) AS fuel_efficiency
    FROM CTE
),
CTE2 AS (
    SELECT 
        driver_id,
        AVG(
            IF(MONTH(trip_date) IN (1,2,3,4,5,6), fuel_efficiency, NULL)
        ) AS first_half_avg,
        AVG(
            IF(MONTH(trip_date) IN (7,8,9,10,11,12), fuel_efficiency, NULL)
        ) AS second_half_avg
    FROM CTE1 
    GROUP BY driver_id
),
CTE3 AS (
    SELECT *,
           (second_half_avg - first_half_avg) AS efficiency_improvement
    FROM CTE2
)
SELECT 
    c3.driver_id,
    d.driver_name,
    ROUND(c3.first_half_avg, 2) AS first_half_avg,
    ROUND(c3.second_half_avg, 2) AS second_half_avg,
    ROUND(c3.efficiency_improvement, 2) AS efficiency_improvement
FROM CTE3 AS c3
LEFT JOIN drivers AS d 
    ON c3.driver_id = d.driver_id
WHERE efficiency_improvement > 0
ORDER BY efficiency_improvement DESC, driver_name ASC;

-- Intuition:
-- For each driver, compute their trip-level fuel efficiency. 
-- Split trips into first half (Jan–Jun) and second half (Jul–Dec). 
-- Compare the averages across halves to check for improvement. 
-- Only include drivers with data in both halves.

-- Explanation:
-- - CTE filters to drivers who have trips in both halves of the year.
-- - CTE1 calculates fuel efficiency per trip.
-- - CTE2 aggregates average efficiency separately for first and second halves.
-- - CTE3 computes improvement as (second_half_avg - first_half_avg).
-- - The final SELECT joins with drivers table for names, 
--   rounds the results to 2 decimals, and filters to only improvements.
-- - Output is ordered by greatest improvement first, then alphabetically by driver name.