-- Query 12: Marketing campaign ROI (top 12)
WITH campaign_rev AS (
    SELECT
        mc.campaign_id,
        mc.campaign_name,
        mc.brand,
        mc.campaign_channel,
        mc.campaign_cost,
        SUM(st.total_revenue) AS revenue_during
    FROM marketing_campaigns mc
    JOIN vehicles v ON v.brand = mc.brand
    JOIN sales_transactions st
          ON st.vehicle_id       = v.vehicle_id
         AND st.transaction_date BETWEEN mc.start_date AND mc.end_date
    GROUP BY mc.campaign_id, mc.campaign_name, mc.brand,
             mc.campaign_channel, mc.campaign_cost
)
SELECT
    campaign_name,
    brand,
    campaign_channel,
    campaign_cost,
    revenue_during,
    ROUND((revenue_during - campaign_cost) / NULLIF(campaign_cost, 0), 2) AS roi
FROM campaign_rev
ORDER BY roi DESC
LIMIT 12;
