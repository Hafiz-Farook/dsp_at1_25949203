SELECT
    DATE_TRUNC('month', order_date)::date AS year_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(freight)) AS total_freight
FROM orders
WHERE
    order_date >= DATE '1997-01-01'
    AND order_date < DATE '1999-01-01'   -- covers all of 1997 and 1998
GROUP BY
    DATE_TRUNC('month', order_date)
HAVING
    COUNT(*) > 35
ORDER BY
    total_freight DESC;
