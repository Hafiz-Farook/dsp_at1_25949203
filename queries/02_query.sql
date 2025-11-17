WITH cleaned_orders AS (
    SELECT
        order_id,
        ship_country,

        -- Convert order_date to proper DATE safely
        CASE
            WHEN order_date::text ~ '^\d{8}$'
                THEN TO_DATE(order_date::text, 'YYYYMMDD')
            ELSE order_date::date
        END AS order_dt,

        -- Convert shipped_date to proper DATE safely
        CASE
            WHEN shipped_date::text ~ '^\d{8}$'
                THEN TO_DATE(shipped_date::text, 'YYYYMMDD')
            ELSE shipped_date::date
        END AS shipped_dt
    FROM orders
    WHERE shipped_date IS NOT NULL
)
SELECT
    ship_country AS country,
    ROUND(AVG((shipped_dt - order_dt)::numeric), 2) AS avg_days_between_order_and_ship,
    COUNT(DISTINCT order_id) AS total_orders
FROM cleaned_orders
WHERE EXTRACT(YEAR FROM order_dt) = 1998
GROUP BY ship_country
HAVING
    AVG((shipped_dt - order_dt)) >= 5
    AND COUNT(DISTINCT order_id) > 10
ORDER BY country ASC;

