-- Problem 1341: Movie Rating
-- Difficulty: Medium

-- SQL Schema
-- Table: Movies
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | title         | varchar |
-- +---------------+---------+
-- movie_id is the primary key (column with unique values) for this table.
-- title is the name of the movie.

-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | name          | varchar |
-- +---------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- The column 'name' has unique values.

-- Table: MovieRating
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | user_id       | int     |
-- | rating        | int     |
-- | created_at    | date    |
-- +---------------+---------+
-- (movie_id, user_id) is the primary key (column with unique values) for this table.
-- This table contains the rating of a movie by a user in their review.
-- created_at is the user's review date.

-- Problem Statement
-- 1. Find the name of the user who has rated the greatest number of movies.
--    In case of a tie, return the lexicographically smaller user name.
-- 2. Find the movie name with the highest average rating in February 2020.
--    In case of a tie, return the lexicographically smaller movie name.

-- SQL Solution
WITH CTE1 AS (
    SELECT u.name, COUNT(mr.movie_id) AS cnt 
    FROM MovieRating AS mr
    INNER JOIN Users AS u ON mr.user_id = u.user_id 
    GROUP BY u.name
    ORDER BY cnt DESC, u.name ASC
    LIMIT 1
),
CTE2 AS (
    SELECT m.title, AVG(mr.rating) AS avg_rating
    FROM MovieRating AS mr
    INNER JOIN Movies AS m ON mr.movie_id = m.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.title
    ORDER BY avg_rating DESC, m.title ASC
    LIMIT 1
)
SELECT name AS Results FROM CTE1
UNION ALL
SELECT title FROM CTE2;

-- Intuition:
-- To solve the problem, we need to identify two pieces of information:
-- 1. The user who has rated the most movies.
-- 2. The movie with the highest average rating in a specific month (February 2020).

-- Explanation:
-- CTE1: Counts the number of movies rated by each user and selects the user with the highest count. In case of a tie, the lexicographically smaller name is selected.
-- CTE2: Calculates the average rating for each movie in February 2020 and selects the movie with the highest average rating. In case of a tie, the lexicographically smaller movie title is selected.
-- The `UNION ALL` operator combines the results from both queries.
