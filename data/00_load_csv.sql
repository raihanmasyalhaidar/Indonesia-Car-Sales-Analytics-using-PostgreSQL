-- Load data from CSV files using PostgreSQL COPY
-- Adjust paths to your local data/csv folder

\copy brands              FROM 'data/csv/01_brands.csv'              WITH (FORMAT csv, HEADER true);
\copy vehicles            FROM 'data/csv/02_vehicles.csv'            WITH (FORMAT csv, HEADER true);
\copy dealers             FROM 'data/csv/03_dealers.csv'             WITH (FORMAT csv, HEADER true);
\copy customers           FROM 'data/csv/04_customers.csv'           WITH (FORMAT csv, HEADER true);
\copy sales_transactions  FROM 'data/csv/05_sales_transactions.csv'  WITH (FORMAT csv, HEADER true);
\copy sales_targets       FROM 'data/csv/06_sales_targets.csv'       WITH (FORMAT csv, HEADER true);
\copy inventory           FROM 'data/csv/07_inventory.csv'           WITH (FORMAT csv, HEADER true);
\copy marketing_campaigns FROM 'data/csv/08_marketing_campaigns.csv' WITH (FORMAT csv, HEADER true);
\copy financing           FROM 'data/csv/09_financing.csv'           WITH (FORMAT csv, HEADER true);
\copy after_sales_service FROM 'data/csv/10_after_sales_service.csv' WITH (FORMAT csv, HEADER true);
