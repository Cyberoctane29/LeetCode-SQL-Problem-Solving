-- Problem 585: Investments in 2016
-- Difficulty: Medium

-- SQL Schema
-- Table: Insurance
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | pid         | int   |
-- | tiv_2015    | float |
-- | tiv_2016    | float |
-- | lat         | float |
-- | lon         | float |
-- +-------------+-------+
-- pid is the primary key (column with unique values) for this table.
-- Each row of this table contains information about one policy where:
-- pid is the policyholder's policy ID.
-- tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
-- lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
-- lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.

-- Problem Statement
-- Write a solution to report the sum of all total investment values in 2016 (tiv_2016), for all policyholders who:
-- 1. Have the same tiv_2015 value as one or more other policyholders.
-- 2. Are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
-- Round tiv_2016 to two decimal places.

-- SQL Solution
SELECT 
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM 
    Insurance
WHERE 
    tiv_2015 IN (
        SELECT 
            tiv_2015 
        FROM 
            Insurance 
        GROUP BY 
            tiv_2015 
        HAVING 
            COUNT(*) > 1
    )
    AND (lat, lon) IN (
        SELECT 
            lat, lon 
        FROM 
            Insurance 
        GROUP BY 
            lat, lon 
        HAVING 
            COUNT(*) = 1
    );

-- Intuition:
-- We need to calculate the sum of `tiv_2016` values for policyholders who:
-- 1. Share their `tiv_2015` value with at least one other policyholder.
-- 2. Are located in a unique city (latitude and longitude pair is unique).
-- To achieve this, we use two subqueries to filter the required rows based on these criteria.

-- Explanation:
-- 1. The first subquery in the `WHERE` clause identifies all `tiv_2015` values that are shared by more than one policyholder.
--    - We group by `tiv_2015` and use `HAVING COUNT(*) > 1` to find these values.
-- 2. The second subquery filters policyholders based on unique `(lat, lon)` pairs.
--    - We group by `lat, lon` and use `HAVING COUNT(*) = 1` to find unique locations.
-- 3. We then use these results in the main query to filter the rows that meet both conditions.
-- 4. Finally, we sum the `tiv_2016` values of these filtered policyholders and round the result to two decimal places.

-- Note:
-- The `ROUND` function is used to ensure that the result is rounded to two decimal places as required.
