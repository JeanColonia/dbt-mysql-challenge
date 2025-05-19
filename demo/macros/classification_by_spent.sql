

{% macro classification_by_spent(column) %}

    CASE 
	WHEN SUM({{column}}) >= 150 THEN 'Premium'
    WHEN SUM({{column}}) >= 100 THEN 'Gold'
    WHEN SUM({{column}}) >= 50 THEN 'Silver' 
    ELSE 'Standard' END 
{% endmacro %}