WITH
    address AS (
        SELECT *
        FROM {{ source('erp', 'address') }}
    )
    , source AS (
        SELECT
            CAST(ADDRESSID AS int) AS pk_address
            , CAST(STATEPROVINCEID AS int) AS fk_state_province
            , CAST(ADDRESSLINE1 AS varchar) AS address_line_1
            , CAST(ADDRESSLINE2 AS varchar) AS address_line_2
            , CAST(CITY AS varchar) AS city_name
            , CAST(POSTALCODE AS varchar) AS postal_code
            , CAST(SPATIALLOCATION AS varchar) AS spatial_location
            , CAST(MODIFIEDDATE AS date) AS modified_date
        FROM
            address
    )

SELECT *
FROM source