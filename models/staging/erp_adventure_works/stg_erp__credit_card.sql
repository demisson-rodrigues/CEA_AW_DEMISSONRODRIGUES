WITH
    credit_card AS (
        SELECT *
        FROM {{ source('erp', 'creditcard') }}
    )
    , source AS (
        SELECT
            CAST(CREDITCARDID AS int) AS pk_credit_card
            , CAST(CARDTYPE AS varchar) AS card_type
        FROM credit_card
    )

SELECT *
FROM source