WITH
    customer AS (
        SELECT *
        FROM {{ ref('int_sales__customer') }}
    )
    , location AS (
        SELECT *
        FROM {{ ref('int_sales__location') }}
    )
    , product AS (
        SELECT *
        FROM {{ ref('int_sales__product') }}
    )
    -- , sales_reason AS (
    --     SELECT *
    --     FROM {{ ref('int_sales__sales_reason') }}
    -- )
    , territory AS (
        SELECT *
        FROM {{ ref('stg_erp__address') }}
    )
    , sales_order_detail AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_order_details') }}
    )
    , sales_order_header AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_order_header') }}
    )
    , data_transformed AS (
        SELECT
            {{ dbt_utils.generate_surrogate_key(['sod.pk_sales_order_detail', 'sod.fk_sales_order']) }} AS sk_sales
            , sod.pk_sales_order_detail
            , sod.fk_sales_order
            , soh.fk_customer
            , sod.fk_product
            , soh.fk_ship_to_address
            , soh.fk_credit_card

            , sod.order_qty
            , sod.unit_price
            , sod.unit_price_discount
            , sod.line_total

            , soh.order_date
            , soh.due_date
            , soh.ship_date
            , soh.order_status
            , soh.ordered_online
            , soh.subtotal
            , soh.tax
            , soh.freight
            , soh.total_due
            , soh.modified_date
        FROM
            sales_order_detail sod
        LEFT JOIN
            sales_order_header soh ON sod.fk_sales_order = soh.fk_sales_order
        LEFT JOIN
            customer c ON soh.fk_customer = c.pk_customer
        LEFT JOIN
            location l ON soh.fk_ship_to_address = l.pk_location
        LEFT JOIN
            product p ON sod.fk_product = p.pk_product
    )

SELECT *
FROM data_transformed