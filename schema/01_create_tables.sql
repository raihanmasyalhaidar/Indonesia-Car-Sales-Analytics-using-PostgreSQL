-- Indonesia Car Sales Analytics - Schema (no constraints)
-- PostgreSQL / MySQL / DuckDB compatible

DROP TABLE IF EXISTS after_sales_service;
DROP TABLE IF EXISTS financing;
DROP TABLE IF EXISTS marketing_campaigns;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS sales_targets;
DROP TABLE IF EXISTS sales_transactions;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS dealers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS brands;


CREATE TABLE brands (
    brand_id        INT,
    brand_name      VARCHAR(50),
    country_origin  VARCHAR(50),
    brand_segment   VARCHAR(20)
);


CREATE TABLE customers (
    customer_id     INT,
    customer_name   VARCHAR(100),
    gender          VARCHAR(10),
    age             INT,
    occupation      VARCHAR(50),
    income_segment  VARCHAR(20),
    city            VARCHAR(50),
    province        VARCHAR(50),
    customer_type   VARCHAR(20)
);


CREATE TABLE dealers (
    dealer_id       INT,
    dealer_name     VARCHAR(100),
    city            VARCHAR(50),
    province        VARCHAR(50),
    region          VARCHAR(30),
    dealer_type     VARCHAR(20)
);


CREATE TABLE vehicles (
    vehicle_id      INT,
    brand           VARCHAR(50),
    model           VARCHAR(50),
    variant         VARCHAR(50),
    vehicle_type    VARCHAR(20),
    fuel_type       VARCHAR(20),
    transmission    VARCHAR(20),
    engine_capacity INT,
    production_year INT,
    price_category  VARCHAR(20)
);


CREATE TABLE sales_transactions (
    transaction_id   INT,
    transaction_date DATE,
    customer_id      INT,
    vehicle_id       INT,
    dealer_id        INT,
    quantity         INT,
    unit_price       DECIMAL(15,2),
    discount_amount  DECIMAL(15,2),
    tax_amount       DECIMAL(15,2),
    total_revenue    DECIMAL(15,2),
    payment_method   VARCHAR(20),
    sales_channel    VARCHAR(20)
);


CREATE TABLE sales_targets (
    target_id          INT,
    dealer_id          INT,
    target_month       INT,
    target_year        INT,
    sales_target_units INT,
    revenue_target     DECIMAL(18,2)
);


CREATE TABLE inventory (
    inventory_id    INT,
    dealer_id       INT,
    vehicle_id      INT,
    stock_available INT,
    stock_in        INT,
    stock_out       INT,
    inventory_month DATE
);


CREATE TABLE marketing_campaigns (
    campaign_id      INT,
    campaign_name    VARCHAR(100),
    brand            VARCHAR(50),
    campaign_channel VARCHAR(30),
    start_date       DATE,
    end_date         DATE,
    campaign_cost    DECIMAL(18,2),
    target_region    VARCHAR(30)
);


CREATE TABLE financing (
    financing_id       INT,
    transaction_id     INT,
    financing_company  VARCHAR(50),
    down_payment       DECIMAL(15,2),
    loan_amount        DECIMAL(15,2),
    tenor_months       INT,
    interest_rate      DECIMAL(5,2),
    installment_amount DECIMAL(15,2)
);


CREATE TABLE after_sales_service (
    service_id                  INT,
    customer_id                 INT,
    vehicle_id                  INT,
    dealer_id                   INT,
    service_date                DATE,
    service_type                VARCHAR(30),
    service_cost                DECIMAL(15,2),
    customer_satisfaction_score INT
);
