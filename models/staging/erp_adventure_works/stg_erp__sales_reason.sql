WITH
    sales_reason AS (
        SELECT *
        FROM {{ source('erp', 'salesreason') }}
    )
    , source AS (
        SELECT
            CAST(SALESREASONID AS int) AS pk_sales_reason
            , CAST(NAME AS varchar) AS reason_name
            , CAST(REASONTYPE AS varchar) AS reason_type
        FROM
            sales_reason
    )

SELECT *
FROM source