/**************************************************************************************************
 Zomato Bangalore Restaurants Analysis - SQL Queries
**************************************************************************************************/


-- =================================================================================================
-- PART 1: DATA CLEANING AND PREPARATION
-- Before analysis, the raw VARCHAR data needs to be cleaned and converted to appropriate data types.
-- =================================================================================================

-- Step 1: Cleaning the 'rate' column
-- The 'rate' column is in a '4.1/5' format or contains 'NEW' or '-'.
-- We will convert it to a numeric format. Values like 'NEW' or '-' will be treated as NULL.

-- First, add a new column for the numeric rating
ALTER TABLE restaurants ADD COLUMN rating NUMERIC;

-- Update the new column with cleaned values
UPDATE restaurants
SET rating = CAST(SPLIT_PART(rate, '/', 1) AS NUMERIC)
WHERE rate ~ '^[0-9\.]+\/5$'; -- This regex ensures we only convert valid 'X/5' ratings


-- Step 2: Cleaning the 'approx_cost_for_two' column
-- This column contains commas (e.g., '1,500'). We need to remove them to convert it to a number.

-- First, add a new column for the numeric cost
ALTER TABLE restaurants ADD COLUMN cost_for_two NUMERIC;

-- Update the new column by removing commas and casting to numeric
UPDATE restaurants
SET cost_for_two = CAST(REPLACE(approx_cost_for_two, ',', '') AS NUMERIC)
WHERE approx_cost_for_two IS NOT NULL;

-- Step 3: Cleaning the 'votes' column
-- The 'votes' column is already mostly numeric but was imported as VARCHAR for safety.

-- First, add a new column for the numeric votes
ALTER TABLE restaurants ADD COLUMN votes_numeric INT;

-- Update the new column
UPDATE restaurants
SET votes_numeric = CAST(votes AS INT)
WHERE votes ~ '^[0-9]+$'; -- Only update rows that contain valid integers


-- =================================================================================================
-- PART 2: ANALYSIS QUERIES
-- These queries address the key questions outlined in the README.
-- =================================================================================================

-- Question 1: What are the top-rated dinner delivery options in Marathahalli?
SELECT
    name,
    rating,
    cost_for_two,
    cuisines,
    location
FROM restaurants
WHERE listed_in_city = 'Marathahalli'
  AND rating >= 4.0
  AND online_order = 'Yes'
ORDER BY rating DESC, votes_numeric DESC
LIMIT 20;


-- Question 2: What are the best value-for-money restaurants in Marathahalli?
-- We define "value" as a high rating for a low cost.
SELECT
    name,
    rating,
    cost_for_two,
    (rating / cost_for_two) * 100 AS value_score  -- Multiplying by 100 for a more intuitive score
FROM restaurants
WHERE listed_in_city = 'Marathahalli'
  AND rating IS NOT NULL
  AND cost_for_two > 0
ORDER BY value_score DESC
LIMIT 20;


-- Question 3: Which localities are the premier dining hotspots in Bangalore?
-- Defined as areas with a high concentration of highly-rated restaurants.
SELECT
    location,
    COUNT(name) AS num_top_restaurants,
    ROUND(AVG(rating), 2) AS average_rating
FROM restaurants
WHERE rating >= 4.5
GROUP BY location
HAVING COUNT(name) > 10 -- Only consider localities with a significant number of top restaurants
ORDER BY num_top_restaurants DESC, average_rating DESC
LIMIT 10;


-- Question 4: Which areas offer the greatest cuisine diversity?
SELECT
    location,
    COUNT(DISTINCT cuisines) AS distinct_cuisine_count
FROM restaurants
GROUP BY location
ORDER BY distinct_cuisine_count DESC
LIMIT 10;


-- Question 5: How does cost correlate with rating? (Bucket Analysis)
-- We group restaurants into cost buckets to see the average rating for each tier.
SELECT
    CASE
        WHEN cost_for_two <= 300 THEN 'Budget (<= 300)'
        WHEN cost_for_two > 300 AND cost_for_two <= 700 THEN 'Mid-Range (301-700)'
        WHEN cost_for_two > 700 AND cost_for_two <= 1500 THEN 'Premium (701-1500)'
        ELSE 'Luxury (> 1500)'
    END AS cost_bucket,
    COUNT(name) AS restaurant_count,
    ROUND(AVG(rating), 2) AS average_rating
FROM restaurants
WHERE rating IS NOT NULL AND cost_for_two IS NOT NULL
GROUP BY cost_bucket
ORDER BY average_rating DESC;


-- Question 6: What is the impact of offering online ordering and table booking on ratings?
SELECT
    online_order,
    book_table,
    COUNT(name) AS num_restaurants,
    ROUND(AVG(rating), 2) AS average_rating
FROM restaurants
WHERE rating IS NOT NULL
GROUP BY online_order, book_table
ORDER BY average_rating DESC;


-- Question 7: What are the most expensive cuisines on average?
SELECT
    cuisines,
    COUNT(name) AS restaurant_count,
    ROUND(AVG(cost_for_two), 2) AS average_cost
FROM restaurants
WHERE cost_for_two IS NOT NULL
GROUP BY cuisines
HAVING COUNT(name) > 20 -- Only consider cuisines with a decent number of restaurants
ORDER BY average_cost DESC
LIMIT 10;
