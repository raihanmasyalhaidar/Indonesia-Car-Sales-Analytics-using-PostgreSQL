-- Query 8: Dealer-expansion opportunity by province
WITH prov AS (
    SELECT
        d.province,
        SUM(st.quantity)              AS units_sold,
        COUNT(DISTINCT d.dealer_id)   AS dealer_count
    FROM sales_transactions st
    JOIN dealers d ON d.dealer_id = st.dealer_id
    GROUP BY d.province
)
SELECT
    province,
    units_sold,
    dealer_count,
    ROUND(units_sold * 1.0 / dealer_count, 1) AS units_per_dealer,
    CASE
        WHEN units_sold * 1.0 / dealer_count >
             AVG(units_sold * 1.0 / dealer_count) OVER ()
        THEN 'Expansion Candidate'
        ELSE 'Adequately Served'
    END AS recommendation
FROM prov
ORDER BY units_per_dealer DESC;
