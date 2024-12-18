WITH
    sales_order_detail AS (
        SELECT *
        FROM {{ source('erp', 'salesorderdetail') }}
    )
    , source AS (
        SELECT
            CAST(SALESORDERDETAILID AS int) AS pk_sales_order_detail
            , CAST(SALESORDERID AS int) AS fk_sales_order
            , CAST(PRODUCTID AS int) AS fk_product
            , CAST(ORDERQTY AS int) AS order_qty
            , CAST(UNITPRICE AS numeric(18,4)) AS unit_price
            , CAST(UNITPRICEDISCOUNT AS numeric(18,4)) AS unit_price_discount
            , CAST((UNITPRICE * (1 - UNITPRICEDISCOUNT) * ORDERQTY) AS numeric(36,8)) AS line_total
        FROM
            sales_order_detail
    )

SELECT *
FROM source