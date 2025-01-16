WITH
    product_category AS (
        SELECT *
        FROM {{ source('erp', 'productcategory') }}
    )
    , source AS (
        SELECT
            CAST(PRODUCTCATEGORYID AS int) AS pk_product_category
            , CAST(NAME AS varchar) AS category_name
        FROM
            product_category
    )

SELECT *
FROM source