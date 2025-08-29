-- Problem 3451: Find Invalid IP Addresses
-- Difficulty: Hard

-- Table: logs
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | log_id      | int     |
-- | ip          | varchar |
-- | status_code | int     |
-- +-------------+---------+
-- log_id is the unique key for this table.
-- Each row contains server access log information including IP address and HTTP status code.

-- Problem Statement:
-- Find invalid IPv4 addresses from the logs table. An IP address is invalid if:
-- - It contains numbers greater than 255 in any octet.
-- - It has leading zeros in any octet (like 01.02.03.04).
-- - It has fewer or more than 4 octets.
-- Return the results as (ip, invalid_count) ordered by invalid_count descending, then ip descending.

-- Solution 1 (Using regular expressions):

SELECT ip,
       COUNT(*) AS invalid_count
FROM logs
WHERE ip NOT REGEXP '^((25[0-5]|2[0-4][0-9]|1\\d{2}|[1-9]?\\d)\\.){3}(25[0-5]|2[0-4][0-9]|1\\d{2}|[1-9]?\\d)$'
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;

-- Intuition (Solution 1):
-- A valid IPv4 must match a strict pattern:
--   - Four octets separated by dots.
--   - Each octet between 0–255 without leading zeros.
-- Using a regex, we can filter out any IPs that don’t fit this valid format.

-- Explanation (Solution 1):
-- - The regex enforces exactly 4 octets with valid ranges (0–255).
-- - Leading zeros are excluded since octets like "01" don’t match the pattern.
-- - The WHERE clause selects only invalid IPs (NOT REGEXP).
-- - Grouping by ip counts how often each invalid IP occurs.
-- - The final ORDER ensures sorting by invalid_count descending, then ip descending.


-- Solution 2 (Using string functions and conditions):

SELECT ip, COUNT(*) AS invalid_count
FROM logs
WHERE 
    -- must have exactly 3 dots
    (LENGTH(ip) - LENGTH(REPLACE(ip, '.', ''))) != 3
    OR
    -- any octet > 255
    CAST(SUBSTRING_INDEX(ip, '.', 1) AS UNSIGNED) > 255 OR
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS UNSIGNED) > 255 OR
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS UNSIGNED) > 255 OR
    CAST(SUBSTRING_INDEX(ip, '.', -1) AS UNSIGNED) > 255
    OR
    -- leading zeros
    SUBSTRING_INDEX(ip, '.', 1) REGEXP '^0[0-9]' OR
    SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) REGEXP '^0[0-9]' OR
    SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) REGEXP '^0[0-9]' OR
    SUBSTRING_INDEX(ip, '.', -1) REGEXP '^0[0-9]'
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;

-- Intuition (Solution 2):
-- Instead of regex, break down the IP into parts:
--   - Ensure exactly 3 dots (4 octets).
--   - Extract each octet and check if > 255.
--   - Detect invalid leading zeros using regex per octet.
-- This way, each condition is explicitly validated.

-- Explanation (Solution 2):
-- - (LENGTH - REPLACE) counts dots, ensuring 4 octets exist.
-- - SUBSTRING_INDEX extracts each octet one by one.
-- - CAST checks numeric range validity (<=255).
-- - REGEXP '^0[0-9]' flags octets like 01, 001, etc. as invalid.
-- - Rows failing any condition are marked invalid, grouped, counted, and ordered.
