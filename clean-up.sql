-- =========================================
-- Customers Table Setup
-- =========================================

-- 1 Drop the table if it already exists
DROP TABLE IF EXISTS customers;

-- 2 Create the table with the correct structure
CREATE TABLE customers (
    customer_id VARCHAR(100) NOT NULL PRIMARY KEY,
    became_member_on DATE NOT NULL,
    gender VARCHAR(10), 
    age INT NOT NULL,
    income VARCHAR(50)
);

-- 3 Load data from CSV while handling empty income values
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- 4 View the data after loading
SELECT * FROM customers;

-- =========================================
-- Events Table Setup (NOT NEEDED)
-- =========================================

-- 1 Drop the table if it already exists
DROP TABLE IF EXISTS events;

-- 2 Create the table with the correct structure
CREATE TABLE events (
    customer_id VARCHAR(100) NOT NULL,
    event varchar(50) NOT NULL,
    value text not null, 
    time int NOT NULL
);

-- 3 Load data from CSV while handling empty income values
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv'
INTO TABLE events
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'  -- Handle fields enclosed in quotes
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 4 Check to see if all columns are present
SELECT COUNT(*) FROM events;
SELECT *
FROM events
WHERE value LIKE '%\'amount\': %';
SELECT *
FROM events
WHERE value LIKE '%\'offer_id\': \'fafdcd668e3743c1bb461111dcafc2a4\', \'reward\': 2%';


-- SET SQL_SAFE_UPDATES = 0;
DELETE FROM events
WHERE value LIKE '{''amount'': %}'  -- Matches {'amount': ___}
   OR value LIKE '%''reward'': %}';  -- Matches {'offer_id': 'code', 'reward': ___}
-- SET SQL_SAFE_UPDATES = 1;


-- SET SQL_SAFE_UPDATES = 0;
UPDATE events
SET value = TRIM(
    REPLACE(
        REPLACE(
            SUBSTRING(
                value,
                LOCATE(':', value) + 3,  -- Start after the colon and space
                LOCATE('}', value) - (LOCATE(':', value) + 3)  -- End at the closing brace
            ),
            '''', ''  -- Remove single quotes
        ),
        '}', ''  -- Remove closing brace
    )
);
-- SET SQL_SAFE_UPDATES = 1;

-- 5 View the data after loading
SELECT * FROM events;

-- =========================================
-- Offers Table Setup
-- =========================================
-- 1 Drop the table if it already exists
DROP TABLE IF EXISTS offers;

-- 2 Create the table with the correct structure
CREATE TABLE offers (
    offer_id VARCHAR(100) NOT NULL PRIMARY KEY,
    offer_type varchar(50) NOT NULL,
    difficulty int NOT NULL, 
    reward int NOT NULL,
    duration int NOT NULL,
    channels_1 text NOT NULL,
    channels_2 text NOT NULL,
    channels_3 text NOT NULL,
    channels_4 text NOT NULL
);

-- 3 Load data from CSV while handling empty income values
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/offers.csv'
INTO TABLE offers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 4 Trim the brackets and delimiters for the social channels
UPDATE offers
SET
    channels_1 = TRIM(REPLACE(REPLACE(REPLACE(channels_1, '[', ''), ']', ''), '''', '')),
    channels_2 = TRIM(REPLACE(REPLACE(REPLACE(channels_2, '[', ''), ']', ''), '''', '')),
    channels_3 = TRIM(REPLACE(REPLACE(REPLACE(channels_3, '[', ''), ']', ''), '''', '')),
    channels_4 = TRIM(REPLACE(REPLACE(REPLACE(channels_4, '[', ''), ']', ''), '''', ''));

-- 5 Remove informational offer_type
Delete from offers
where offer_type like 'info%';

-- 6 View the data after loading
SELECT * FROM offers;

-- ===============================================
-- Extra trys
-- ===============================================
-- 1 Drop and create the events_promo table
DROP TABLE IF EXISTS events_promo;

CREATE TABLE events_promo (
    customer_id VARCHAR(255),
    event VARCHAR(50),
    offer_id VARCHAR(255),
    total_views INT DEFAULT 0,
    total_completions INT DEFAULT 0,
    amount_spent DECIMAL(10, 2) DEFAULT 0.0,
    time INT NOT NULL
);

-- 2 Create a temporary table to match the CSV structure
DROP TABLE IF EXISTS temp_events;

-- 3 Dummy table to store values in
CREATE TABLE temp_events (
    customer_id VARCHAR(255),
    event VARCHAR(50),
    value TEXT,
    time INT
);

-- 3 Load the CSV data into the temporary table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv'
INTO TABLE temp_events
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Skip the header row

-- 4 Insert data into the events_promo table
INSERT INTO events_promo (customer_id, event, offer_id, total_views, total_completions, amount_spent, time)
SELECT 
    customer_id,
    event,
    CASE
        WHEN event = 'offer received' THEN 
            REPLACE(
                TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(value, ':', -1), '}', 1)), 
                '''', 
                ''
            ) -- Extract offer_id and remove single quotes
        WHEN event = 'offer completed' THEN 
            REPLACE(
                TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(value, ':', -2), ',', 1)), 
                '''', 
                ''
            ) -- Extract offer_id and remove single quotes
        ELSE NULL -- For transactions or other events
    END AS offer_id,
    CASE
        WHEN event = 'offer received' THEN 1 -- Count as a view
        ELSE 0 -- Default value for total_views
    END AS total_views,
    CASE
        WHEN event = 'offer completed' THEN 1 -- Count as a completion
        ELSE 0 -- Default value for total_completions
    END AS total_completions,
    CASE
        WHEN event = 'transaction' THEN CAST(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(value, ':', -1), '}', 1)) AS DECIMAL(10, 2)) -- Extract amount
        WHEN event = 'offer completed' THEN CAST(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(value, ':', -1), '}', 1)) AS DECIMAL(10, 2)) -- Extract reward
        ELSE 0.0 -- Default value for amount_spent
    END AS amount_spent,
    time
FROM 
    temp_events;
-- Drop table temp_events;

-- 5 Remove informational offer_type
Delete from events_promo
Where offer_id = '3f207df678b143eea3cee63160fa8bed' or offer_id = '5a8bc65990b245e5a138643cd4eb9837';

-- 6 Query the table to verify the results
SELECT * FROM events_promo
WHERE event like '%received';



