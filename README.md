# dbt UK Retail — Analytics Engineering Demo (BigQuery)

Small, production-minded dbt project using the UK Retail dataset to showcase clean modeling, data quality, and reusable logic.

## What this project demonstrates
- dbt structure: **staging → intermediate → marts**
- Business marts: **daily revenue**, **customer dimension**, **product daily revenue**
- Data quality: schema tests (not_null/unique) + 1 custom test
- Reusable logic via a simple macro (`sale_amount`)

## Dataset
UK Retail transactions with columns: Invoice, StockCode, Description, Quantity, InvoiceDate, Price, CustomerID, Country.

## How to run
    dbt deps
    dbt build
    dbt docs generate
    dbt docs serve

## Models
- **stg_uk_retail__sales**  
  Typing/renaming + light cleaning.
- **int_uk_retail__line_items**  
  Business logic (cancellations/returns) + standardized `sale_amount`.
- **dim_customers**  
  Customer metrics: first/last purchase, orders_count, total_revenue.
- **fct_daily_revenue**  
  Daily KPIs: revenue, orders, items_sold, customers.
- **fct_product_daily_revenue**  
  Daily KPIs per product: revenue, orders, items_sold.

## Tests
- Schema tests on key fields (not_null/unique) defined in `staging.yml`, `intermediate.yml`, `marts.yml`
- Custom data test: **assert_non_negative_prices** (ensures non-negative `sale_amount`)
