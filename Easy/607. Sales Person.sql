-- Problem 607: Sales Person
-- Difficulty: Easy

-- SQL Schema
-- Table: SalesPerson
-- +-----------------+---------+
-- | Column Name     | Type    |
-- +-----------------+---------+
-- | sales_id        | int     |
-- | name            | varchar |
-- | salary          | int     |
-- | commission_rate | int     |
-- | hire_date       | date    |
-- +-----------------+---------+
-- sales_id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the name and the ID of a salesperson alongside their salary, commission rate, and hire date.

-- Table: Company
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | com_id      | int     |
-- | name        | varchar |
-- | city        | varchar |
-- +-------------+---------+
-- com_id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the name and the ID of a company and the city in which the company is located.

-- Table: Orders
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | order_id    | int  |
-- | order_date  | date |
-- | com_id      | int  |
-- | sales_id    | int  |
-- | amount      | int  |
-- +-------------+------+
-- order_id is the primary key (column with unique values) for this table.
-- com_id is a foreign key (reference column) to com_id from the Company table.
-- sales_id is a foreign key (reference column) to sales_id from the SalesPerson table.
-- Each row of this table contains information about one order. This includes the ID of the company, the ID of the salesperson, the date of the order, and the amount paid.

-- Problem Statement
-- Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name "RED".

-- SQL Solution 1
-- This query selects salespersons who do not have orders related to the company with the name "RED" by joining and filtering with conditions.
SELECT S.name 
FROM SalesPerson AS S
LEFT JOIN Orders AS O ON S.sales_id = O.sales_id
LEFT JOIN Company AS C ON O.com_id = C.com_id
WHERE C.name = 'RED' OR O.sales_id IS NULL;

-- Intuition:
-- The goal is to find salespersons who have no orders associated with the company named "RED".
-- By using a `LEFT JOIN`, we include all salespersons and only those orders related to the company "RED".

-- Explanation:
-- The query uses a `LEFT JOIN` to combine the `SalesPerson`, `Orders`, and `Company` tables.
-- It then filters for salespersons where the company name is "RED" or where there are no related orders (`O.sales_id IS NULL`).

-- SQL Solution 2
-- This query selects salespersons who have not placed any orders for the company with the name "RED" by using a subquery.
SELECT name 
FROM SalesPerson 
WHERE sales_id NOT IN (
    SELECT DISTINCT sales_id 
    FROM Orders 
    WHERE com_id = (
        SELECT com_id 
        FROM Company 
        WHERE name = 'RED'
    )
);

-- Intuition:
-- The goal is to find salespersons who did not place any orders for the company named "RED".
-- By using a subquery, we first determine the `com_id` for "RED" and then find salespersons who are not associated with any orders for this `com_id`.

-- Explanation:
-- The subquery finds all `sales_id` associated with the company "RED".
-- The outer query then selects salespersons whose `sales_id` does not appear in this list.

-- SQL Solution 3
-- This query selects salespersons who have not placed orders for any company with the name "RED" by combining tables and using a `NOT IN` condition.
SELECT name 
FROM SalesPerson 
WHERE sales_id NOT IN (
    SELECT sales_id 
    FROM Orders 
    WHERE com_id IN (
        SELECT com_id 
        FROM Company 
        WHERE name = 'RED'
    )
);

-- Intuition:
-- This query is similar to the previous one but explicitly uses an `IN` clause within the subquery.
-- It ensures that the selected salespersons are those who did not have orders for the company named "RED".

-- Explanation:
-- The inner subquery identifies the `com_id` for the company "RED".
-- Another subquery retrieves `sales_id` associated with this `com_id`.
-- The outer query then selects salespersons whose `sales_id` is not in this list.

-- SQL Solution 4
-- This query selects salespersons who have not placed orders for any company named "RED" by combining multiple joins.
SELECT S.name 
FROM SalesPerson AS S
LEFT JOIN Orders AS O ON S.sales_id = O.sales_id
LEFT JOIN Company AS C ON O.com_id = C.com_id
WHERE C.name IS NULL OR C.name != 'RED';

-- Intuition:
-- The goal is to find salespersons who have not placed orders related to the company "RED" by ensuring that no matching orders are found.

-- Explanation:
-- The query uses a `LEFT JOIN` to connect the `SalesPerson`, `Orders`, and `Company` tables.
-- It then filters out salespersons who have orders for the company "RED" or ensures that the company name is either `NULL` (no orders) or not "RED".
