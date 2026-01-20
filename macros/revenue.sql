{% macro sale_amount(quantity_col, price_col, cancelled_col) -%}
  case
    when {{ cancelled_col }} then 0
    else coalesce({{ quantity_col }}, 0) * coalesce({{ price_col }}, 0)
  end
{%- endmacro %}
