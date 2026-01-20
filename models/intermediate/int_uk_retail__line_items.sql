with sales as (
  select *
  from {{ ref('stg_uk_retail__sales') }}
),

line_items as (
  select
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_ts,
    date(invoice_ts) as invoice_date,
    unit_price,
    customer_id,
    country,

    -- Cancel / return detection (robust for UK Retail)
    case
      when starts_with(cast(invoice_no as string), 'C') then true
      when quantity < 0 then true
      when unit_price < 0 then true
      else false
    end as is_cancelled,

    -- Raw line amount (can be negative for returns; kept for transparency/debug)
    quantity * unit_price as line_amount

  from sales
)

select
  *,
  {{ sale_amount('quantity', 'unit_price', 'is_cancelled') }} as sale_amount
from line_items
