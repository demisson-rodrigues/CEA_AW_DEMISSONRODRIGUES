WITH
    dim_location AS (
        SELECT *
        FROM {{ ref('int_sales__location') }}
    )

SELECT *
FROM dim_location