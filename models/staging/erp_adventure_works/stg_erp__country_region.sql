WITH
    countryregion AS (
        SELECT *
        FROM {{ source('erp', 'countryregion') }}
    )
    , source AS (
        SELECT
            CAST(COUNTRYREGIONCODE AS varchar) AS pk_country_region
            , CAST(NAME AS varchar) AS country_name
            , CAST(MODIFIEDDATE AS date) AS modified_date
        FROM
            countryregion
    )

SELECT *
FROM source