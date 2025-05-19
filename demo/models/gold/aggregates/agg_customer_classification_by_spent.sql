


WITH 
fct_orders AS (SELECT * FROM {{ref('fct_orders')}}),
dim_customers  AS (SELECT * FROM {{ref('dim_customers')}})


  SELECT 
    dc.customer_name,
    {{classification_by_spent('fo.total_amout')}} as customer_classification,
    YEAR(fo.order_date) AS year,
    SUM(fo.total_amout) AS total_sales_by_year
FROM 
    fct_orders AS fo
JOIN dim_customers AS dc ON fo.customer_id = dc.customer_id
GROUP BY 
    dc.customer_name,
    YEAR(fo.order_date), dc.customer_segment
