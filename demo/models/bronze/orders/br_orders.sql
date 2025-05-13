
/* Creating view in DB (w.o modifying raw data) **/
-- Usando ref porque la fuente es un archivo que gestiona y controla dbt, caso contrario source().

SELECT * FROM {{ ref('orders')}}