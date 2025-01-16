WITH
    sales_reason AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_reason') }}
    )
    , sales_order_header_sales_reason AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_order_header_sales_reason') }}
    )
    , data_transformed AS (
        SELECT
            sohsr.fk_sales_order AS pk_sales_order
            , LISTAGG(DISTINCT sr.reason_name, ' | ') AS reason_name
            --, sr.reason_name
            --, sr.reason_type
        FROM
            sales_order_header_sales_reason sohsr
        LEFT JOIN
            sales_reason sr ON sohsr.fk_sales_reason = sr.pk_sales_reason
        GROUP BY
            sohsr.fk_sales_order
    )

SELECT 
    --{{ dbt_utils.generate_surrogate_key(['sohsr.fk_sales_order', 'sohsr.fk_sales_reason']) }} AS sk_sales_reason
    *
FROM data_transformed
