-- Problem 601: Human Traffic of Stadium
-- Difficulty: Hard

-- SQL Schema
-- Table: Stadium
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | visit_date    | date    |
-- | people        | int     |
-- +---------------+---------+
-- visit_date is the column with unique values for this table.
-- Each row contains the visit date and visit id of the stadium along with the number of people during that visit.
-- As the id increases, the date increases as well.

-- Problem Statement:
-- Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.
-- Return the result table ordered by visit_date in ascending order.

-- Solution:
SELECT id,
       visit_date,
       people
FROM  
(SELECT id,
        visit_date,
        people,
        LEAD(people,1)OVER(order by id) as nxt,
        LEAD(people,2)OVER(order by id) as nxt2,
        LAG(people,1)OVER(order by id) as pre,
        LAG(people,2)OVER(order by id) as pre2
 FROM stadium
) as CTE
WHERE (CTE.people >= 100 AND CTE.nxt >= 100 AND CTE.nxt2 >= 100)
OR (CTE.people >= 100 AND CTE.nxt >= 100 AND CTE.pre >= 100)
OR (CTE.people >= 100 AND CTE.pre >= 100 AND CTE.pre2 >= 100);

-- Intuition:
-- I need to identify three consecutive rows where the number of people in each row is 100 or more. 
-- I can use the window functions `LEAD()` and `LAG()` to look ahead and behind each row to check the number of people in the next two or previous two rows.

-- Explanation:
-- 1. I use the `LEAD()` function to get the number of people in the next row (`nxt`) and the row after that (`nxt2`).
-- 2. I use the `LAG()` function to get the number of people in the previous row (`pre`) and the row before that (`pre2`).
-- 3. The WHERE clause filters the rows where the current row and its neighboring rows (either ahead or behind) have a number of people greater than or equal to 100.
-- 4. I check three different cases:
--   - The current row and the next two rows have 100 or more people.
--   - The current row, the next row, and the previous row have 100 or more people.
--   - The current row and the previous two rows have 100 or more people.
-- 5. The final result is sorted by `visit_date` in ascending order to meet the problem's requirements.
