-- Query 1: Overall sales performance
SELECT
    SUM(quantity)                              AS total_units_sold,
    SUM(total_revenue)                         AS total_revenue,
    ROUND(SUM(total_revenue) / SUM(quantity))  AS avg_selling_price,
    SUM(discount_amount)                       AS total_discounts,
    SUM(tax_amount)                            AS total_tax_collected
FROM sales_transactions;
