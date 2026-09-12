-- Clear old data before loading a fresh copy
TRUNCATE TABLE sales, stores;

-- Load the cleaned sales data
\copy sales FROM 'data/processed/train_clean.csv'
WITH (FORMAT csv, HEADER true);

-- Load the cleaned store data
\copy stores FROM 'data/processed/store_clean.csv'
WITH (FORMAT csv, HEADER true);

-- Refresh the reporting table after new data is loaded
REFRESH MATERIALIZED VIEW analytics.monthly_store_performance;