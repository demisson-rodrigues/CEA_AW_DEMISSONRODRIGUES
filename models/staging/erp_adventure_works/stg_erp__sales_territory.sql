WITH
    territory AS (
        SELECT *
        FROM {{ source('erp', 'salesterritory') }}
    )
    , source AS (
        SELECT
            CAST(TERRITORYID AS int) AS pk_territory
            , CAST(COUNTRYREGIONCODE AS varchar) AS fk_country_region_code
            , CAST(NAME AS varchar) AS territory_name
            , CAST("group" AS varchar) AS "group"
            , CAST(SALESYTD AS numeric(18, 4)) AS sales_ytd
            , CAST(SALESLASTYEAR AS numeric(18, 4)) AS sales_last_year
            , CAST(COSTYTD AS int) AS cost_ytd
            , CAST(COSTLASTYEAR AS int) AS cost_last_year
            , CAST(MODIFIEDDATE AS date) AS modified_date
        FROM territory
    )

SELECT *
FROM source