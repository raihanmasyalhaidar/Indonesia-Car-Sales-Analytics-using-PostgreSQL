-- Query 5: Best-selling car models (top 10)
SELECT
    v.brand,
    v.model,
    SUM(st.quantity)      AS units_sold,
    SUM(st.total_revenue) AS revenue
FROM sales_transactions st
JOIN vehicles v ON v.vehicle_id = st.vehicle_id
GROUP BY v.brand, v.model
ORDER BY units_sold DESC
LIMIT 10;
