
WITH raw_customers AS(
    SELECT * FROM {{ref('raw_customers')}}
)


SELECT 
    customer_id, 
    TRIM(name) as customer_name, 
    TRIM(email) as customer_email, 
    TRIM(address) as customer_address, 
    {{is_standard_date_format('registration_date')}} as registration_date, 
    TRIM(UCASE(segment)) as customer_segment 
FROM raw_customers 
WHERE customer_id  
NOT IN (
        SELECT MAX(customer_id)
        FROM raw_customers 
        WHERE customer_id IS NOT NULL
        GROUP BY name, email, address 
        HAVING COUNT(*) > 1
       )
AND
    {{is_valid_mail_format('email')}}
