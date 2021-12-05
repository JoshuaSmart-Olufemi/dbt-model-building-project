

{% macro grant_select(role) %}

    {% set sql %}
      
      GRANT SELECT ON {{ this }} TO reporting;
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}