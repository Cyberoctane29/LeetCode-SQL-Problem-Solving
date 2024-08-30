-- Problem 620: Not Boring Movies
-- Difficulty: Easy

-- SQL Schema
-- Table: Cinema
-- +----------------+----------+
-- | Column Name    | Type     |
-- +----------------+----------+
-- | id             | int      |
-- | movie          | varchar  |
-- | description    | varchar  |
-- | rating         | float    |
-- +----------------+----------+
-- id is the primary key (column with unique values) for this table.
-- Each row contains information about the name of a movie, its genre, and its rating.
-- rating is a 2 decimal places float in the range [0, 10]

-- Problem Statement
-- Report the movies with an odd-numbered ID and a description that is not "boring".
-- Return the result table ordered by rating in descending order.

-- Solution 1:
-- Using the MOD() function to filter for odd IDs and checking the description.
-- This query will return movies where the ID is odd and the description is not "boring".
-- The results are then ordered by rating in descending order.

SELECT * 
FROM Cinema 
WHERE MOD(id, 2) != 0 
AND description <> 'boring' 
ORDER BY rating DESC;

-- Intuition:
-- The `MOD()` function is used to determine if the ID is odd by checking if `id % 2` is not equal to 0.
-- The `description <> 'boring'` condition filters out movies with the description "boring".
-- The `ORDER BY` clause sorts the remaining movies by their rating in descending order.

-- Explanation:
-- This query filters the `Cinema` table to include only rows where the movie ID is odd and the description does not match "boring".
-- The `ORDER BY` clause ensures that the resulting movies are sorted by their rating from highest to lowest.

-- Solution 2:
-- Alternative syntax using `%` operator for modulo operation, which is functionally equivalent to `MOD()`.
-- This query also filters for odd IDs and non-boring descriptions, then orders by rating.

SELECT * 
FROM Cinema 
WHERE id % 2 = 1 
AND description != 'boring' 
ORDER BY rating DESC;

-- Intuition:
-- Here, `id % 2 = 1` is used to check if the ID is odd.
-- The `description != 'boring'` condition ensures only movies with descriptions other than "boring" are included.
-- The `ORDER BY` clause arranges the results by rating in descending order.

-- Explanation:
-- This query achieves the same result as the previous one but uses `%` instead of `MOD()` to filter odd-numbered IDs.
-- The description and rating conditions are handled similarly, ensuring that the movies are properly filtered and sorted.
