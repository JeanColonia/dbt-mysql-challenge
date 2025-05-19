

WITH sales_by_category
AS (
    SELECT 
        dp.product_category, 
        count(dp.product_name) AS total_products, 
        ROUND(SUM(fo.total_amout), 2) AS total_amount, count(DISTINCT fo.order_id) AS total_orders, 
        count(DISTINCT fo.customer_id) AS total_unique_customers
    FROM 
        {{ref('dim_products')}} AS dp 
    JOIN 
        {{ref('fct_orders')}} AS fo on dp.product_id = fo.product_id
    GROUP BY  
        dp.product_category
)


SELECT
    product_category, 
    total_products, 
    total_amount, 
    total_orders, 
    total_unique_customers
FROM 
    sales_by_category
GROUP BY  
    product_category
ORDER BY
    total_amount
ASC