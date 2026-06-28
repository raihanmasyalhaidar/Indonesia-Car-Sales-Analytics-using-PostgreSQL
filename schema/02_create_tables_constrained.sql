-- Indonesia Car Sales Analytics - Schema (with PK/FK/CHECK constraints)
-- PostgreSQL-compatible

DROP TABLE IF EXISTS after_sales_service CASCADE;
DROP TABLE IF EXISTS financing CASCADE;
DROP TABLE IF EXISTS marketing_campaigns CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS sales_targets CASCADE;
DROP TABLE IF EXISTS sales_transactions CASCADE;
DROP TABLE IF EXISTS vehicles CASCADE;
DROP TABLE IF EXISTS dealers CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS brands CASCADE;


CREATE TABLE brands (
    brand_id        INT PRIMARY KEY,
    brand_name      VARCHAR(50)  NOT NULL UNIQUE,
    country_origin  VARCHAR(50),
    brand_segment   VARCHAR(20)  CHECK (brand_segment IN ('Mass-Market','Premium','Luxury','EV-Focused'))
);


CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    customer_name   VARCHAR(100) NOT NULL,
    gender          VARCHAR(10)  CHECK (gender IN ('Male','Female','N/A')),
    age             INT          CHECK (age >= 0),
    occupation      VARCHAR(50),
    income_segment  VARCHAR(20)  CHECK (income_segment IN ('Low','Middle','Upper-Middle','High')),
    city            VARCHAR(50),
    province        VARCHAR(50),
    customer_type   VARCHAR(20)  CHECK (customer_type IN ('Individual','Corporate'))
);


CREATE TABLE dealers (
    dealer_id       INT PRIMARY KEY,
    dealer_name     VARCHAR(100) NOT NULL,
    city            VARCHAR(50),
    province        VARCHAR(50),
    region          VARCHAR(30)  CHECK (region IN ('Java','Sumatra','Kalimantan','Sulawesi','Eastern Indonesia')),
    dealer_type     VARCHAR(20)  CHECK (dealer_type IN ('Flagship','Standard','Authorized'))
);


CREATE TABLE vehicles (
    vehicle_id      INT PRIMARY KEY,
    brand           VARCHAR(50)  NOT NULL,
    model           VARCHAR(50)  NOT NULL,
    variant         VARCHAR(50),
    vehicle_type    VARCHAR(20)  CHECK (vehicle_type IN ('MPV','SUV','Sedan','Hatchback','Pickup')),
    fuel_type       VARCHAR(20)  CHECK (fuel_type IN ('Gasoline','Diesel','Hybrid','Electric')),
    transmission    VARCHAR(20)  CHECK (transmission IN ('Manual','Automatic','CVT')),
    engine_capacity INT,
    production_year INT,
    price_category  VARCHAR(20)  CHECK (price_category IN ('Entry','Mid','Premium','Luxury')),
    CONSTRAINT fk_vehicle_brand
        FOREIGN KEY (brand) REFERENCES brands (brand_name)
);


CREATE TABLE sales_transactions (
    transaction_id   INT PRIMARY KEY,
    transaction_date DATE         NOT NULL,
    customer_id      INT          NOT NULL,
    vehicle_id       INT          NOT NULL,
    dealer_id        INT          NOT NULL,
    quantity         INT          NOT NULL CHECK (quantity > 0),
    unit_price       DECIMAL(15,2) NOT NULL,
    discount_amount  DECIMAL(15,2) DEFAULT 0,
    tax_amount       DECIMAL(15,2) DEFAULT 0,
    total_revenue    DECIMAL(15,2) NOT NULL,
    payment_method   VARCHAR(20)  CHECK (payment_method IN ('Cash','Credit')),
    sales_channel    VARCHAR(20)  CHECK (sales_channel IN ('Showroom','Online','Fleet','Event')),
    CONSTRAINT fk_txn_customer FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    CONSTRAINT fk_txn_vehicle  FOREIGN KEY (vehicle_id)  REFERENCES vehicles  (vehicle_id),
    CONSTRAINT fk_txn_dealer   FOREIGN KEY (dealer_id)   REFERENCES dealers   (dealer_id)
);


CREATE TABLE sales_targets (
    target_id          INT PRIMARY KEY,
    dealer_id          INT NOT NULL,
    target_month       INT NOT NULL CHECK (target_month BETWEEN 1 AND 12),
    target_year        INT NOT NULL,
    sales_target_units INT,
    revenue_target     DECIMAL(18,2),
    CONSTRAINT fk_target_dealer FOREIGN KEY (dealer_id) REFERENCES dealers (dealer_id)
);


CREATE TABLE inventory (
    inventory_id    INT PRIMARY KEY,
    dealer_id       INT NOT NULL,
    vehicle_id      INT NOT NULL,
    stock_available INT,
    stock_in        INT,
    stock_out       INT,
    inventory_month DATE,
    CONSTRAINT fk_inv_dealer  FOREIGN KEY (dealer_id)  REFERENCES dealers  (dealer_id),
    CONSTRAINT fk_inv_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id)
);


CREATE TABLE marketing_campaigns (
    campaign_id      INT PRIMARY KEY,
    campaign_name    VARCHAR(100) NOT NULL,
    brand            VARCHAR(50),
    campaign_channel VARCHAR(30)  CHECK (campaign_channel IN ('Digital','TV','Radio','Print','Event','Social')),
    start_date       DATE,
    end_date         DATE,
    campaign_cost    DECIMAL(18,2),
    target_region    VARCHAR(30)
);


CREATE TABLE financing (
    financing_id       INT PRIMARY KEY,
    transaction_id     INT NOT NULL,
    financing_company  VARCHAR(50),
    down_payment       DECIMAL(15,2),
    loan_amount        DECIMAL(15,2),
    tenor_months       INT CHECK (tenor_months BETWEEN 12 AND 60),
    interest_rate      DECIMAL(5,2),
    installment_amount DECIMAL(15,2),
    CONSTRAINT fk_fin_txn FOREIGN KEY (transaction_id) REFERENCES sales_transactions (transaction_id)
);


CREATE TABLE after_sales_service (
    service_id                  INT PRIMARY KEY,
    customer_id                 INT NOT NULL,
    vehicle_id                  INT NOT NULL,
    dealer_id                   INT NOT NULL,
    service_date                DATE,
    service_type                VARCHAR(30) CHECK (service_type IN ('Periodic','Repair','Warranty','Body & Paint')),
    service_cost                DECIMAL(15,2),
    customer_satisfaction_score INT CHECK (customer_satisfaction_score BETWEEN 1 AND 5),
    CONSTRAINT fk_svc_customer FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    CONSTRAINT fk_svc_vehicle  FOREIGN KEY (vehicle_id)  REFERENCES vehicles  (vehicle_id),
    CONSTRAINT fk_svc_dealer   FOREIGN KEY (dealer_id)   REFERENCES dealers   (dealer_id)
);
