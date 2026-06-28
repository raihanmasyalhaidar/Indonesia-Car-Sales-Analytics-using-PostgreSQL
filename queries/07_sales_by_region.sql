-- Query 7: Sales by region, province, city
SELECT
    d.region,
    d.province,
    d.city,
    SUM(st.quantity)      AS units_sold,
    SUM(st.total_revenue) AS revenue
FROM sales_transactions st
JOIN dealers d ON d.dealer_id = st.dealer_id
GROUP BY d.region, d.province, d.city
ORDER BY units_sold DESC;
