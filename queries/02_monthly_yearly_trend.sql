-- Query 2: Monthly and yearly sales trend (most recent 12 months)
SELECT
    EXTRACT(YEAR  FROM transaction_date) AS sales_year,
    EXTRACT(MONTH FROM transaction_date) AS sales_month,
    SUM(quantity)      AS units_sold,
    SUM(total_revenue) AS revenue
FROM sales_transactions
WHERE transaction_date >= (
    SELECT MAX(transaction_date) - INTERVAL '12 months'
    FROM sales_transactions
)
GROUP BY
    EXTRACT(YEAR FROM transaction_date),
    EXTRACT(MONTH FROM transaction_date)
ORDER BY
    sales_year,
    sales_month;
