WITH
    product AS (
        SELECT *
        FROM {{ source('erp', 'product') }}
    )
    , source AS (
        SELECT
            CAST(PRODUCTID AS int) AS pk_product
            , CAST(PRODUCTSUBCATEGORYID AS int) AS fk_subcategory_product
            , CAST(NAME AS varchar) AS product_name
            , CAST(COLOR AS varchar) AS product_color
            , CAST(STANDARDCOST AS numeric(18,4)) AS standard_cost
            , CAST(LISTPRICE AS numeric(18,4)) AS list_price
            , CASE
                WHEN PRODUCTLINE = 'R' THEN 'Road'
                WHEN PRODUCTLINE = 'M' THEN 'Mountain'
                WHEN PRODUCTLINE = 'T' THEN 'Touring'
                WHEN PRODUCTLINE = 'S' THEN 'Standard'
                ELSE NULL
            END AS product_line
            , CASE
                WHEN CLASS = 'H' THEN 'High'
                WHEN CLASS = 'M' THEN 'Medium'
                WHEN CLASS = 'L' THEN 'Low'
                ELSE NULL
            END AS product_class
            , CASE
                WHEN STYLE = 'W' THEN 'Womens'
                WHEN STYLE = 'M' THEN 'Mens'
                WHEN STYLE = 'U' THEN 'Universal'
                ELSE NULL
            END AS product_style
            , CAST(SELLSTARTDATE AS date) AS sell_start_date
            , CAST(SELLENDDATE AS date) AS sell_end_date
            --, CAST(DISCONTINUEDDATE AS date) AS discontinued_date
        FROM
            product
    )

SELECT *
FROM source