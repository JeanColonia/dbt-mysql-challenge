


WITH raw_web_events AS 
    (
     SELECT * FROM {{ref('raw_web_events')}}
    )


SELECT 
    UCASE(TRIM(session_id)) as web_session_id, 
    customer_id, CONVERT(timestamp, DATETIME) as web_session_date, 
    TRIM(event_type) as web_event_type, 
    CASE WHEN TRIM(url) NOT LIKE '/%' THEN CONCAT('/', url) ELSE url END as web_url
FROM raw_web_events