
/** Accuracy test: positive values -> price column from product table**/
select price from {{ref('stg_products')}} where price <0