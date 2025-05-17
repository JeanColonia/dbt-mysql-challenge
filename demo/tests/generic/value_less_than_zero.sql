
/** ACCURACY TEST: positive values -> product price, stock **/

{% test value_less_than_zero(model, column_name) %}

SELECT * FROM {{model}} WHERE {{column_name}}<0

{% endtest %}