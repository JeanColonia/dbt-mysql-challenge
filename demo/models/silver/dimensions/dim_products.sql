
WITH 
    stg_products
AS
    (SELECT * FROM {{ ref('stg_products') }})



SELECT 
    product_id, 
    product_name, 
    product_description, 
    product_category, 
    product_price, 
    product_sku, 
    CURRENT_TIMESTAMP as load_date 
FROM
    stg_products