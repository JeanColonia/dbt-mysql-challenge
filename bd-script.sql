
CREATE SCHEMA dbt_demo_db;

use dbt_demo_db;


SELECT * FROM CUSTOMERS;

SELECT name, email, address
from customers group by 1,2,3 having count(*) >1;

SELECT customer_id, TRIM(name) as customer_name, TRIM(email) as customer_email, TRIM(address) as customer_address,
 CAST(registration_date as DATE) as registration_date, TRIM(UCASE(segment)) as customer_segment from customers where customer_id  not in (SELECT MAX(customer_id)
FROM customers WHERE customer_id IS NOT NULL
GROUP BY name, email, address 
HAVING COUNT(*) > 1);

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
SELECT * FROM STG_PRODUCTS  where product_id  REGEXP '^PROD[0-9]+$';

-- ORDERS

select * from orders;

select UCASE(TRIM(order_id)) as order_id, customer_id, CAST(order_date as DATE) as order_date, UCASE(TRIM(order_status)) as order_status, TRIM(payment_method) as payment_method FROM orders;


select * from stg_orders;


SELECT * FROM ORDER_ITEMS;

SELECT UCASE(TRIM(order_id)) as order_id, UCASE(TRIM(product_id)) as product_id, CASE WHEN quantity <0 THEN 0 ELSE quantity END as quantity, 
ROUND((CASE WHEN unit_price <0 THEN 0 ELSE unit_price END), 2) as unit_price,  ROUND((CASE WHEN discount <0 THEN 0 ELSE discount END), 2) as discount FROM order_items;

SELECT * FROM STG_ORDER_ITEMS;