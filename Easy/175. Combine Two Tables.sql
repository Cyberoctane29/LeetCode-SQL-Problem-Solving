-- Problem: Combine Two Tables
-- Difficulty: Easy

-- SQL Schema:
-- Table: Person
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | personId    | int     |
-- | lastName    | varchar |
-- | firstName   | varchar |
-- +-------------+---------+
-- personId is the primary key for this table.
-- This table contains information about the ID of some persons and their first and last names.

-- Table: Address
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | addressId   | int     |
-- | personId    | int     |
-- | city        | varchar |
-- | state       | varchar |
-- +-------------+---------+
-- addressId is the primary key for this table.
-- Each row of this table contains information about the city and state of one person with ID = personId.

-- Problem Statement:
-- Write a solution to report the first name, last name, city, and state of each person in the Person table.
-- If the address of a personId is not present in the Address table, report null instead.

-- Solution:

SELECT p.firstName, p.lastName, a.city, a.state
FROM Person AS p
LEFT JOIN Address AS a ON p.personId = a.personId;

-- Explanation:
-- This query performs a LEFT JOIN between the Person table and the Address table on the personId column.
-- It ensures that all records from the Person table are included in the result.
-- If there is no matching address for a personId in the Address table, NULL values are returned for city and state.
