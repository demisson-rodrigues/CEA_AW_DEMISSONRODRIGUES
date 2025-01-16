WITH
    dim_customer AS (
        SELECT *
        FROM {{ ref('int_sales__customer') }}
    )

SELECT *
FROM dim_customer