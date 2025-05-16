
SELECT * FROM {{ref('stg_products')}} WHERE color != CONCAT(UCASE(LEFT(color, 1)), LCASE(SUBSTRING(color, 2))) AND color != "-"