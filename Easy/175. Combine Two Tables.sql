-- Problem 175: Combine Two Tables
-- Difficulty: Easy

-- SQL Schema
-- Table: Person
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | personId    | int     |
-- | lastName    | varchar |
-- | firstName   | varchar |
-- +-------------+---------+
-- personId is the primary key (column with unique values) for this table.
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
-- addressId is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the city and state of one person with ID = PersonId.

-- Problem Statement
-- Write a solution to report the first name, last name, city, and state of each person in the Person table. 
-- If the address of a personId is not present in the Address table, report null instead.

-- SQL Solution
SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;

-- Intuition:
-- To get a complete list of persons along with their addresses, we need to join the Person table with the Address table.
-- Since we want to include all persons even if they don't have an address, we use a LEFT JOIN.
-- The LEFT JOIN will ensure that every person is listed regardless of whether there is a corresponding address.
-- If there is no matching address for a person, the city and state will be NULL.

-- Explanation:
-- The LEFT JOIN operation combines rows from the Person table with rows from the Address table based on the personId.
-- If a personId in the Person table matches a personId in the Address table, the corresponding city and state are included in the result.
-- If there is no match, the city and state fields will be NULL.
