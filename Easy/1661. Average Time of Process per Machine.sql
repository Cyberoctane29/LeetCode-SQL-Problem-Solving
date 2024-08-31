-- Problem 1661: Average Time of Process per Machine
-- Difficulty: Easy

-- SQL Schema
-- Table: Activity
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | machine_id     | int     |
-- | process_id     | int     |
-- | activity_type  | enum    |
-- | timestamp      | float   |
-- +----------------+---------+
-- (machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
-- machine_id is the ID of a machine.
-- process_id is the ID of a process running on the machine with ID machine_id.
-- activity_type is an ENUM (category) of type ('start', 'end').
-- timestamp is a float representing the current time in seconds.
-- 'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
-- The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.

-- Problem Statement
-- Write a solution to find the average time each machine takes to complete a process.
-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp.
-- The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    a.machine_id,
    ROUND(
        (
            (SELECT AVG(a1.timestamp) 
             FROM Activity a1 
             WHERE a1.activity_type = 'end' 
             AND a1.machine_id = a.machine_id) 
            - 
            (SELECT AVG(a1.timestamp) 
             FROM Activity a1 
             WHERE a1.activity_type = 'start' 
             AND a1.machine_id = a.machine_id)
        ), 3) AS processing_time
FROM 
    Activity a
GROUP BY 
    a.machine_id;

-- Intuition:
-- To calculate the average processing time for each machine, we need to find the difference between the average 'end' timestamps and the average 'start' timestamps for each machine.
-- This gives us the average time taken to complete a process per machine.

-- Explanation:
-- For each machine, we calculate the average 'end' timestamp and subtract the average 'start' timestamp to get the average processing time.
-- We use the `ROUND` function to round the result to three decimal places.
-- The results are grouped by `machine_id` to get the average processing time for each machine.
