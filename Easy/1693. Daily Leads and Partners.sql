-- Problem 1693: Daily Leads and Partners
-- Difficulty: Easy

-- SQL Schema
-- Table: DailySales
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | date_id     | date    |
-- | make_name   | varchar |
-- | lead_id     | int     |
-- | partner_id  | int     |
-- +-------------+---------+
-- There is no primary key (column with unique values) for this table. It may contain duplicates.
-- This table contains the date and the name of the product sold and the IDs of the lead and partner it was sold to.
-- The name consists of only lowercase English letters.

-- Problem Statement
-- For each date_id and make_name, find the number of distinct lead_id's and distinct partner_id's.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    date_id,
    make_name,
    COUNT(DISTINCT lead_id) AS unique_leads,
    COUNT(DISTINCT partner_id) AS unique_partners
FROM 
    DailySales
GROUP BY 
    date_id, make_name;

-- Intuition:
-- To find the number of distinct leads and partners for each product on each date, 
-- we use the `COUNT(DISTINCT ...)` function to count unique values for `lead_id` and `partner_id`.
-- The results are grouped by `date_id` and `make_name` to get the counts per combination of these fields.

-- Explanation:
-- The query groups the data by `date_id` and `make_name`, then counts the distinct `lead_id` and `partner_id` within each group.
-- `COUNT(DISTINCT lead_id)` calculates the number of unique leads and `COUNT(DISTINCT partner_id)` calculates the number of unique partners.
