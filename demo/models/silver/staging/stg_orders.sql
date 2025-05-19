

WITH 
    raw_orders 
AS 
    (
    SELECT * FROM {{ref('raw_orders')}}
    )


select 
    UCASE(TRIM(order_id)) as order_id, 
    customer_id, 
    {{is_standard_date_format('order_date')}} as order_date, 
    UCASE(TRIM(order_status)) as order_status, 
    TRIM(payment_method) as payment_method
FROM raw_orders