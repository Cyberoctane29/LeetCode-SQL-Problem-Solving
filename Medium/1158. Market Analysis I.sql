-- Problem 1158: Market Analysis I
-- Difficulty: Medium

-- SQL Schema
-- Table: Users
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | user_id        | int     |
-- | join_date      | date    |
-- | favorite_brand | varchar |
-- +----------------+---------+
-- user_id is the primary key (column with unique values) of this table.
-- This table has the info of the users of an online shopping website where users can sell and buy items.

-- Table: Orders
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | order_id      | int     |
-- | order_date    | date    |
-- | item_id       | int     |
-- | buyer_id      | int     |
-- | seller_id     | int     |
-- +---------------+---------+
-- order_id is the primary key (column with unique values) of this table.
-- item_id is a foreign key (reference column) to the Items table.
-- buyer_id and seller_id are foreign keys to the Users table.

-- Table: Items
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | item_id       | int     |
-- | item_brand    | varchar |
-- +---------------+---------+
-- item_id is the primary key (column with unique values) of this table.

-- Problem Statement
-- Write a solution to find for each user, the join date and the number of orders they made as a buyer in 2019.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    u.user_id AS buyer_id,
    u.join_date,
    IFNULL(COUNT(o.order_date), 0) AS orders_in_2019
FROM 
    Users u
LEFT JOIN 
    Orders o ON u.user_id = o.buyer_id 
    AND YEAR(o.order_date) = 2019
GROUP BY 
    u.user_id;

-- Intuition:
-- To find the number of orders each user made as a buyer in 2019, we need to count the orders for each user within that year. We also need to include users who did not make any orders in 2019.

-- Explanation:
-- 1. We perform a `LEFT JOIN` between the `Users` table and the `Orders` table based on the `user_id` and `buyer_id`.
-- 2. The join condition includes a filter to only consider orders from the year 2019 (`YEAR(order_date) = 2019`).
-- 3. We use `IFNULL(COUNT(o.order_date), 0)` to count the number of orders each user made as a buyer in 2019. If a user did not make any orders, `COUNT` will return `NULL`, so `IFNULL` converts it to 0.
-- 4. We group the results by `u.user_id` to aggregate the count of orders for each user.
-- 5. The result includes each user's ID, join date, and the number of orders they made as a buyer in 2019.
