with fact_page_views as (

    select *
    from {{ref('int_page_views')}}
    
)

select * from fact_page_views