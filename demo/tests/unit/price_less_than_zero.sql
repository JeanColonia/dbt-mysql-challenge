
/** Accuracy test: positive values -> price column from product table**/
select product_price from {{ref('stg_products')}} where product_price <0