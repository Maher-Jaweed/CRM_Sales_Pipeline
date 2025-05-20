SELECT *
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
JOIN sales_teams ON sales_pipeline.sales_agent = sales_teams.sales_agent	
;

#1. How is each sales team performing compared to the rest?
SELECT Manager, Sum(close_value) as 'revenue per team', Count(deal_stage) AS 'deals closed'
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
JOIN sales_teams ON sales_pipeline.sales_agent = sales_teams.sales_agent	
Where deal_stage = 'Won'
Group By 1
Order by 2
;

SELECT *
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
JOIN sales_teams ON sales_pipeline.sales_agent = sales_teams.sales_agent	
Where manager = 'Cara Losch'
;

SELECT DISTINCT(manager), Count(manager)
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
JOIN sales_teams ON sales_pipeline.sales_agent = sales_teams.sales_agent	
Where regional_office = 'East'
Group by 1
;

SELECT regional_office, round(((SUM(close_value) / 6494956) * 100),0) as 'Revenue %'
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
JOIN sales_teams ON sales_pipeline.sales_agent = sales_teams.sales_agent	
Group by 1

;

#2. Are any sales agents lagging behind?
SELECT Distinct(sales_pipeline.sales_agent), Sum(close_value) AS 'total close value'
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
JOIN sales_teams ON sales_pipeline.sales_agent = sales_teams.sales_agent	
Group by 1
Order by 2 
;

SELECT Distinct(sales_pipeline.sales_agent), Count(deal_stage) AS "Deals Closed"
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
JOIN sales_teams ON sales_pipeline.sales_agent = sales_teams.sales_agent	
Where deal_stage = "Won"
Group by 1
Order by 2 
;

#3. Can you identify any quarter-over-quarter trends? 
-- Only given data on deals from 2017-03 to 2017-06, this will make identifying Q/Q trends diffcult. More data needed.
-- What sector are our products most popular in? 
SELECT sector, Count(deal_stage) AS purchases
FROM sales_pipeline
INNER JOIN accounts ON sales_pipeline.account = accounts.account
Where deal_stage = 'won'
GROUP BY sector
ORDER BY 2 DESC
;
-- In the retail sector, what is the product sold distribtion 
SELECT 
  sales_pipeline.product, 
  COUNT(sales_pipeline.product) AS product_sold
FROM sales_pipeline
INNER JOIN accounts ON sales_pipeline.account = accounts.account
WHERE deal_stage = 'won' 
  AND sector = 'retail'
GROUP BY 1
ORDER BY 2 DESC;

#4. Do any products have better win rates? 
-- Win rate defined as Count of wins
SELECT DISTINCT(sales_pipeline.product), COUNT(deal_stage) AS 'Sold'
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
Where deal_stage = 'Won'
Group by 1
Order by 2 DESC
;

#5. How much does each product bring in? 
SELECT sales_pipeline.product, SUM(sales_price) AS revenue
FROM sales_pipeline
JOIN products ON sales_pipeline.product = products.product
WHERE deal_stage = 'Won'
GROUP BY sales_pipeline.product
ORDER BY revenue DESC;

