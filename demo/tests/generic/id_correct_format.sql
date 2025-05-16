

{% test id_correct_format(model, column_name) %}

SELECT * FROM {{model}} where {{column_name}} not REGEXP '^[0-9]+$'

{% endtest %}
