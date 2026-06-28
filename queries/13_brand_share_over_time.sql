-- Query 13: Brand market share over time (top 5 each year)
WITH yearly AS (
    SELECT
        v.brand,
        EXTRACT(YEAR FROM st.transaction_date) AS yr,
        SUM(st.quantity) AS units
    FROM sales_transactions st
    JOIN vehicles v
        ON v.vehicle_id = st.vehicle_id
    GROUP BY
        v.brand,
        EXTRACT(YEAR FROM st.transaction_date)
),

ranked AS (
    SELECT
        brand,
        yr,
        units,
        ROUND(
            100.0 * units / SUM(units) OVER (PARTITION BY yr),
            2
        ) AS market_share_pct,
        ROW_NUMBER() OVER (
            PARTITION BY yr
            ORDER BY units DESC
        ) AS rank_in_year
    FROM yearly
),

top5 AS (
    SELECT *
    FROM ranked
    WHERE rank_in_year <= 5
),

final AS (
    SELECT
        brand,
        yr,
        units,
        market_share_pct,
        LAG(market_share_pct) OVER (
            PARTITION BY brand
            ORDER BY yr
        ) AS prev_year_market_share_pct,
        ROUND(
            market_share_pct
            - LAG(market_share_pct) OVER (
                PARTITION BY brand
                ORDER BY yr
            ),
            2
        ) AS market_share_change_pct
    FROM top5
)

SELECT *
FROM final
ORDER BY brand, yr;
