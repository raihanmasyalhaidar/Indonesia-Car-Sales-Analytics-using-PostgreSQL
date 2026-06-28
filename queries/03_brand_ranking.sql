-- Query 3: Brand ranking by units and by revenue
SELECT
    v.brand,
    SUM(st.quantity)                              AS units_sold,
    SUM(st.total_revenue)                         AS revenue,
    RANK() OVER (ORDER BY SUM(st.quantity)      DESC) AS rank_by_units,
    RANK() OVER (ORDER BY SUM(st.total_revenue) DESC) AS rank_by_revenue
FROM sales_transactions st
JOIN vehicles v ON v.vehicle_id = st.vehicle_id
GROUP BY v.brand
ORDER BY units_sold DESC
LIMIT 10;
