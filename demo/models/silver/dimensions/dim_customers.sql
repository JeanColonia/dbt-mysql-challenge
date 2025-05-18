
{{ config(unique_key='customer_sk')}}

WITH stg_customers 
AS 
    (
      SELECT * FROM {{ref('stg_customers')}}
    )

SELECT 
    customer_id, 
    customer_name, 
    customer_email, 
    customer_address, 
    registration_date, 
    customer_segment, 
    CURRENT_TIMESTAMP() as load_timestamp 
FROM stg_customers