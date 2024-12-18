WITH
    customer AS (
        SELECT * 
        FROM {{ source('erp', 'customer') }} 
    )
    , source AS (
        SELECT
            CAST(CUSTOMERID AS int) AS pk_customer
            , CAST(PERSONID AS int) AS fk_person
            , CAST(STOREID AS int) AS fk_store
            , CAST(TERRITORYID AS int) AS fk_territory
            , CAST(MODIFIEDDATE AS date) AS modified_date
        FROM customer
    )

SELECT *
FROM source