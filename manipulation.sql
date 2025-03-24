-- ===========================================
-- Manipulation of tables before EDA
-- ===========================================

-- 1 Change the time to days instead
Alter table events_promo
ADD column day_number int;
UPDATE events_promo
SET day_number = FLOOR((time - 1) / 24) + 1;

-- 2 Check to see if changes are made
SELECT *
FROM events_promo
WHERE time = 4;

-- 3 Make table for total sales
DROP TABLE IF EXISTS total_sales;

CREATE TABLE total_sales (
    customer_id VARCHAR(255),
    event VARCHAR(50),
    amount_spent DECIMAL(10, 2) DEFAULT 0.0,
    day_number INT NOT NULL
);

INSERT INTO total_sales (customer_id, event, amount_spent, day_number)
SELECT 
    customer_id,
    event,
    amount_spent,
    day_number
FROM 
    events_promo
WHERE 
    event NOT LIKE 'off%'; -- Exclude rows where event starts with 'off'

SELECT * 
FROM total_sales
WHERE day_number = 12; -- Check to see if changes are live

-- 4 Make total_rec table
DROP TABLE IF EXISTS total_rec;

CREATE TABLE total_rec (
    customer_id VARCHAR(255),
    event VARCHAR(50),
    offer_id VARCHAR(255),
    total_views INT DEFAULT 0,
    total_completions INT DEFAULT 0,
    day_number int not null
);

INSERT INTO total_rec (customer_id, event, offer_id, total_views, total_completions, day_number)
SELECT 
    customer_id,
    event,
    offer_id, 
    total_views,
    total_completions,
    day_number
From events_promo;
Delete from total_rec
Where event like 'trans%' 
	OR event like '%completed'
    OR event like '%viewed'; -- Exclude rows that do not track received

Select distinct(day_number) from total_rec; -- Check to see if changes are live
-- Select * from total_comp
-- Where customer_id = '801ce107d1d44aafa77237b6fd338672';
-- SELECT * 
-- FROM total_sales
-- WHERE 
--     customer_id = '801ce107d1d44aafa77237b6fd338672' ;

-- 5 Make total_comp table
DROP TABLE IF EXISTS total_comp;

CREATE TABLE total_comp (
    customer_id VARCHAR(255),
    event VARCHAR(50),
    offer_id VARCHAR(255),
    total_views INT DEFAULT 0,
    total_completions INT DEFAULT 0,
    day_number int not null
);

INSERT INTO total_comp (customer_id, event, offer_id, total_views, total_completions, day_number)
SELECT 
    customer_id,
    event,
    offer_id, 
    total_views, 
    total_completions, 
    day_number
From events_promo;
Delete from total_comp
Where event like 'trans%' 
	OR event like '%viewed'
    OR event like '%received'; -- Exclude rows that do no track completions

Select * from total_comp
Where day_number = 1; -- Check to see if changes are live


-- 6 Create table to summarise all columns
DROP TABLE IF EXISTS final_events;

CREATE TABLE final_events AS
SELECT 
    tr.customer_id, 
    tr.offer_id, 
    tr.day_number, 
    CASE 
        WHEN tc.day_number < tr.day_number + o.duration THEN tc.day_number 
        ELSE NULL 
    END AS day_number_comp
FROM total_rec tr
LEFT JOIN total_comp tc 
    ON tr.customer_id = tc.customer_id
    AND tr.offer_id = tc.offer_id
LEFT JOIN offers o 
    ON tr.offer_id = o.offer_id;  -- Filter to only include relevant day ranges

SELECT * FROM final_events
order by day_number_comp DESC;

 
 
 
    
