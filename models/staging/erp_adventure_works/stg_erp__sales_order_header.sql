WITH
    sales_order_header AS (
        SELECT *
        FROM {{ source('erp', 'salesorderheader') }}
    )
    , source AS (
        SELECT
            {{ dbt_utils.generate_surrogate_key(['SALESORDERID', 'SALESPERSONID']) }} AS sk_sales_order_header
            , CAST(SALESORDERID AS int) AS fk_sales_order
            , CAST(CUSTOMERID AS int) AS fk_customer
            , CAST(TERRITORYID AS int) AS fk_territory
            , CAST(SALESPERSONID AS int) AS fk_sales_person
            , CAST(SHIPTOADDRESSID AS int) AS fk_ship_to_address
            , CAST(ORDERDATE AS date) AS order_date
            , CAST(DUEDATE AS date) AS due_date
            , CAST(SHIPDATE AS date) AS ship_date
            , CASE
                WHEN STATUS = 1 THEN 'In Process'
                WHEN STATUS = 2 THEN 'Approved'
                WHEN STATUS = 3 THEN 'Backordered'
                WHEN STATUS = 4 THEN 'Rejected'
                WHEN STATUS = 5 THEN 'Shipped'
                WHEN STATUS = 6 THEN 'Cancelled'
                ELSE NULL
            END AS order_status
            , CASE
                WHEN ONLINEORDERFLAG THEN 'Online'
                ELSE 'Store'
            END AS ordered_online
            , CAST(SUBTOTAL AS numeric(18,4)) AS subtotal
            , CAST(TAXAMT AS numeric(18,4)) AS tax
            , CAST(FREIGHT AS numeric(18,4)) AS freight
            , CAST(TOTALDUE AS numeric(18,4)) AS total_due
        FROM sales_order_header
    )

SELECT *
FROM source