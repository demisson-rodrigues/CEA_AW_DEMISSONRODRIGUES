WITH
    dim_credit_card AS (
        SELECT *
        FROM {{ ref('int_sales__credit_card') }}
    )

SELECT *
FROM dim_credit_card