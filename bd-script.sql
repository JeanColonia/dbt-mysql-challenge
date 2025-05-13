CREATE SCHEMA dbt_db;

use dbt_db;


select * from customers;


select * from raw_customers;



select distinct customer_id, first_name, last_name, city, CASE WHEN state IS NOT NULL THEN state WHEN state IS NULL THEN 'NO STATE' END as state, country from customers;


select * from stg_customers;

select * from products;

select product_id, CONCAT(UCASE(LEFT(product_name,1)), LCASE(SUBSTRING(product_name, 2))) as product_name, CONCAT(UCASE(LEFT(category, 1)), 
LCASE(SUBSTRING(category, 2))) as category, ROUND(price, 2) as price, 
CASE WHEN description IS NOT NULL THEN description WHEN description IS NULL THEN 'No description' END as description,
 CASE WHEN color IS NOT NULL THEN CONCAT(UCASE(LEFT(color, 1)), LCASE(SUBSTRING(color, 2))) WHEN COLOR IS NULL THEN '-' END as color,  CASE 
WHEN stock_quantity >=1 THEN stock_quantity 
WHEN stock_quantity<1 THEN  0 
WHEN stock_quantity IS NULL THEN 0  
END  as stock_quantity, CAST(last_updated as DATE) as last_updated from products;


select * from stg_products;
-- dksamdkmsakdmsakdmsa

SELECT * FROM stg_products WHERE NULL> CURRENT_DATE();


SELECT current_date();

select * from sales;


select * from raw_sales;


SELECT DISTINCT sale_id, customer_id, product_id, CASE WHEN quantity IS NOT NULL THEN quantity WHEN quantity IS NULL OR quantity<0 THEN 0 END as quantity, CAST(sale_date  as DATE) as sale_date, ROUND(total_amount, 2) as total_amount from raw_sales;

SELECT * FROM stg_sales;

SELECT * FROM stg_products WHERE color != CONCAT(UCASE(LEFT(color, 1)), LCASE(SUBSTRING(color, 2))) AND color != "-";


SELECT * FROM stg_products where product_id not REGEXP '^[0-9]+$';

-- MARTS

-- SALES BY CUSTOMER
    
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(s.sale_id) AS total_purchases, SUM(s.quantity) AS total_quantity, ROUND(SUM(s.total_amount),2 ) AS total_spent, c.country
FROM customers AS c INNER JOIN sales AS s ON c.customer_id = s.customer_id GROUP BY c.customer_id, c.first_name, c.last_name, c.country;


SELECT * FROM mart_purchases_by_customer;

SELECT DATE(s.sale_date) AS sale_day, COUNT(s.sale_id) AS total_sales, SUM(s.quantity) AS total_items_sold, ROUND(SUM(s.total_amount), 2) AS total_revenue FROM stg_sales as s GROUP BY sale_day ORDER BY sale_day DESC;

SELECT * FROM mart_total_revenue;