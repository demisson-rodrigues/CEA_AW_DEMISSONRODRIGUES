WITH
    product_category AS (
        SELECT *
        FROM {{ source('erp', 'productcategory') }}
    )
    , source AS (
        SELECT
            CAST(PRODUCTCATEGORYID AS int) AS pk_product_subcategory
            , CAST(NAME AS varchar) AS product_category_name
        FROM
            product_category
    )

SELECT *
FROM source