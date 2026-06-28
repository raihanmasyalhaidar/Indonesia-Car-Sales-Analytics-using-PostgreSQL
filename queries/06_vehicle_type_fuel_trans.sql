-- Query 6: Vehicle type / fuel / transmission performance
SELECT
    v.vehicle_type,
    v.fuel_type,
    v.transmission,
    SUM(st.quantity) AS units_sold,
    ROUND(
        100.0 * SUM(st.quantity)
        / SUM(SUM(st.quantity)) OVER (),
        2
    ) AS share_pct
FROM sales_transactions st
JOIN vehicles v
    ON v.vehicle_id = st.vehicle_id
GROUP BY
    v.vehicle_type,
    v.fuel_type,
    v.transmission
ORDER BY units_sold DESC
LIMIT 10;
