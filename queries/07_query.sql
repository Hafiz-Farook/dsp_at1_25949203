SELECT
    CASE
        WHEN s.country IN ('USA','Canada','Brazil','Mexico','Argentina','Venezuela')
            THEN 'America'
        WHEN s.country IN (
            'UK','United Kingdom','Germany','France','Spain','Italy','Belgium',
            'Norway','Sweden','Finland','Denmark','Ireland','Portugal',
            'Austria','Switzerland','Poland','Netherlands'
        ) THEN 'Europe'
        ELSE 'Asia-Pacific'
    END AS supplier_region,
    c.category_name,
    SUM(p.unit_in_stock) AS total_units_in_stock,
    SUM(p.unit_on_order) AS total_units_on_order,
    SUM(p.reorder_level) AS total_reorder_level
FROM suppliers s
JOIN products p
    ON p.supplier_id = s.supplier_id
JOIN categories c
    ON c.category_id = p.category_id
GROUP BY
    supplier_region,
    c.category_name
ORDER BY
    c.category_name ASC,
    supplier_region ASC,
    total_reorder_level ASC;
