-- Query 4: Brand market share (% of total units)
SELECT
    v.brand,
    SUM(st.quantity)                                       AS units_sold,
    ROUND(100.0 * SUM(st.quantity)
        / SUM(SUM(st.quantity)) OVER (), 2)                AS market_share_pct
FROM sales_transactions st
JOIN vehicles v ON v.vehicle_id = st.vehicle_id
GROUP BY v.brand
ORDER BY market_share_pct DESC;
