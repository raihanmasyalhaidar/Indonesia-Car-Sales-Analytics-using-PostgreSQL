-- Query 9: Customer segmentation by age band & income
SELECT
    CASE
        WHEN age < 25                THEN '<25'
        WHEN age BETWEEN 25 AND 34   THEN '25-34'
        WHEN age BETWEEN 35 AND 44   THEN '35-44'
        WHEN age BETWEEN 45 AND 54   THEN '45-54'
        ELSE                              '55+'
    END                              AS age_band,
    c.income_segment,
    COUNT(DISTINCT st.transaction_id) AS purchases,
    SUM(st.total_revenue)             AS revenue
FROM sales_transactions st
JOIN customers c ON c.customer_id = st.customer_id
WHERE c.customer_type = 'Individual'
GROUP BY 1, c.income_segment
ORDER BY revenue DESC;
