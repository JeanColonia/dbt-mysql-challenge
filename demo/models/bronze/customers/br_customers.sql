

/* Creating view in DB (w.o modifying raw data) **/
select * from {{source('dbt-demo', 'customers')}}