

WITH 
    fct_orders 
AS ( SELECT * FROM {{ref('fct_orders')}} )



SELECT 
    COUNT(*) AS total_number_of_orders,
    SUM(total_amout) AS total_sales_by_year,
    YEAR(order_date) AS year,
    COUNT(DISTINCT customer_id) AS number_of_total_unique_customers,
    COUNT(customer_id) AS number_of_total_customers
FROM 
    fct_orders 
GROUP BY 
    year 
ORDER BY 
    year