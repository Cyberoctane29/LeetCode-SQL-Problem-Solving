-- Problem 3570: Find Books with No Available Copies
-- Difficulty: Easy

-- Table: library_books
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | book_id          | int     |
-- | title            | varchar |
-- | author           | varchar |
-- | genre            | varchar |
-- | publication_year | int     |
-- | total_copies     | int     |
-- +------------------+---------+
-- book_id is the unique identifier for this table.
-- Each row contains information about a book in the library, including the total number of copies owned by the library.

-- Table: borrowing_records
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | record_id     | int     |
-- | book_id       | int     |
-- | borrower_name | varchar |
-- | borrow_date   | date    |
-- | return_date   | date    |
-- +---------------+---------+
-- record_id is the unique identifier for this table.
-- Each row represents a borrowing transaction, and return_date is NULL if the book is currently borrowed and hasn't been returned yet.

-- Problem Statement:
-- Write a solution to find all books that are currently borrowed (not returned) and have zero copies available in the library.
-- A book is considered currently borrowed if there exists a borrowing record with a NULL return_date.
-- Return the result table ordered by current borrowers in descending order, then by book title in ascending order.

-- Solution

WITH CTE AS (
  SELECT 
    book_id,
    COUNT(*) AS current_borrowers
  FROM 
    borrowing_records
  WHERE 
    return_date IS NULL
  GROUP BY 
    book_id
)
SELECT 
  l.book_id,
  l.title,
  l.author,
  l.genre,
  l.publication_year,
  c.current_borrowers
FROM 
  library_books AS l
LEFT JOIN 
  CTE AS c ON l.book_id = c.book_id
WHERE 
  l.total_copies - c.current_borrowers = 0
ORDER BY 
  current_borrowers DESC,
  title ASC;

-- Intuition:
-- I want to find books where all available copies are currently borrowed — meaning the number of currently borrowed copies equals the total number of copies.

-- Explanation:
-- I first build a CTE to count how many copies of each book are currently borrowed using:
--   - `WHERE return_date IS NULL` to filter for currently borrowed books.
--   - `GROUP BY book_id` to count active borrowings per book.
-- I then join this result with the `library_books` table to get book metadata.
-- In the `WHERE` clause, I check if the difference between total copies and current borrowings is zero.
-- This tells me that all available copies are currently borrowed.
-- Finally, I order the results by number of borrowers (descending) and then by book title (ascending).
