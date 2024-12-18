WITH
    product_subcategory AS (
        SELECT *
        FROM {{ source('erp', 'productsubcategory') }}
    )
    , source AS (
        SELECT
            CAST(PRODUCTSUBCATEGORYID AS int) AS pk_product_subcategory
            , CAST(PRODUCTCATEGORYID AS int) AS fk_product_category
            , CAST(NAME AS varchar) AS subcategory_name
        FROM
            product_subcategory
    )

SELECT *
FROM source