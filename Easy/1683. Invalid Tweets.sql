-- Problem 1683: Invalid Tweets
-- Difficulty: Easy

-- SQL Schema
-- Table: Tweets
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | tweet_id       | int     |
-- | content        | varchar |
-- +----------------+---------+
-- tweet_id is the primary key (column with unique values) for this table.
-- This table contains all the tweets in a social media app.

-- Problem Statement
-- Write a solution to find the IDs of the invalid tweets. 
-- The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    tweet_id
FROM 
    Tweets
WHERE 
    CHAR_LENGTH(content) > 15;

-- Intuition:
-- To identify invalid tweets, we need to check the length of the content of each tweet.
-- The `CHAR_LENGTH` function is used to get the number of characters in the content.
-- Tweets with a content length greater than 15 characters are considered invalid.

-- Explanation:
-- The query selects `tweet_id` from the `Tweets` table where the length of the `content` exceeds 15 characters.
-- This is achieved using the `CHAR_LENGTH` function in the `WHERE` clause to filter out invalid tweets.
