WITH
    store AS (
        SELECT *
        FROM {{ source('erp', 'store') }}
    )
    , source AS (
        SELECT
            CAST(BUSINESSENTITYID AS int) AS pk_store
            , CAST(SALESPERSONID AS int) AS fk_sales_person
            , CAST(NAME AS varchar) AS store_name
        FROM store
    )

SELECT *
FROM source