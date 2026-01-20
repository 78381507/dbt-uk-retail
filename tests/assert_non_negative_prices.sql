select *
from {{ ref('int_uk_retail__line_items') }}
where sale_amount < 0
