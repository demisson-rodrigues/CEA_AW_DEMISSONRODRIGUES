WITH
    product AS (
        SELECT
            *
        FROM {{ ref('stg_erp__product') }}
    )
    , product_subcategory AS (
        SELECT
            *
        FROM {{ ref('stg_erp__product_subcategory') }}
    )
    , product_category AS (
        SELECT *
        FROM {{ ref('stg_erp__product_category') }}
    )
    , data_transformed AS (
        SELECT
            {{ dbt_utils.generate_surrogate_key(['p.pk_product', 'p.product_name']) }} AS sk_product
            , p.pk_product
            , p.product_name
            , pc.category_name
            , ps.subcategory_name
            , p.product_style
            , p.list_price
            , p.is_discontinued
        FROM
            product p
        LEFT JOIN
            product_subcategory ps ON p.fk_subcategory_product = ps.pk_product_subcategory
        LEFT JOIN
            product_category pc ON ps.fk_product_category = pc.pk_product_category
    )

SELECT *
FROM data_transformed