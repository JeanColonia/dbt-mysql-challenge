


WITH 
fct_orders AS (SELECT * FROM {{ref('fct_orders')}}),
dim_customers  AS (SELECT * FROM {{ref('dim_customers')}})


  SELECT 
    dc.customer_name,
    CASE 
	WHEN SUM(fo.total_amout) >= 150 THEN 'Premium'
    WHEN SUM(fo.total_amout) >= 100 THEN 'Gold'
    WHEN SUM(fo.total_amout) >= 50 THEN 'Silver' 
    ELSE 'Standard' END as customer_classification,
    YEAR(fo.order_date) AS order_year,
    SUM(fo.total_amout) AS total_sales_by_year
FROM 
    fct_orders AS fo
JOIN dim_customers AS dc ON fo.customer_id = dc.customer_id
GROUP BY 
    dc.customer_name,
    YEAR(fo.order_date), dc.customer_segment
