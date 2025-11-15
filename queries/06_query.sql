SELECT
    c.category_name,
    CASE
        WHEN od.unit_price < 20 THEN '1. Below $20'
        WHEN od.unit_price BETWEEN 20 AND 50 THEN '2. $20 - $50'
        ELSE '3. Over $50'
    END AS price_range,
    ROUND(
        SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric,
        0
    )::int AS total_amount,
    COUNT(DISTINCT od.order_id) AS order_volume
FROM categories c
JOIN products p
    ON p.category_id = c.category_id
JOIN order_details od
    ON od.product_id = p.product_id
GROUP BY
    c.category_name,
    price_range
ORDER BY
    c.category_name ASC,
    price_range ASC;
