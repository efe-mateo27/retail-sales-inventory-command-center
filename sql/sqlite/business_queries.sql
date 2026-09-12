-- Combine daily sales with store information
CREATE VIEW IF NOT EXISTS sales_store_details AS
SELECT
    s.Store,
    s.Date,
    s.DayOfWeek,
    s.Sales,
    s.Customers,
    s.Open,
    s.Promo,
    s.StateHoliday,
    s.SchoolHoliday,
    s.Year,
    s.Month,
    s.Quarter,
    st.StoreType,
    st.Assortment,
    st.CompetitionDistance,
    st.Promo2
FROM sales AS s
JOIN stores AS st
    ON s.Store = st.Store;



    -- Rank the best stores within each store type
WITH store_summary AS (
    SELECT
        Store,
        StoreType,
        ROUND(AVG(Sales), 2) AS AverageSales,
        ROUND(AVG(Customers), 2) AS AverageCustomers
    FROM sales_store_details
    WHERE Open = 1
    GROUP BY Store, StoreType
),

ranked_stores AS (
    SELECT
        Store,
        StoreType,
        AverageSales,
        AverageCustomers,
        DENSE_RANK() OVER (
            PARTITION BY StoreType
            ORDER BY AverageSales DESC
        ) AS SalesRank
    FROM store_summary
)

SELECT *
FROM ranked_stores
WHERE SalesRank <= 3
ORDER BY StoreType, SalesRank;


-- Find stores performing below the average for their own store type
WITH store_summary AS (
    SELECT
        Store,
        StoreType,
        AVG(Sales) AS AverageSales
    FROM sales_store_details
    WHERE Open = 1
    GROUP BY Store, StoreType
),

type_average AS (
    SELECT
        StoreType,
        AVG(AverageSales) AS TypeAverageSales
    FROM store_summary
    GROUP BY StoreType
)

SELECT
    s.Store,
    s.StoreType,
    ROUND(s.AverageSales, 2) AS StoreAverageSales,
    ROUND(t.TypeAverageSales, 2) AS TypeAverageSales,
    ROUND(
        ((s.AverageSales - t.TypeAverageSales) / t.TypeAverageSales) * 100,
        2
    ) AS PercentVsTypeAverage
FROM store_summary AS s
JOIN type_average AS t
    ON s.StoreType = t.StoreType
WHERE s.AverageSales < t.TypeAverageSales
ORDER BY PercentVsTypeAverage
LIMIT 15;


-- Track monthly sales and how much they changed from the previous month
WITH monthly_sales AS (
    SELECT
        SUBSTR(Date, 1, 7) AS YearMonth,
        SUM(Sales) AS TotalSales
    FROM sales
    GROUP BY YearMonth
),

sales_change AS (
    SELECT
        YearMonth,
        TotalSales,
        LAG(TotalSales) OVER (
            ORDER BY YearMonth
        ) AS PreviousMonthSales
    FROM monthly_sales
)

SELECT
    YearMonth,
    TotalSales,
    PreviousMonthSales,
    ROUND(
        ((TotalSales - PreviousMonthSales) * 100.0)
        / PreviousMonthSales,
        2
    ) AS MonthlyGrowthPercent
FROM sales_change
ORDER BY YearMonth;


-- Compare promo and non-promo sales within each store type
SELECT
    StoreType,

    ROUND(
        AVG(CASE WHEN Promo = 0 THEN Sales END),
        2
    ) AS NoPromoAverageSales,

    ROUND(
        AVG(CASE WHEN Promo = 1 THEN Sales END),
        2
    ) AS PromoAverageSales,

    ROUND(
        (
            AVG(CASE WHEN Promo = 1 THEN Sales END)
            - AVG(CASE WHEN Promo = 0 THEN Sales END)
        )
        * 100.0
        / AVG(CASE WHEN Promo = 0 THEN Sales END),
        2
    ) AS PromoUpliftPercent

FROM sales_store_details
WHERE Open = 1
GROUP BY StoreType
ORDER BY PromoUpliftPercent DESC;


