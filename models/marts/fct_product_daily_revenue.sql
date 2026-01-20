with line_items as (
  select *
  from {{ ref('int_uk_retail__line_items') }}
  where not is_cancelled
    and invoice_date is not null
)

select
  invoice_date,
  stock_code,
  any_value(description) as description,
  sum(sale_amount) as revenue,
  sum(quantity) as items_sold,
  count(distinct invoice_no) as orders
from line_items
group by invoice_date, stock_code
order by invoice_date, revenue desc
