WITH
    sales_person AS (
        SELECT *
        FROM {{ source('erp', 'salesperson') }}
    )
    , source AS (
        SELECT
            CAST(BUSINESSENTITYID AS int) AS pk_sales_person
            , CAST(TERRITORYID AS int) AS fk_territory
            , CAST(SALESQUOTA AS int) AS sales_quota
            , CAST(BONUS AS int) AS bonus
            , CAST(COMMISSIONPCT AS numeric(18,4)) AS comission_pct
            , CAST(SALESYTD AS numeric(18, 4)) AS sales_ytd
            , CAST(SALESLASTYEAR AS numeric(18,4)) AS sales_last_year
        FROM
            sales_person
    )

SELECT *
FROM source