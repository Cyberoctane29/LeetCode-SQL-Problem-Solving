-- Problem 1148: Article Views I
-- Difficulty: Easy

-- SQL Schema
-- Table: Views
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | article_id    | int     |
-- | author_id     | int     |
-- | viewer_id     | int     |
-- | view_date     | date    |
-- +---------------+---------+
-- There is no primary key (column with unique values) for this table, the table may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
-- Note that equal author_id and viewer_id indicate the same person.

-- Problem Statement
-- Write a solution to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.

-- Solution:
-- The query selects distinct author IDs where the author viewed their own article.

SELECT 
    DISTINCT author_id AS id
FROM 
    Views
WHERE 
    author_id = viewer_id
ORDER BY 
    id;

-- Explanation:
-- The `DISTINCT` keyword ensures that each author ID appears only once in the result set.
-- The `WHERE` clause filters the records to only those where the author_id matches the viewer_id, indicating the author viewed their own article.
-- The `ORDER BY id` clause sorts the result by author_id in ascending order.
