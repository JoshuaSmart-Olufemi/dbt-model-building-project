{{
  config(
    materialized='table'
  )
}}

{% macro grant_permissions(role_name) %}

    {% set sql %}
      GRANT USAGE ON SCHEMA {{ schema }} TO ROLE {{ role_name}};
      GRANT SELECT ON {{ this }} TO ROLE {{ role_name }};
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}