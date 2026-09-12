# Retail Sales & Store Performance Analysis

I built this project to analyse retail sales performance across more than 1,000 stores and understand what factors are linked with stronger sales.

The project uses the Rossmann Store Sales dataset and covers the full analytics process, from cleaning the raw data to working with SQL databases and building dashboards.

I used Python, Excel, SQLite, PostgreSQL, Tableau and Power BI so I could work through the same business problem using different tools.

## Business Questions

The main questions I wanted to answer were:

- How do sales change over time?
- Which store types perform best?
- How much difference do promotions make to sales?
- Which stores have the strongest average sales?
- How does customer traffic relate to sales?
- Which store characteristics are linked with stronger performance?

## Dataset

The data comes from the Rossmann Store Sales dataset.

It contains daily sales records for 1,115 stores and includes information such as:

- Sales
- Customers
- Store type
- Assortment
- Promotions
- School holidays
- State holidays
- Competition distance
- Competition opening dates
- Promo2 information

Dataset source:

[Rossmann Store Sales - Kaggle](https://www.kaggle.com/c/rossmann-store-sales/data)

## Tools Used

### Python

Python was used to inspect, clean and prepare the data.

Main libraries:

- pandas
- numpy
- matplotlib

The main notebook is:

`notebooks/01_data_inspection_cleaning.ipynb`

### Excel

Excel was used for additional data checking and business analysis.

The workbook is available here:

`excel/retail_sales_analysis.xlsx`

### SQLite

SQLite was used to create a local database and practise writing business-focused SQL queries.

The main SQL file is:

`sql/sqlite/business_queries.sql`

The generated SQLite database is not included in the repository because of its file size.

### PostgreSQL

I also recreated the database workflow in PostgreSQL.

The PostgreSQL scripts are:

`sql/postgres/setup_postgres.sql`

`sql/postgres/load_data.sql`

This gave me experience moving the same analysis from a lightweight local database to a full relational database system.

## Key Findings

### Sales over time

Sales changed noticeably from month to month instead of following a completely steady pattern.

There were several strong peaks and weaker periods across the dataset, which makes time-based reporting useful when looking at store performance.

### Store type performance

Store Type B had the highest average sales per store-day.

Approximate average sales by store type were:

| Store Type | Average Sales |
|---|---:|
| B | 10,059 |
| A | 5,738 |
| C | 5,724 |
| D | 5,642 |

Store Type A generated the highest total sales overall, while Store Type B had the strongest average daily performance.

This is a good example of why total sales and average sales should be looked at together.

### Promotions

Stores running promotions generally recorded higher average sales than stores without promotions.

When the analysis was limited to stores that were open, promotional days still showed a clear increase in average sales.

This does not prove that promotions caused the full increase, but it shows a strong relationship between promotion activity and sales.

### Customer traffic

Across the full dataset there were about 644 million recorded customer visits.

Customer traffic is closely linked with sales, so it is useful to track it alongside revenue.

### Overall sales

The dataset contains about 5.87 billion in total recorded sales.

The average store-day generated about 5,774 in sales across the full dataset.

## Power BI Dashboard

The Power BI dashboard was built to make the analysis interactive.

It includes:

- Total Sales KPI
- Customer Visits KPI
- Average Daily Store Sales KPI
- Promotion analysis
- Year filter
- Store Type filter
- Promotion filter
- Store Type performance matrix
- Conditional formatting
- Sales Driver decomposition tree

The decomposition tree allows sales to be explored through:

`Total Sales → Store Type → Promotion → Assortment`

Power BI files are available in:

`dashboards/powerbi/`

The folder includes:

- Power BI report file
- PDF export
- Dashboard image

## Tableau Dashboard

I also recreated the reporting layer in Tableau.

The Tableau dashboard includes:

- Monthly Sales Trend
- Average Sales by Store Type
- Promotion Impact on Average Sales
- Top 10 Stores by Average Sales

The packaged Tableau workbook is available here:

`dashboards/tableau/retail_sales_dashboard.twbx`

Building the dashboard in both Power BI and Tableau helped me compare how the same business analysis can be presented in two different BI tools.

## SQL Analysis

SQL was used to answer business questions directly from the prepared data.

The project includes both SQLite and PostgreSQL.

The SQL work covers areas such as:

- Store performance
- Sales totals
- Average sales
- Promotion performance
- Customer activity
- Store comparisons

## Project Structure

```text
retail-sales-inventory-command-center/
│
├── dashboards/
│   ├── powerbi/
│   │   ├── retail_sales_inventory_dashboard.pbix
│   │   ├── retail_sales_inventory_dashboard.pdf
│   │   └── retail_sales_inventory_dashboard.jpg
│   │
│   └── tableau/
│       └── retail_sales_dashboard.twbx
│
├── data/
│   ├── raw/
│   └── processed/
│       └── store_clean.csv
│
├── excel/
│   └── retail_sales_analysis.xlsx
│
├── notebooks/
│   └── 01_data_inspection_cleaning.ipynb
│
├── reports/
│
├── sql/
│   ├── postgres/
│   │   ├── setup_postgres.sql
│   │   └── load_data.sql
│   │
│   └── sqlite/
│       └── business_queries.sql
│
├── README.md
└── requirements.txt
```

## Running the Python Analysis

Install the required Python packages:

```bash
pip install -r requirements.txt
```

Then open:

`notebooks/01_data_inspection_cleaning.ipynb`

Run the notebook from top to bottom.

The original Rossmann dataset can be downloaded from Kaggle and placed inside the `data/raw` folder.

## What I Learned

This project gave me practical experience working through the same business problem across different parts of the analytics process.

I cleaned and prepared the data in Python, explored it in Excel, queried it with SQLite and PostgreSQL, and then presented the results in Tableau and Power BI.

One of the main things I learned was that the same dataset can tell different stories depending on the metric being used.

For example, Store Type A produced the highest total sales, while Store Type B had the highest average sales per store-day.

The project also helped me understand that dashboards are only the final part of the process. A lot of the important work happens earlier when the data is cleaned, checked and structured properly.

## Limitations

The dataset contains historical Rossmann store activity, so it should not be treated as current retail performance.

It also does not contain product-level inventory quantities, product costs or profit margins.

Because of this, the project focuses mainly on retail sales and store performance rather than detailed inventory management.

Promotion results show relationships in the historical data and should not be treated as proof that promotions alone caused higher sales.