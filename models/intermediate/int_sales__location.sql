WITH
    sales_order_header AS (
        SELECT
            DISTINCT(fk_ship_to_address)
        FROM
            {{ ref('stg_erp__sales_order_header') }}
    )
    , address AS (
        SELECT *
        FROM {{ ref('stg_erp__address') }}
    )
    , state_province AS (
        SELECT *
        FROM {{ ref('stg_erp__state_province') }}
    )
    , country_region AS (
        SELECT *
        FROM {{ ref('stg_erp__country_region') }}
    )
    , data_transformed AS (
        SELECT
            {{ dbt_utils.generate_surrogate_key(['soh.fk_ship_to_address']) }} AS sk_sales_order_header
            , soh.fk_ship_to_address AS pk_location
            , a.city_name
            , sp.state_name
            , cr.country_name
        FROM
            sales_order_header soh
        LEFT JOIN
            address a ON soh.fk_ship_to_address = a.pk_address
        LEFT JOIN
            state_province sp ON a.fk_state_province = sp.pk_state_province
        LEFT JOIN
            country_region cr ON sp.fk_country_region = cr.pk_country_region
    )

SELECT *
FROM data_transformed