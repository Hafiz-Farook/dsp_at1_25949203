WITH employee_category_sales AS (
    SELECT
        c.category_name,
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_full_name,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_sales_incl_disc
    FROM employees e
    JOIN orders o
        ON o.employee_id = e.employee_id
    JOIN order_details od
        ON od.order_id = o.order_id
    JOIN products p
        ON p.product_id = od.product_id
    JOIN categories c
        ON c.category_id = p.category_id
    GROUP BY
        c.category_name,
        e.employee_id,
        employee_full_name
),
with_totals AS (
    SELECT
        category_name,
        employee_full_name,
        total_sales_incl_disc,
        SUM(total_sales_incl_disc) OVER (PARTITION BY employee_full_name)
            AS total_sales_employee_all_categories,
        SUM(total_sales_incl_disc) OVER ()
            AS total_sales_all_employees
    FROM employee_category_sales
)
SELECT
    category_name,
    employee_full_name,
    ROUND(total_sales_incl_disc::numeric, 2) AS total_sales_including_discount,
    ROUND(
        (total_sales_incl_disc
            / NULLIF(total_sales_employee_all_categories, 0))::numeric,
        5
    ) AS pct_of_employee_total,
    ROUND(
        (total_sales_incl_disc
            / NULLIF(total_sales_all_employees, 0))::numeric,
        5
    ) AS pct_of_overall_total
FROM with_totals
ORDER BY
    category_name ASC,
    total_sales_including_discount DESC;
