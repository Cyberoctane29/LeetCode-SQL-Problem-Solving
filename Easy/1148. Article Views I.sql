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
-- There is no primary key for this table, meaning it may have duplicate rows.
-- Each row in this table indicates that some viewer viewed an article (written by some author) on a particular date.
-- Note that if author_id and viewer_id are equal, it means the author viewed their own article.

-- Problem Statement
-- Write a solution to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.

-- SQL Solution
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;

-- Intuition:
-- To find authors who have viewed their own articles, we need to look for rows where the author_id is equal to the viewer_id.
-- The DISTINCT keyword ensures that each author_id is returned only once, even if an author has viewed multiple articles.

-- Explanation:
-- This query selects the author_id from the Views table where the author_id matches the viewer_id, indicating the author viewed their own article.
-- The DISTINCT keyword removes duplicates, ensuring that each author appears only once in the result.
-- Finally, the results are ordered by the author_id (alias as id) in ascending order.
