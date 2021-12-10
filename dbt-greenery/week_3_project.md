(1) A. Create new models to answer the first two questions (answer questions in README file)

What is our overall conversion rate?

36%
(1) B. What is our conversion rate by product?

check int_conversion_rate_by_product model


(2) We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project.
Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

macros:
  - name: event_type_per_session
    description: Aggregate event_types by session
    docs:
      show: true
    arguments:
      - name: event_types
        type: List[str]
        description: List of possible event types in a session

  - name: grant_select
    description: Apply grants select and usage to a specific role
    docs:
      show: true
    arguments:
      - name: role
        type: str
        description: Name of the role

  - name: month_name
    description: a macro from dbt_date packagefor showing datename portion of a datefield
    docs:
      show: true
    arguments:
      - name: column_name
        type: datefield
        description: a column for date values 

  - name: positive_values
    description: a macro used to verify columns in a table have values <  0
    docs:
      show: true
    arguments:
      - name: model
        type: model
      - name: column_name
        type: integer / float
        description: column containing positive numerical values

  - name: lbs_to_kgs
    description: a macro converting column values from pounds to kilograms
    docs:
      show: true
    arguments:
      - name: column_name
        type: integer
        description: a column for numerical values 
      - name: precision
        type: integer
        description: number of decimal places. Defaults to 2.

(3) We’re starting to think about granting permissions to our dbt models in our postgres database so that other roles can have access to them.

Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running "CREATE ROLE reporting" in your database instance.
NOTE:: After you create the role you still need to grant it usage access on your schema dbt_firstname_lastname which can be done using on-run-end
HINT: you can use the grant macro example from this week and make any necessary changes for postgres syntax

DONE. On-run-end hook created in dbt_project.yml file and role REPORTING is run at the start of the db

