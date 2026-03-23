{{ config(materialized='table') }}

WITH customers AS (
    SELECT
        id AS customer_id,
        firstname,
        lastname
    FROM {{ source('datafeed_shared_schema','raw_customerdata') }}
),

orders AS (
    SELECT
        id AS order_id,
        user_id AS customer_id,
        order_date,
        status
    FROM {{ source('datafeed_shared_schema','raw_orders') }}
),

customer_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(order_id) AS number_of_orders
    FROM orders
    GROUP BY customer_id
),

final AS (
    SELECT
        c.customer_id,
        c.firstname,
        c.lastname,
        co.first_order_date,
        co.most_recent_order_date,
        COALESCE(co.number_of_orders, 0) AS number_of_orders
    FROM customers c
    LEFT JOIN customer_orders co
    ON c.customer_id = co.customer_id
)

SELECT * FROM final
