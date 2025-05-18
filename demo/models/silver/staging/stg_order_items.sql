
WITH raw_order_items
AS 
(
    SELECT * FROM {{(ref('raw_order_items'))}}
)


SELECT 
    UCASE(TRIM(order_id)) as order_id, 
    UCASE(TRIM(product_id)) as product_id, 
    CASE WHEN quantity <0 THEN 0 ELSE quantity END as quantity, 
    ROUND( (CASE WHEN unit_price <0 THEN 0 ELSE unit_price END), 2) as unit_price,  
    ROUND((CASE WHEN discount <0 THEN 0 ELSE discount END), 2) as discount 
FROM raw_order_items