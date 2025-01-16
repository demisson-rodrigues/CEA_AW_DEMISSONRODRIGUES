WITH
    dim_sales_reason AS (
        SELECT *
        FROM {{ ref('int_sales__sales_reason') }}
    )

SELECT *
FROM dim_sales_reason