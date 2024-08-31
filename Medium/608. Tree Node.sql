-- Problem 608: Tree Node
-- Difficulty: Medium

-- SQL Schema
-- Table: Tree
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | p_id        | int  |
-- +-------------+------+
-- id is the column with unique values for this table.
-- Each row of this table contains information about the id of a node and the id of its parent node in a tree.
-- The given structure is always a valid tree.

-- Problem Statement
-- Write a solution to report the type of each node in the tree.
-- Each node in the tree can be one of three types:
-- "Leaf": if the node is a leaf node.
-- "Root": if the node is the root of the tree.
-- "Inner": If the node is neither a leaf node nor a root node.

-- SQL Solution
WITH CTE AS (
    SELECT 
        id,
        p_id,
        CASE 
            WHEN p_id IS NULL THEN 'Root'
            WHEN (SELECT COUNT(p_id) FROM Tree t2 WHERE t2.p_id = t1.id) = 0 THEN 'Leaf'
            ELSE 'Inner'
        END AS type
    FROM 
        Tree t1
)
SELECT 
    id,
    type 
FROM 
    CTE;

-- Intuition:
-- To classify each node, we need to determine if it is a root, leaf, or inner node.
-- A root node has no parent (`p_id` is NULL).
-- A leaf node has no children (`id` does not appear as a `p_id` in the table).
-- An inner node has both a parent and at least one child.

-- Explanation:
-- 1. The `CTE` (Common Table Expression) selects each node and its parent ID.
-- 2. The `CASE` statement is used to classify each node:
--    - If `p_id` is NULL, the node is classified as 'Root'.
--    - If the count of rows where the current node's `id` is a parent (`p_id`) is 0, the node is classified as 'Leaf'.
--    - Otherwise, the node is classified as 'Inner'.
-- 3. The final `SELECT` statement retrieves the node `id` and its classification type from the `CTE`.
