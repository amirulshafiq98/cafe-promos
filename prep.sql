-- =======================================
-- Data prepation before exporting to Tableau
-- =======================================

-- 1 Create table for 0-6 days 
Drop table total_rec_0_6 ;

CREATE TABLE total_rec_0_6 AS
SELECT *
FROM total_rec
WHERE day_number BETWEEN 0 AND 6;

ALTER TABLE total_rec_0_6
ADD COLUMN day_number_comp INT; -- Add day_number_comp column

CREATE INDEX idx_rec ON total_rec_0_6 (customer_id, offer_id);
-- CREATE INDEX idx_comp ON total_comp (customer_id, offer_id, day_number);

UPDATE total_rec_0_6 tr
JOIN total_comp tc
    ON tr.customer_id = tc.customer_id
    AND tr.offer_id = tc.offer_id
    AND tr.day_number < 7  -- Ensuring only first 6 days of received offers
JOIN offers o
    ON tr.offer_id = o.offer_id
SET tr.day_number_comp = tc.day_number
WHERE tc.day_number < o.duration;  -- Redemption must be within offer's duration

SELECT *
FROM total_rec_0_6
where day_number_comp = 9; -- Check results are live

-- 2 Create table for 7-13 days
DROP TABLE IF EXISTS total_rec_7_13;

CREATE TABLE total_rec_7_13 AS
SELECT *
FROM total_rec
WHERE day_number BETWEEN 7 AND 13; -- Create a new table with records from days 7 to 13

ALTER TABLE total_rec_7_13
ADD COLUMN day_number_comp INT; -- Add the day_number_comp column

CREATE INDEX idx_rec ON total_rec_7_13 (customer_id, offer_id);

UPDATE total_rec_7_13 tr
JOIN total_comp tc
    ON tr.customer_id = tc.customer_id
    AND tr.offer_id = tc.offer_id
JOIN offers o  -- Ensure you use the correct table for offer durations
    ON tr.offer_id = o.offer_id
SET tr.day_number_comp = tc.day_number
WHERE tc.day_number > 6 AND tc.day_number < (tr.day_number + o.duration);  -- Ensure redemption is within offer duration

SELECT *
FROM total_rec_7_13
WHERE day_number_comp = 10; -- Check if results are correct

-- 3 Create table for 14-16 days
DROP TABLE IF EXISTS total_rec_14_16;

CREATE TABLE total_rec_14_16 AS
SELECT *
FROM total_rec
WHERE day_number BETWEEN 14 AND 16; -- Create a new table with records from days 7 to 13

ALTER TABLE total_rec_14_16
ADD COLUMN day_number_comp INT; -- Add the day_number_comp column

CREATE INDEX idx_rec ON total_rec_14_16 (customer_id, offer_id);

UPDATE total_rec_14_16 tr
JOIN total_comp tc
    ON tr.customer_id = tc.customer_id
    AND tr.offer_id = tc.offer_id
JOIN offers o  -- Ensure you use the correct table for offer durations
    ON tr.offer_id = o.offer_id
SET tr.day_number_comp = tc.day_number
WHERE tc.day_number > 13 AND tc.day_number < (tr.day_number + o.duration);  -- Ensure redemption is within offer duration

SELECT *
FROM total_rec_14_16
WHERE day_number_comp = 23; -- Check if results are correct

-- 5 Create table for 17-20 days
DROP TABLE IF EXISTS total_rec_17_20;

CREATE TABLE total_rec_17_20 AS
SELECT *
FROM total_rec
WHERE day_number BETWEEN 17 AND 20; -- Create a new table with records from days 7 to 13

ALTER TABLE total_rec_17_20
ADD COLUMN day_number_comp INT; -- Add the day_number_comp column

CREATE INDEX idx_rec ON total_rec_17_20 (customer_id, offer_id);

UPDATE total_rec_17_20 tr
JOIN total_comp tc
    ON tr.customer_id = tc.customer_id
    AND tr.offer_id = tc.offer_id
JOIN offers o  -- Ensure you use the correct table for offer durations
    ON tr.offer_id = o.offer_id
SET tr.day_number_comp = tc.day_number
WHERE tc.day_number > 16 AND tc.day_number < (tr.day_number + o.duration);  -- Ensure redemption is within offer duration

SELECT *
FROM total_rec_17_20
WHERE day_number_comp = 26; -- Check if results are correct

-- 6 Create table for 21-23 days
DROP TABLE IF EXISTS total_rec_21_23;

CREATE TABLE total_rec_21_23 AS
SELECT *
FROM total_rec
WHERE day_number BETWEEN 21 AND 23; -- Create a new table with records from days 7 to 13

ALTER TABLE total_rec_21_23
ADD COLUMN day_number_comp INT; -- Add the day_number_comp column

CREATE INDEX idx_rec ON total_rec_21_23 (customer_id, offer_id);

UPDATE total_rec_21_23 tr
JOIN total_comp tc
    ON tr.customer_id = tc.customer_id
    AND tr.offer_id = tc.offer_id
JOIN offers o  -- Ensure you use the correct table for offer durations
    ON tr.offer_id = o.offer_id
SET tr.day_number_comp = tc.day_number
WHERE tc.day_number > 20 AND tc.day_number < (tr.day_number + o.duration);  -- Ensure redemption is within offer duration

SELECT *
FROM total_rec_21_23
WHERE day_number_comp = 30; -- Check if results are correct


-- 7 Create table for 24-30 days
DROP TABLE IF EXISTS total_rec_24_30;

CREATE TABLE total_rec_24_30 AS
SELECT *
FROM total_rec
WHERE day_number BETWEEN 24 AND 31; -- Create a new table with records from days 7 to 13

ALTER TABLE total_rec_24_30
ADD COLUMN day_number_comp INT; -- Add the day_number_comp column

CREATE INDEX idx_rec ON total_rec_24_30 (customer_id, offer_id);

UPDATE total_rec_24_30 tr
JOIN total_comp tc
    ON tr.customer_id = tc.customer_id
    AND tr.offer_id = tc.offer_id
JOIN offers o  -- Ensure you use the correct table for offer durations
    ON tr.offer_id = o.offer_id
SET tr.day_number_comp = tc.day_number
WHERE tc.day_number > 23 AND tc.day_number < (tr.day_number + o.duration);  -- Ensure redemption is within offer duration

SELECT *
FROM total_rec_24_30
WHERE day_number_comp = 30; -- Check if results are correct


-- 8 Combine all information into a table
DROP TABLE IF EXISTS final_events;

CREATE TABLE final_events AS
SELECT customer_id, offer_id, day_number, day_number_comp FROM total_rec_0_6
UNION ALL
SELECT customer_id, offer_id, day_number, day_number_comp FROM total_rec_7_13
UNION ALL
SELECT customer_id, offer_id, day_number, day_number_comp FROM total_rec_14_16
UNION ALL
SELECT customer_id, offer_id, day_number, day_number_comp FROM total_rec_17_20
UNION ALL
SELECT customer_id, offer_id, day_number, day_number_comp FROM total_rec_21_23
UNION ALL
SELECT customer_id, offer_id, day_number, day_number_comp FROM total_rec_24_30;

Select * from final_events;



