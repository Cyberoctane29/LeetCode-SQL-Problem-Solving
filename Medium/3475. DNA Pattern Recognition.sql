-- Problem 3475: DNA Pattern Recognition
-- Difficulty: Medium

-- Table: Samples
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | sample_id      | int     |
-- | dna_sequence   | varchar |
-- | species        | varchar |
-- +----------------+---------+
-- sample_id is the unique key for this table.
-- Each row contains a DNA sequence represented as a string of characters (A, T, G, C) 
-- and the species it was collected from.

-- Problem Statement:
-- Identify DNA samples with the following characteristics:
-- 1. Sequence starts with 'ATG' (common start codon)
-- 2. Sequence ends with 'TAA', 'TAG', or 'TGA' (stop codons)
-- 3. Sequence contains 'ATAT' (simple repeated pattern)
-- 4. Sequence contains at least 3 consecutive 'G' (e.g., GGG, GGGG)
-- Return results ordered by sample_id ascending.

-- Solution 1 (Using Regular Expressions with REGEXP)

SELECT 
    sample_id,
    dna_sequence,
    species,
    CASE WHEN dna_sequence REGEXP '^ATG' THEN 1 ELSE 0 END AS has_start,
    CASE WHEN dna_sequence REGEXP '(TAA|TAG|TGA)$' THEN 1 ELSE 0 END AS has_stop,
    CASE WHEN dna_sequence REGEXP 'ATAT' THEN 1 ELSE 0 END AS has_atat,
    CASE WHEN dna_sequence REGEXP 'G{3,}' THEN 1 ELSE 0 END AS has_ggg
FROM 
    samples
ORDER BY 
    sample_id ASC;

-- Intuition:
-- Use regular expressions to check for each pattern in the DNA sequence.

-- Explanation:
-- - '^ATG' ensures the sequence starts with ATG.
-- - '(TAA|TAG|TGA)$' checks if it ends with one of the stop codons.
-- - 'ATAT' searches for the repeated pattern anywhere in the sequence.
-- - 'G{3,}' finds sequences with at least three consecutive Gs.
-- Each match sets a binary flag (1 for match, 0 otherwise).

-- Solution 2 (Using LIKE Wildcard Patterns)

SELECT 
    sample_id,
    dna_sequence,
    species,
    CASE WHEN dna_sequence LIKE 'ATG%' THEN 1 ELSE 0 END AS has_start,
    CASE WHEN dna_sequence LIKE '%TAA' OR 
              dna_sequence LIKE '%TAG' OR 
              dna_sequence LIKE '%TGA' THEN 1 ELSE 0 END AS has_stop,
    CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END AS has_atat,
    CASE WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 END AS has_ggg
FROM 
    samples
ORDER BY 
    sample_id ASC;

-- Intuition:
-- Use simple pattern matching with LIKE to check for the required DNA motifs.

-- Explanation:
-- - 'ATG%' matches sequences starting with ATG.
-- - '%TAA', '%TAG', '%TGA' detect sequences ending with stop codons.
-- - '%ATAT%' matches if the repeated pattern is present anywhere.
-- - '%GGG%' finds any occurrence of three consecutive Gs.
-- LIKE is simpler but less flexible than REGEXP for more complex patterns.
