WITH
    stateprovince AS (
        SELECT *
        FROM {{ source('erp', 'stateprovince') }}
    )
    , source AS (
        SELECT
            CAST(STATEPROVINCEID AS int) AS pk_state_province
            , CAST(COUNTRYREGIONCODE AS varchar) AS fk_country_region
            , CAST(TERRITORYID AS int) AS fk_sales_territory
            , CAST(NAME AS varchar) AS state_name
            , CAST(STATEPROVINCECODE AS varchar) AS state_province_code
            , ISONLYSTATEPROVINCEFLAG AS is_only_state_province_flag
            , CAST(MODIFIEDDATE AS date) AS modified_date
        FROM
            stateprovince
    )

SELECT *
FROM source