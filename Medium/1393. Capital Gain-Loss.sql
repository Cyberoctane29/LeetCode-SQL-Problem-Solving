-- Problem 1393: Capital Gain/Loss
-- Difficulty: Medium

-- SQL Schema
-- Table: Stocks
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | stock_name    | varchar |
-- | operation     | enum    |
-- | operation_day | int     |
-- | price         | int     |
-- +---------------+---------+
-- (stock_name, operation_day) is the primary key for this table.
-- The operation column is an ENUM of type ('Sell', 'Buy').
-- Each row indicates the operation on a stock (Buy or Sell) on a specific day, with the corresponding price.
-- It is guaranteed that each 'Sell' operation has a corresponding 'Buy' operation on a previous day, and vice versa.

-- Problem Statement
-- Write a solution to report the Capital gain/loss for each stock.
-- The Capital gain/loss is the total gain or loss after buying and selling the stock one or many times.
-- Return the result table in any order.

-- Solution 1: Using SUM with IF()
SELECT 
    stock_name,
    SUM(IF(operation = 'Buy', -price, price)) AS capital_gain_loss 
FROM 
    stocks 
GROUP BY 
    stock_name;

-- Intuition for Solution 1:
-- For each stock, we need to calculate the total gain or loss.
-- A 'Buy' operation represents a loss (spending money), so we subtract the price from the total.
-- A 'Sell' operation represents a gain, so we add the price to the total.
-- We use an IF() function to apply these conditions in the SUM() function.
-- The query groups the results by stock_name to calculate the capital gain/loss for each stock.

-- Explanation for Solution 1:
-- We use the IF() function to differentiate between 'Buy' and 'Sell' operations.
-- For each stock, if the operation is 'Buy', we subtract the price (indicating a loss).
-- If the operation is 'Sell', we add the price (indicating a gain).
-- The query then groups by stock_name to return the total capital gain/loss for each stock.

-- Solution 2: Using SUM with CASE and PARTITION BY
SELECT 
    DISTINCT stock_name, 
    SUM(CASE WHEN operation = 'Buy' THEN -price ELSE price END) 
    OVER (PARTITION BY stock_name) AS capital_gain_loss 
FROM 
    stocks;

-- Intuition for Solution 2:
-- In this solution, we use a window function with `PARTITION BY` to calculate the running total gain/loss for each stock.
-- The CASE statement works similarly to the IF() function in Solution 1, where we subtract the price for 'Buy' and add the price for 'Sell'.
-- The `PARTITION BY stock_name` ensures that the calculation is done separately for each stock.
-- We select distinct stock names to return the final result.

-- Explanation for Solution 2:
-- The `SUM()` window function with `PARTITION BY stock_name` calculates the running total of capital gain/loss for each stock.
-- The CASE statement differentiates between 'Buy' and 'Sell', just like in Solution 1.
-- Using `DISTINCT` ensures that we get each stock's result only once in the output.
-- This approach is more powerful when you need to compute running totals or other window-based operations.
