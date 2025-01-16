/*  
    This test ensures that the 2011 gross 
    sales are correct with the audited accounting value: 
    $ 12.646.112,16
*/

WITH
    sales_2011 AS (
        SELECT
            SUM((order_qty * unit_price)) as sum_total_sales
        FROM
            {{ ref('int_sales__sale') }}
        WHERE
            extract(year from order_date) = 2011
    )

SELECT
    sum_total_sales
FROM
    sales_2011
WHERE
    sum_total_sales NOTBETWEEN '12646112.00' AND '12646113.00'