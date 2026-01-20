with line_items as (
    select * from {{ ref('int_uk_retail__line_items') }}
    where not is_cancelled
      and customer_id is not null
),

customers as (
    select
        customer_id,
        any_value(country) as country,
        min(invoice_date) as first_purchase_date,
        max(invoice_date) as last_purchase_date,
        count(distinct invoice_no) as orders_count,
        sum(sale_amount) as total_revenue
    from line_items
    group by customer_id
)

select * from customers
order by total_revenue desc