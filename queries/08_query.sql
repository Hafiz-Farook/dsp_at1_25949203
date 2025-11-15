WITH product_stats AS (
    SELECT
        c.category_name,
        p.product_name,
        p.unit_price,
        AVG(p.unit_price) OVER (PARTITION BY p.category_id) AS avg_unit_price_cat,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY p.unit_price)
            OVER (PARTITION BY p.category_id) AS median_unit_price_cat
    FROM products p
    JOIN categories c
        ON c.category_id = p.category_id
    WHERE
        p.discontinued = 0
)
SELECT
    category_name,
    product_name,
    unit_price,
    ROUND(avg_unit_price_cat::numeric, 2) AS category_avg_unit_price,
    ROUND(median_unit_price_cat::numeric, 2) AS category_median_unit_price,
    CASE
        WHEN unit_price < avg_unit_price_cat THEN 'Below Average'
        WHEN unit_price > avg_unit_price_cat THEN 'Over Average'
        ELSE 'Equal Average'
    END AS position_vs_average,
    CASE
        WHEN unit_price < median_unit_price_cat THEN 'Below Median'
        WHEN unit_price > median_unit_price_cat THEN 'Over Median'
        ELSE 'Equal Median'
    END AS position_vs_median
FROM product_stats
ORDER BY
    category_name ASC,
    product_name ASC;
