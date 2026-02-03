CREATE DATABASE finance;
GO
USE finance;
GO

USE finance;
GO
SELECT COUNT(*) AS total_rows FROM cc_data;

SELECT COUNT(*) AS total_rows FROM location_data;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- 1) Calculate the total number of transactions in the cc_data table 

SELECT COUNT(*) AS total_transactions
FROM cc_data;

-- 2) Identify the top 10 most frequent merchants in the cc_data table

select * from cc_data

select top 10 merchant,
count(*) as transaction_count
from cc_data
group by merchant
order by transaction_count DESC;

-- 3) Find the average transaction amount for each category of transactions in the cc_data table

select category, ROUND(AVG(amt), 2) AS avg_transaction_amount
from cc_data
group by category
order by avg_transaction_amount DESC;

-- 4) Determine the number of fraudulent transactions and the percentage of total transactions that they represent

SELECT
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    COUNT(*) AS total_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_percentage
FROM cc_data;

-- 5 ) Join the cc_data and location_data tables to identify the latitude and longitude of each transaction

-- Method 1
SELECT
    cc.trans_date_trans_time,
    cc.amt,
    cc.cc_num,
    ld.lat,
    ld.long
FROM cc_data cc
LEFT JOIN location_data ld
    ON CAST(cc.cc_num AS FLOAT) = ld.cc_num;

 -- Method 2
 
    SELECT
    trans_date_trans_time,
    amt,
    lat,
    long
FROM cc_data;



-- 6 ) Identify the city with the highest population in the location_data table

SELECT TOP 1
    city,
    city_pop
FROM cc_data
ORDER BY city_pop DESC;

-- 7 ) Find the earliest and latest transaction dates in the cc_data table

SELECT
    MIN(trans_date_trans_time) AS earliest_transaction,
    MAX(trans_date_trans_time) AS latest_transaction
FROM cc_data;

-- 8 ) What is the total amount spent across all transactions in the cc_data table?

SELECT
    ROUND(SUM(amt), 2) AS total_amount_spent
FROM cc_data;

-- 9 ) How many transactions occurred in each category in the cc_data table?

SELECT
    category,
    COUNT(*) AS transaction_count
FROM cc_data
GROUP BY category
ORDER BY transaction_count DESC;

-- 10 ) What is the average transaction amount for each gender in the cc_data table?

SELECT
    gender,
    ROUND(AVG(amt), 2) AS avg_transaction_amount
FROM cc_data
GROUP BY gender;

-- 11 ) Which day of the week has the highest average transaction amount in the cc_data table?

SELECT TOP 1
    DATENAME(WEEKDAY, trans_date_trans_time) AS day_of_week,
    ROUND(AVG(amt), 2) AS avg_transaction_amount
FROM cc_data
GROUP BY DATENAME(WEEKDAY, trans_date_trans_time)
ORDER BY avg_transaction_amount DESC;








