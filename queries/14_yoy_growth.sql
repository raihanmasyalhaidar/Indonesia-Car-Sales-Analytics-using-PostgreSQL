-- Query 14: Company YoY units & revenue growth
WITH yr AS (
    SELECT
        EXTRACT(YEAR FROM transaction_date) AS sales_year,
        SUM(quantity)      AS units,
        SUM(total_revenue) AS revenue
    FROM sales_transactions
    GROUP BY EXTRACT(YEAR FROM transaction_date)
)
SELECT
    sales_year,
    units,
    revenue,
    ROUND(100.0 * (units - LAG(units) OVER (ORDER BY sales_year))
        / NULLIF(LAG(units) OVER (ORDER BY sales_year), 0), 1) AS units_yoy_pct,
    ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY sales_year))
        / NULLIF(LAG(revenue) OVER (ORDER BY sales_year), 0), 1) AS revenue_yoy_pct
FROM yr
ORDER BY sales_year;
