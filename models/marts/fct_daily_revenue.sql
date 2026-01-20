with line_items as (
    select * from {{ ref('int_uk_retail__line_items') }}
    where not is_cancelled
      and invoice_date is not null
),

daily_revenue as (
    select
        invoice_date,
        sum(sale_amount) as revenue,
        count(distinct invoice_no) as orders,
        sum(quantity) as items_sold,
        count(distinct customer_id) as customers
    from line_items
    group by invoice_date
)

select * from daily_revenue
order by invoice_date
