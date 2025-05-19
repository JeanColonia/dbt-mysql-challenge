
CREATE SCHEMA dbt_demo_db;

use dbt_demo_db;


SELECT * FROM CUSTOMERS;

SELECT name, email, address
from customers group by 1,2,3 having count(*) >1;

SELECT customer_id, TRIM(name) as customer_name, TRIM(email) as customer_email, TRIM(address) as customer_address,
 CAST(registration_date as DATE) as registration_date, TRIM(UCASE(segment)) as customer_segment from customers where customer_id;

SELECT * FROM STG_CUSTOMERS;

SELECT MAX(CUSTOMER_ID) FROM CUSTOMERS GROUP BY EMAIL HAVING COUNT(*) >1;

#omite customer_id 
SELECT name as customer_name, email as customer_email, address as customer_address, registration_date, segment FROM customers GROUP BY 1,2,3,4,5 having count(*) = 1;



select * from products;

select name, ucase(category) as category, price, sku from products where product_id is not null group by 1,2,3,4 having count(*) >1;

SELECT UCASE(TRIM(product_id)) as product_id, TRIM(name) as product_name, TRIM(description) as product_description, TRIM(category) as product_category, 
ROUND((CASE WHEN price<0 THEN 0 ELSE price END),2) as product_price, UCASE(TRIM(sku)) as product_sku FROM products WHERE product_id NOT IN (SELECT MAX(product_id) FROM products WHERE product_id IS NOT NULL GROUP BY name, category, price HAVING COUNT(*) >1);

SELECT * FROM STG_PRODUCTS;

-- TEST PARA VALIDAR PRODUCT_ID:
SELECT * FROM STG_PRODUCTS  where product_id  REGEXP '^PROD[0-5]+$';
select distinct product_category from stg_products;
-- ORDERS

select * from orders;

select UCASE(TRIM(order_id)) as order_id, customer_id, CAST(order_date as DATE) as order_date, UCASE(TRIM(order_status)) as order_status, TRIM(payment_method) as payment_method FROM orders;


select * from stg_orders;


SELECT * FROM ORDER_ITEMS;

SELECT UCASE(TRIM(order_id)) as order_id, UCASE(TRIM(product_id)) as product_id, CASE WHEN quantity <0 THEN 0 ELSE quantity END as quantity, 
ROUND((CASE WHEN unit_price <0 THEN 0 ELSE unit_price END), 2) as unit_price,  ROUND((CASE WHEN discount <0 THEN 0 ELSE discount END), 2) as discount FROM order_items;

SELECT * FROM STG_ORDER_ITEMS;


select  * from raw_web_events;

SELECT UCASE(TRIM(session_id)) as web_session_id, customer_id, CONVERT(timestamp, DATETIME) as web_session_date, TRIM(event_type) as web_event_type, 
CASE WHEN TRIM(url) NOT LIKE '/%' THEN CONCAT('/', url) ELSE url END as web_url FROM raw_web_events;


select * from stg_web_events;


-- DIMENSIONAL MODELS:

-- customers:
select * from stg_customers;

SELECT customer_id, customer_name, customer_email, customer_address, registration_date, customer_segment, CURRENT_TIMESTAMP() as load_timestamp FROM stg_customers;


select * from dim_customers;
-- products:

SELECT * FROM STG_PRODUCTS;

SELECT product_id, product_name, product_description, product_category, product_price, product_sku, CURRENT_TIMESTAMP as load_date FROM stg_products;

select * from dim_products;


-- orders

SELECT so.order_id,  dc.customer_id, dp.product_id, soi.quantity,
 ROUND(((soi.quantity * soi.unit_price) -  (soi.quantity * soi.discount)),2) as total_amout, so.order_date, so.order_status, so.payment_method, current_timestamp() as load_date FROM 
stg_orders so JOIN dim_customers as dc on so.customer_id = dc.customer_id JOIN stg_order_items as soi on so.order_id = soi.order_id
JOIN dim_products as dp on soi.product_id = dp.product_id order by cast(substring(so.order_id, 4) as unsigned) asc;

select * from stg_order_items;



select * from fct_orders;


-- AGGREGATE
/**
    SUM(fo.total_amount) AS monthly_total_sales,
    COUNT(DISTINCT fo.customer_sk) AS number_of_unique_customers,
    COUNT(*) AS number_of_orders,
    CURRENT_DATE() AS _load_date
    **/
    
SELECT 
COUNT(*) AS total_number_of_orders,
SUM(total_amout) AS total_sales_by_year,
YEAR(order_date) AS year,
COUNT(DISTINCT customer_id) AS number_of_total_unique_customers,
COUNT(customer_id) AS number_of_total_customers
FROM fct_orders GROUP BY year ORDER BY year;

SELECT * FROM AGG_SALES_BY_YEAR;



-- fix

SELECT customer_id
FROM stg_orders
WHERE customer_id NOT IN (
    SELECT customer_id FROM stg_customers
);

select  count( order_id) from stg_order_items;
-- product_sales_by_category
 SELECT *  FROM fct_orders as fo JOIN stg_products as sp on fo.product_id =  sp.product_id;
 
 SELECT dp.product_category, count(dp.product_name) as total_products, ROUND(SUM(fo.total_amout), 2) as total_amount, count(distinct fo.order_id) as total_orders ,count(distinct fo.customer_id) as total_unique_customers
 from dim_products as dp LEFT JOIN fct_orders as fo on dp.product_id = fo.product_id
 group by  dp.product_category ORDER BY total_amount ASC;
 
 
 
 
 select * from fct_orders;
 
SELECT 
CAST(order_date AS DATE) AS order_day,
COUNT(*) AS total_number_of_orders,
ROUND(SUM(total_amout), 2) AS total_revenue,
ROUND(AVG(total_amout), 2) AS avg_orders_value,
COUNT(DISTINCT customer_id) AS total_unique_customers,
COUNT(customer_id) AS total_customers
FROM fct_orders GROUP BY order_day ORDER BY order_day ASC;


select * from agg_daily_order_summary;

select current_date();

select * from customers;

-- validar correo
select COUNT(*) from customers where REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- validar formato fechas:
select * from orders;
select STR_TO_DATE(order_date, '%Y-%m-%d') as order_date from orders;

select * from fct_orders;

select distinct c.customer_id, c.name, c.segment, fo.order_id, fo.product_id, fo.quantity,  fo.total_amout from customers as c join fct_orders as fo on c.customer_id = fo.customer_id
group by 1,2,3,4,5,6,7;
	



SELECT 
    dc.customer_name,
    SUM(fo.total_amout) AS total_sales_by_year,
    fo.order_date

FROM 
    fct_orders as fo
    JOIN dim_customers as dc on fo.customer_id = dc.customer_id
    group by 1,3;
    
    
    SELECT 
    dc.customer_name,
    CASE 
	WHEN SUM(fo.total_amout) >= 150 THEN 'Premium'
    WHEN SUM(fo.total_amout) >= 100 THEN 'Gold'
    WHEN SUM(fo.total_amout) >= 50 THEN 'Silver' 
    WHEN SUM(fo.total_amout) = 0 THEN 'Inactive' 
    ELSE 'Standard' END as customer_classification,
    YEAR(fo.order_date) AS year,
    SUM(fo.total_amout) AS total_sales_by_year
FROM 
    fct_orders AS fo
JOIN dim_customers AS dc ON fo.customer_id = dc.customer_id
GROUP BY 
    dc.customer_name,
    YEAR(fo.order_date), dc.customer_segment;

    
    
    SELECT * FROM agg_customer_classification_by_spent;