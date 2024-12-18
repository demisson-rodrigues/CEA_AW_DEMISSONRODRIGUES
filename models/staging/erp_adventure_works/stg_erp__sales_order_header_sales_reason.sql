WITH
    sales_order_header_sales_reason AS (
        SELECT *
        FROM {{ source('erp', 'salesorderheadersalesreason') }}
    )
    , source AS (
        SELECT
            CAST(SALESORDERID AS int) AS fk_sales_order
            , CAST(SALESREASONID AS int) AS fk_sales_reason
        FROM
            sales_order_header_sales_reason
    )

SELECT *
FROM source