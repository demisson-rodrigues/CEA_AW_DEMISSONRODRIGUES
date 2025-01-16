WITH
    dim_product AS (
        SELECT *
        FROM {{ ref('int_sales__product') }}
    )

SELECT *
FROM dim_product