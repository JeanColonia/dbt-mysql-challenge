

WITH sales_by_day 
AS
(
    SELECT 
        {{is_standard_date_format('order_date')}}AS order_day,
        COUNT(*) AS total_number_of_orders,
        ROUND(SUM(total_amout), 2) AS total_revenue,
        ROUND(AVG(total_amout), 2) AS avg_orders_value,
        COUNT(DISTINCT customer_id) AS total_unique_customers,
        COUNT(customer_id) AS total_customers
    FROM 
        {{(ref('fct_orders'))}} 
    GROUP BY 
        order_day 
    ORDER BY 
        order_day 
    ASC
)


    SELECT 
        order_day,
        total_number_of_orders,
        total_revenue,
        avg_orders_value,
        total_unique_customers,
        total_customers
    FROM 
         sales_by_day
    GROUP BY 
        order_day 
    ORDER BY 
        order_day 
    ASC