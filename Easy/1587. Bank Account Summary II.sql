-- Problem 1587: Bank Account Summary II
-- Difficulty: Easy

-- SQL Schema
-- Table: Users
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | account      | int     |
-- | name         | varchar |
-- +--------------+---------+
-- account is the primary key (column with unique values) for this table.
-- Each row of this table contains the account number of each user in the bank.
-- There will be no two users having the same name in the table.

-- Table: Transactions
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | trans_id      | int     |
-- | account       | int     |
-- | amount        | int     |
-- | transacted_on | date    |
-- +---------------+---------+
-- trans_id is the primary key (column with unique values) for this table.
-- Each row of this table contains all changes made to all accounts.
-- amount is positive if the user received money and negative if they transferred money.
-- All accounts start with a balance of 0.

-- Problem Statement
-- Write a solution to report the name and balance of users with a balance higher than 10000.
-- The balance of an account is equal to the sum of the amounts of all transactions involving that account.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    u.name,
    SUM(t.amount) AS balance
FROM 
    Users u
LEFT JOIN 
    Transactions t 
ON 
    u.account = t.account
GROUP BY 
    u.name
HAVING 
    SUM(t.amount) > 10000;

-- Intuition:
-- To find users with a balance higher than 10000, we need to sum up the amounts of all transactions for each user.
-- We then filter out users whose balance exceeds 10000.

-- Explanation:
-- The LEFT JOIN ensures that we include all users even if they have no transactions (though this won’t affect the result here since we only want balances > 10000).
-- We group by the user's name and calculate the sum of the transaction amounts for each account.
-- The HAVING clause is used to filter users with a balance greater than 10000.
