-- Query 11: Cash vs Credit and financing profile
SELECT
    st.payment_method,
    COUNT(*)                       AS transactions,
    ROUND(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER (), 1) AS share_pct,
    ROUND(AVG(f.down_payment))     AS avg_down_payment,
    ROUND(AVG(f.tenor_months), 1)  AS avg_tenor_months,
    ROUND(AVG(f.interest_rate), 2) AS avg_interest_rate
FROM sales_transactions st
LEFT JOIN financing f ON f.transaction_id = st.transaction_id
GROUP BY st.payment_method;
