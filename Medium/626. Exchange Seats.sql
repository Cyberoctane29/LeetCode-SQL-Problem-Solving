-- Problem 626: Exchange Seats
-- Difficulty: Medium

-- SQL Schema
-- Table: Seat
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key (unique value) column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- The ID sequence always starts from 1 and increments continuously.

-- Problem Statement
-- Write a solution to swap the seat id of every two consecutive students.
-- If the number of students is odd, the id of the last student is not swapped.
-- Return the result table ordered by id in ascending order.

-- SQL Solution
WITH NumberedSeats AS (
    SELECT 
        id, 
        student, 
        ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM 
        Seat
)
SELECT 
    CASE 
        WHEN rn % 2 = 1 AND rn + 1 <= (SELECT COUNT(*) FROM Seat) THEN rn + 1
        WHEN rn % 2 = 0 THEN rn - 1
        ELSE rn
    END AS id,
    student
FROM 
    NumberedSeats
ORDER BY 
    id;

-- Intuition:
-- To swap the IDs of every two consecutive students, we first need to assign a row number to each student.
-- We then use the row number to determine the new ID for each student based on whether their current row number is odd or even.
-- If the row number is odd and there is a next student (i.e., an even row number), swap with the next student.
-- If the row number is even, it means it is a result of a swap, so it should be swapped back to the original odd number.

-- Explanation:
-- 1. The `NumberedSeats` CTE (Common Table Expression) assigns a row number (`rn`) to each student based on their ID.
-- 2. The `CASE` statement in the `SELECT` clause determines the new ID for each student:
--    - If `rn` is odd and there is a next row (`rn + 1`), swap with the next student by assigning `rn + 1` as the new ID.
--    - If `rn` is even, swap back with the previous odd row number (`rn - 1`).
--    - If `rn` is the last odd row number (with no next student), keep the original `rn`.
-- 3. The final result is ordered by the new `id` to ensure the output is in ascending order.
