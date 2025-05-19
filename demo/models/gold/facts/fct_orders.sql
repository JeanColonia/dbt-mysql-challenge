
WITH 
    stg_orders AS ( SELECT * FROM {{ref('stg_orders')}}),
    dim_customers AS ( SELECT * FROM {{ref('dim_customers')}} ),
    dim_products AS (SELECT * FROM {{ref('dim_products')}}),
    stg_order_items AS (SELECT * FROM {{ref('stg_order_items')}}),
    fct_orders_query AS (
        SELECT 
            so.order_id,  
            dc.customer_id, 
            dp.product_id, 
            soi.quantity,
            ROUND(((soi.quantity * soi.unit_price) -  (soi.quantity * soi.discount)),2) as total_amout, 
            so.order_date, 
            so.order_status, 
            so.payment_method, 
            current_timestamp() as load_date 
        FROM 
            stg_orders so 
        JOIN 
            dim_customers as dc on so.customer_id = dc.customer_id 
        JOIN 
            stg_order_items as soi on so.order_id = soi.order_id
        JOIN 
            dim_products as dp on soi.product_id = dp.product_id 
        ORDER BY 
            so.order_id 
        ASC
    )

SELECT * FROM fct_orders_query

