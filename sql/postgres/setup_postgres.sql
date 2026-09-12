-- Main sales table
CREATE TABLE IF NOT EXISTS sales (
    Store INTEGER,
    DayOfWeek INTEGER,
    Date DATE,
    Sales INTEGER,
    Customers INTEGER,
    Open INTEGER,
    Promo INTEGER,
    StateHoliday TEXT,
    SchoolHoliday INTEGER,
    Year INTEGER,
    Month INTEGER,
    Quarter INTEGER
);

-- Store information
CREATE TABLE IF NOT EXISTS stores (
    Store INTEGER PRIMARY KEY,
    StoreType TEXT,
    Assortment TEXT,
    CompetitionDistance REAL,
    CompetitionOpenSinceMonth REAL,
    CompetitionOpenSinceYear REAL,
    Promo2 INTEGER,
    Promo2SinceWeek REAL,
    Promo2SinceYear REAL,
    PromoInterval TEXT
);

-- Keep reporting objects separate from the raw tables
CREATE SCHEMA IF NOT EXISTS analytics;

-- Rebuild the monthly table used for reporting
DROP MATERIALIZED VIEW IF EXISTS analytics.monthly_store_performance;

CREATE MATERIALIZED VIEW analytics.monthly_store_performance AS
SELECT
    s.Store,
    DATE_TRUNC('month', s.Date)::date AS Month,
    st.StoreType,
    st.Assortment,
    SUM(s.Sales) AS TotalSales,
    SUM(s.Customers) AS TotalCustomers,
    ROUND(AVG(s.Sales), 2) AS AverageDailySales,
    COUNT(*) FILTER (WHERE s.Open = 1) AS OpenDays,
    COUNT(*) FILTER (WHERE s.Promo = 1 AND s.Open = 1) AS PromoDays
FROM sales AS s
JOIN stores AS st
    ON s.Store = st.Store
GROUP BY
    s.Store,
    DATE_TRUNC('month', s.Date)::date,
    st.StoreType,
    st.Assortment;

-- Help dashboard queries filter faster by store and month
CREATE INDEX idx_monthly_store_performance_store_month
ON analytics.monthly_store_performance (Store, Month);