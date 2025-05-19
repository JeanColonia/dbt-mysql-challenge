

{% macro is_standard_date_format(column, input_date_format='%Y-%m-%d') %}

STR_TO_DATE({{column}}, '{{input_date_format}}')

{% endmacro %}