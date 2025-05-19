

{% macro is_valid_mail_format(column) %}

{{column}} REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'

{% endmacro %}
