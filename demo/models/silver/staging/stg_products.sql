

WITH raw_products AS (
    SELECT * FROM {{ref('raw_products')}}
    
)

SELECT 
    UCASE(TRIM(product_id)) as product_id, 
    TRIM(name) as product_name, 
    TRIM(description) as product_description, 
    TRIM(category) as product_category, 
    ROUND((CASE WHEN price < 0 THEN 0 ELSE price END),2) as product_price, 
    UCASE(TRIM(sku)) as product_sku 
FROM raw_products 
WHERE product_id 
NOT IN 
    (   SELECT 
            MAX(product_id) 
        FROM raw_products 
        WHERE product_id IS NOT NULL 
        GROUP BY name, category, price 
        HAVING COUNT(*) >1
    )