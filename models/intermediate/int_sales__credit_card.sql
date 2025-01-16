WITH
    credit_card AS (
        SELECT *
        FROM {{ ref('stg_erp__credit_card') }}
    )
    , data_transformed AS (
        SELECT 
            pk_credit_card
            , card_type
        FROM credit_card
    )

SELECT *
FROM data_transformed