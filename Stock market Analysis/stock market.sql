CREATE TABLE stock_data (
    date DATE NOT NULL,
    open NUMERIC NOT NULL,
    high NUMERIC NOT NULL,
    low NUMERIC NOT NULL,
    close NUMERIC NOT NULL,
    volume BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL
);


ALTER TABLE stock_data
    ALTER COLUMN open DROP NOT NULL,
    ALTER COLUMN high DROP NOT NULL,
    ALTER COLUMN low DROP NOT NULL,
    ALTER COLUMN volume DROP NOT NULL;



SELECT 
	date,
	open,
	high,
	low,
	close,
	name,
	TO_CHAR(volume, '999,999,999') AS Volume,
	ROUND(AVG(close) OVER (PARTITION BY name ORDER BY date),2) AS avg_moving_price
FROM 
	Stock_data
WHERE name  = 'AMD'
LIMIT 10


SELECT 
	date,
	open,
	high,
	low,
	close,
	name,
	TO_CHAR(volume, '999,999,999') AS Volume,
	ROUND(AVG(close) OVER (PARTITION BY name ORDER BY date),2) AS avg_moving_price,
	RANK() OVER(PARTITION BY name ORDER BY close)
FROM 
	Stock_data
ORDER BY rank 
WHERE name  = 'AMD'
LIMIT 10
 
-- daily return and cumulative Returns for AMD

WITH IntermediateCalculations AS (
    SELECT 
        name,
        date,
        close,
        ROUND(LAG(close) OVER (PARTITION BY name ORDER BY date), 2) AS previous_close,
        (close - LAG(close) OVER (PARTITION BY name ORDER BY date)) / LAG(close) OVER (PARTITION BY name ORDER BY date)  AS daily_return
    FROM 
        stock_data
)
SELECT 
    name,
    date,
    close,
    previous_close,
    ROUND(daily_return, 2) AS daily_return,
    ROUND(SUM(daily_return) OVER (PARTITION BY name ORDER BY date), 2) AS cumulative_return
FROM 
    IntermediateCalculations
WHERE  
	daily_return IS NOT NULL AND name = 'AMD'

ORDER BY 
     date

-- Rank stock based on closing 
SELECT 
    name,
    DATE_TRUNC('month', date) AS month,
    ROUND(AVG(close),2) AS avg_close,
    RANK() OVER (PARTITION BY DATE_TRUNC('month', date) ORDER BY AVG(close) DESC) AS rank
FROM 
    stock_data
GROUP BY 
    name, DATE_TRUNC('month', date)
ORDER BY 
    month, rank  DESC


-- 3. Rank Stocks by Average Closing Price Over a Month

SELECT 
    name,
    DATE_TRUNC('month', date) AS month,
    ROUND(AVG(close), 2) AS avg_close,
    RANK() OVER (PARTITION BY DATE_TRUNC('month', date) ORDER BY AVG(close) DESC) AS rank
FROM 
    stock_data
GROUP BY 
    name, DATE_TRUNC('month', date)
ORDER BY 
    month, rank;
-- 4. Calculate Year-to-Date (YTD) Returns
SELECT 
    name,
    date,
    close,
    FIRST_VALUE(close) OVER (PARTITION BY name, EXTRACT(YEAR FROM date) ORDER BY date) AS start_of_year_close,
    ROUND(
        (close - FIRST_VALUE(close) OVER (PARTITION BY name, EXTRACT(YEAR FROM date) ORDER BY date)) / 
        FIRST_VALUE(close) OVER (PARTITION BY name, EXTRACT(YEAR FROM date) ORDER BY date),
        2
    ) AS ytd_return
FROM 
    stock_data
ORDER BY 
    name, date
LIMIT 8;

-- 5. Calculate 7-Day Volatility (Standard Deviation of Returns)
WITH DailyReturns AS (
    SELECT 
        name,
        date,
        close,
        LAG(close) OVER (PARTITION BY name ORDER BY date) AS previous_close,
        ROUND(
            (close - LAG(close) OVER (PARTITION BY name ORDER BY date)) / LAG(close) OVER (PARTITION BY name ORDER BY date), 
            4
        ) AS daily_return
    FROM 
        stock_data
)
SELECT 
    name,
    date,
    close,
    daily_return,
    ROUND(
        STDDEV(daily_return) OVER (PARTITION BY name ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),
        4
    ) AS volatility_7_day
FROM 
    DailyReturns
ORDER BY 
    name, date;




