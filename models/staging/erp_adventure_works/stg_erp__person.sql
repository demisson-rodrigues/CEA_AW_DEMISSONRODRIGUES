WITH
    person AS (
        SELECT *
        FROM {{ source('erp', 'person') }}
    )
    , source AS (
        SELECT 
            CAST(BUSINESSENTITYID AS int) AS pk_person
            , CASE
                WHEN MIDDLENAME IS NOT NULL THEN FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME
                ELSE FIRSTNAME || ' ' || LASTNAME
            END AS person_name
            , CASE
                WHEN PERSONTYPE = 'SC' THEN 'Store Contact'
                WHEN PERSONTYPE = 'IN' THEN 'Individual (Retail) Customer'
                WHEN PERSONTYPE = 'SP' THEN 'Sales Person'
                WHEN PERSONTYPE = 'EM' THEN 'Employee (non-sales)'
                WHEN PERSONTYPE = 'VC' THEN 'Vendor Contact'
                WHEN PERSONTYPE = 'GC' THEN 'General Contact'
                ELSE NULL
            END AS person_type
        FROM
            person
    )

SELECT *
FROM source