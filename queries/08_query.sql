WITH avg_prices AS (
SELECT
    category_id,
    ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM products
WHERE discontinued = 0
GROUP BY category_id
),
median_prices AS (
SELECT
    category_id,
    ROUND(
        percentile_cont(0.5) WITHIN GROUP (ORDER BY unit_price)::numeric,
        2
    ) AS median_price
FROM products
WHERE discontinued = 0
GROUP BY category_id
)
SELECT
    c.category_name,
    p.product_name,
    p.unit_price,
    a.avg_price AS category_average,
    m.median_price AS category_median,
    CASE
        WHEN p.unit_price < a.avg_price THEN 'Below Average'
        WHEN p.unit_price > a.avg_price THEN 'Over Average'
        ELSE 'Equal Average'
    END AS position_vs_average,
    CASE
        WHEN p.unit_price < m.median_price THEN 'Below Median'
        WHEN p.unit_price > m.median_price THEN 'Over Median'
        ELSE 'Equal Median'
    END AS position_vs_median
FROM products p
JOIN categories c ON c.category_id = p.category_id
JOIN avg_prices a ON a.category_id = p.category_id
JOIN median_prices m ON m.category_id = p.category_id
WHERE p.discontinued = 0
ORDER BY
    c.category_name ASC,
    p.product_name ASC;
