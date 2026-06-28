# Data Dictionary

Complete column-level documentation for all 10 tables in the Indonesia Car Sales Analytics database. Primary keys are marked **PK** and foreign keys **FK**.

---

## 1. `brands` — Vehicle brands and positioning

| Column | Data Type | Description |
|---|---|---|
| `brand_id` **PK** | INT | Unique identifier for each brand |
| `brand_name` | VARCHAR(50) | Brand name (unique) |
| `country_origin` | VARCHAR(50) | Country of origin (Japan, Korea, China, Germany, USA, etc.) |
| `brand_segment` | VARCHAR(20) | Mass-Market / Premium / Luxury / EV-Focused |

**Row count:** 18 brands.

---

## 2. `vehicles` — Vehicle master data (brand–model–variant)

| Column | Data Type | Description |
|---|---|---|
| `vehicle_id` **PK** | INT | Unique identifier for each vehicle variant |
| `brand` **FK** | VARCHAR(50) | Brand name (→ `brands.brand_name`) |
| `model` | VARCHAR(50) | Model line (e.g. Avanza, Brio, Xpander) |
| `variant` | VARCHAR(50) | Trim/variant (e.g. 1.5 G CVT) |
| `vehicle_type` | VARCHAR(20) | MPV / SUV / Sedan / Hatchback / Pickup |
| `fuel_type` | VARCHAR(20) | Gasoline / Diesel / Hybrid / Electric |
| `transmission` | VARCHAR(20) | Manual / Automatic / CVT |
| `engine_capacity` | INT | Engine displacement in cc (0 for EV) |
| `production_year` | INT | Model production year |
| `price_category` | VARCHAR(20) | Entry / Mid / Premium / Luxury |

**Row count:** 87 vehicle variants.

---

## 3. `dealers` — Dealership network

| Column | Data Type | Description |
|---|---|---|
| `dealer_id` **PK** | INT | Unique identifier for each dealership |
| `dealer_name` | VARCHAR(100) | Dealership name (synthetic) |
| `city` | VARCHAR(50) | City where the dealer operates |
| `province` | VARCHAR(50) | Province of the dealer |
| `region` | VARCHAR(30) | Java / Sumatra / Kalimantan / Sulawesi / Eastern Indonesia |
| `dealer_type` | VARCHAR(20) | Flagship / Standard / Authorized |

**Row count:** 120 dealers across 5 regions and 21+ provinces.

---

## 4. `customers` — Buyer profiles

| Column | Data Type | Description |
|---|---|---|
| `customer_id` **PK** | INT | Unique identifier for each customer |
| `customer_name` | VARCHAR(100) | Full name of the customer (synthetic) |
| `gender` | VARCHAR(10) | Male / Female (N/A for corporate) |
| `age` | INT | Age in years at first purchase (0 for corporate) |
| `occupation` | VARCHAR(50) | Occupation category (Entrepreneur, Doctor, Professional, etc.) |
| `income_segment` | VARCHAR(20) | Low / Middle / Upper-Middle / High |
| `city` | VARCHAR(50) | City of residence |
| `province` | VARCHAR(50) | Province of residence |
| `customer_type` | VARCHAR(20) | Individual or Corporate |

**Row count:** 4,500 customers.

---

## 5. `sales_transactions` — Core fact table

| Column | Data Type | Description |
|---|---|---|
| `transaction_id` **PK** | INT | Unique identifier for each sale |
| `transaction_date` | DATE | Date the sale was completed |
| `customer_id` **FK** | INT | Buyer (→ `customers`) |
| `vehicle_id` **FK** | INT | Vehicle sold (→ `vehicles`) |
| `dealer_id` **FK** | INT | Selling dealer (→ `dealers`) |
| `quantity` | INT | Units sold (usually 1; >1 for fleet) |
| `unit_price` | DECIMAL(15,2) | List price per unit (IDR) |
| `discount_amount` | DECIMAL(15,2) | Total discount applied (IDR) |
| `tax_amount` | DECIMAL(15,2) | Tax collected (IDR) |
| `total_revenue` | DECIMAL(15,2) | Net revenue (qty × price − discount + tax) |
| `payment_method` | VARCHAR(20) | Cash / Credit |
| `sales_channel` | VARCHAR(20) | Showroom / Online / Fleet / Event |

**Row count:** 11,013 transactions over Jan 2020 – Dec 2025.

