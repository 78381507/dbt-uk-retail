with source as (
    select * from {{ source('raw', 'online_retail') }}
),

renamed as (
    select
        InvoiceNo as invoice_no,
        StockCode as stock_code,
        Description as description,
        Quantity as quantity,
        safe.parse_timestamp('%m/%d/%y %k:%M', InvoiceDate) as invoice_ts,
        UnitPrice as unit_price,
        cast(CustomerID as int64) as customer_id,
        Country as country
    from source
    where InvoiceDate is not null
)

select * from renamed