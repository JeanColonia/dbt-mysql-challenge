
with raw_customers as(
    select * from {{ref('raw_customers')}}
)


SELECT customer_id, TRIM(name) as customer_name, TRIM(email) as customer_email, TRIM(address) as customer_address, CAST(registration_date as DATE) as registration_date, TRIM(UCASE(segment)) as customer_segment from raw_customers where customer_id  not in (SELECT MAX(customer_id)
FROM raw_customers WHERE customer_id IS NOT NULL
GROUP BY name, email, address 
HAVING COUNT(*) > 1)
