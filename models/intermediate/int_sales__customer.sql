WITH
    customer AS (
        SELECT *
        FROM {{ ref('stg_erp__customer') }}
    )
    , person AS (
        SELECT *
        FROM {{ ref('stg_erp__person') }}
    )
    , store AS (
        SELECT *
        FROM {{ ref('stg_erp__store') }}
    )
    , territory AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_territory') }}
    )
    , sales_order_header AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_order_header') }}
    )
    , customer_grouped_info AS (
        SELECT
            fk_customer
            , min(order_date) AS first_order_date
            , max(order_date) AS last_order_date
            , count(sk_sales_order_header) AS total_order
        FROM
            sales_order_header
        GROUP BY
            fk_customer
    )
    , data_transformed AS (
        SELECT
            c.pk_customer
            --, p.pk_person AS person_id
            , p.person_name
            --, s.pk_store AS store_id
            , s.store_name
            , t.territory_name
            , cgi.first_order_date
            , cgi.last_order_date
            , cgi.total_order
        FROM customer c
        LEFT JOIN
            person p ON c.fk_person = p.pk_person
        LEFT JOIN
            store s ON c.fk_store = s.pk_store
        LEFT JOIN
            territory t ON c.fk_territory = t.pk_territory
        LEFT JOIN
            customer_grouped_info cgi ON c.pk_customer = cgi.fk_customer
    )

SELECT *
FROM data_transformed