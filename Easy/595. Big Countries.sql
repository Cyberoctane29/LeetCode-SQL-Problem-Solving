-- Problem 595: Big Countries
-- Difficulty: Easy

-- SQL Schema
-- Table: World
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | name        | varchar |
-- | continent   | varchar |
-- | area        | int     |
-- | population  | int     |
-- | gdp         | bigint  |
-- +-------------+---------+
-- name is the primary key (column with unique values) for this table.
-- Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.

-- Problem Statement
-- A country is considered big if:
-- 1. It has an area of at least three million (i.e., 3000000 km2), or
-- 2. It has a population of at least twenty-five million (i.e., 25000000).
-- Write a solution to find the name, population, and area of the big countries.

-- SQL Solution
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;

-- Intuition:
-- To identify big countries, we need to filter the countries based on two conditions: 
-- either their area should be at least 3 million km², or their population should be at least 25 million.
-- The SQL query uses these conditions in the `WHERE` clause to select the appropriate countries.

-- Explanation:
-- The `SELECT` statement retrieves the `name`, `population`, and `area` of countries from the World table.
-- The `WHERE` clause filters the results to include only those countries that meet at least one of the criteria:
-- 1. `area >= 3000000` checks if the country’s area is 3 million km² or more.
-- 2. `population >= 25000000` checks if the country’s population is 25 million or more.
-- The result includes all countries that satisfy either of these conditions.
