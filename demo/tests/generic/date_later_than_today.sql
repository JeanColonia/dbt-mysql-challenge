{% test date_later_than_today(model, column_name) %}

SELECT * FROM {{model}} WHERE {{column_name}} > CURRENT_DATE()

{% endtest %}