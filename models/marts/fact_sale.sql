WITH
    fact_sale AS (
        SELECT *
        FROM {{ ref('int_sales__sale') }}
    )

SELECT *
FROM fact_sale