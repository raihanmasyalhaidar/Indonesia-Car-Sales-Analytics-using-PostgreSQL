-- Query 10: Average price, discount & discount rate by brand
SELECT
    v.brand,
    ROUND(AVG(st.unit_price))                          AS avg_list_price,
    ROUND(AVG(st.discount_amount))                     AS avg_discount,
    ROUND(100.0 * SUM(st.discount_amount)
        / NULLIF(SUM(st.quantity * st.unit_price), 0), 2) AS discount_rate_pct,
    SUM(st.total_revenue)                              AS net_revenue
FROM sales_transactions st
JOIN vehicles v ON v.vehicle_id = st.vehicle_id
GROUP BY v.brand
ORDER BY discount_rate_pct DESC;
