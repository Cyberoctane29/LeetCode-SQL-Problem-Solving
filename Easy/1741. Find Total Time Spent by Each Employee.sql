-- Problem 1741: Find Total Time Spent by Each Employee
-- Difficulty: Easy

-- SQL Schema
-- Table: Employees
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | emp_id      | int  |
-- | event_day   | date |
-- | in_time     | int  |
-- | out_time    | int  |
-- +-------------+------+
-- (emp_id, event_day, in_time) is the primary key (combinations of columns with unique values) of this table.
-- The table shows the employees' entries and exits in an office.
-- event_day is the day at which this event happened, in_time is the minute at which the employee entered the office, and out_time is the minute at which they left the office.
-- in_time and out_time are between 1 and 1440.
-- It is guaranteed that no two events on the same day intersect in time, and in_time < out_time.

-- Problem Statement
-- Write a solution to calculate the total time in minutes spent by each employee on each day at the office.
-- Note that within one day, an employee can enter and leave more than once. The time spent in the office for a single entry is out_time - in_time.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    event_day AS day, 
    emp_id, 
    SUM(out_time - in_time) AS total_time 
FROM 
    Employees 
GROUP BY 
    emp_id, 
    event_day;

-- Intuition:
-- To calculate the total time spent by each employee on each day, we need to compute the difference between `out_time` and `in_time` for each entry.
-- Summing up these differences for each employee per day will give us the total time spent in the office.

-- Explanation:
-- The query calculates the time spent in the office by each employee by subtracting `in_time` from `out_time` for each entry.
-- It then sums these time intervals for each `emp_id` and `event_day`.
-- The results are grouped by `emp_id` and `event_day` to provide the total time spent by each employee on each day.