---

## 6. `sales_targets` — Monthly dealer targets

| Column | Data Type | Description |
|---|---|---|
| `target_id` **PK** | INT | Unique identifier for each target row |
| `dealer_id` **FK** | INT | Dealer the target applies to |
| `target_month` | INT | Target month (1–12) |
| `target_year` | INT | Target year |
| `sales_target_units` | INT | Unit sales target for the month |
| `revenue_target` | DECIMAL(18,2) | Revenue target for the month (IDR) |

**Row count:** 8,640 (120 dealers × 72 months).

---

## 7. `inventory` — Monthly stock snapshots per dealer/vehicle

| Column | Data Type | Description |
|---|---|---|
| `inventory_id` **PK** | INT | Unique identifier for each stock snapshot |
| `dealer_id` **FK** | INT | Dealer holding the stock |
| `vehicle_id` **FK** | INT | Vehicle variant in stock |
| `stock_available` | INT | Units on hand at month end |
| `stock_in` | INT | Units received during the month |
| `stock_out` | INT | Units sold/dispatched during the month |
| `inventory_month` | DATE | First day of the snapshot month |

**Row count:** 8,744 snapshots.

---

## 8. `marketing_campaigns` — Promotional activities

| Column | Data Type | Description |
|---|---|---|
| `campaign_id` **PK** | INT | Unique identifier for each campaign |
| `campaign_name` | VARCHAR(100) | Campaign name |
| `brand` | VARCHAR(50) | Brand promoted |
| `campaign_channel` | VARCHAR(30) | Digital / TV / Radio / Print / Event / Social |
| `start_date` | DATE | Campaign start date |
| `end_date` | DATE | Campaign end date |
| `campaign_cost` | DECIMAL(18,2) | Total campaign spend (IDR) |
| `target_region` | VARCHAR(30) | Region targeted by the campaign |

**Row count:** 150 campaigns.

---

## 9. `financing` — Credit-financed purchases

| Column | Data Type | Description |
|---|---|---|
| `financing_id` **PK** | INT | Unique identifier for each financing record |
| `transaction_id` **FK** | INT | Sale being financed (→ `sales_transactions`) |
| `financing_company` | VARCHAR(50) | Multifinance company / bank |
| `down_payment` | DECIMAL(15,2) | Down payment amount (IDR) |
| `loan_amount` | DECIMAL(15,2) | Principal financed (IDR) |
| `tenor_months` | INT | Loan tenor in months (12–60) |
| `interest_rate` | DECIMAL(5,2) | Annual interest rate (%) |
| `installment_amount` | DECIMAL(15,2) | Monthly installment (IDR) |

**Row count:** 6,592 records (matches the count of credit transactions).

---

## 10. `after_sales_service` — Service visits and satisfaction

| Column | Data Type | Description |
|---|---|---|
| `service_id` **PK** | INT | Unique identifier for each service visit |
| `customer_id` **FK** | INT | Customer serviced |
| `vehicle_id` **FK** | INT | Vehicle serviced |
| `dealer_id` **FK** | INT | Servicing dealer |
| `service_date` | DATE | Date of the service visit |
| `service_type` | VARCHAR(30) | Periodic / Repair / Warranty / Body & Paint |
| `service_cost` | DECIMAL(15,2) | Service revenue (IDR) |
| `customer_satisfaction_score` | INT | CSAT score 1–5 |

**Row count:** 6,718 service visits.

---

## Value Domains Reference

| Field | Allowed Values |
|---|---|
| `vehicle_type` | MPV, SUV, Sedan, Hatchback, Pickup |
| `fuel_type` | Gasoline, Diesel, Hybrid, Electric |
| `transmission` | Manual, Automatic, CVT |
| `price_category` | Entry, Mid, Premium, Luxury |
| `brand_segment` | Mass-Market, Premium, Luxury, EV-Focused |
| `region` | Java, Sumatra, Kalimantan, Sulawesi, Eastern Indonesia |
| `payment_method` | Cash, Credit |
| `sales_channel` | Showroom, Online, Fleet, Event |
| `income_segment` | Low, Middle, Upper-Middle, High |
| `customer_type` | Individual, Corporate |
| `service_type` | Periodic, Repair, Warranty, Body & Paint |
| `campaign_channel` | Digital, TV, Radio, Print, Event, Social |
