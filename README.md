# 🩸 Blood Bank Analytics & Reporting System

This project focuses on transforming blood bank operational data into meaningful insights and actionable reports.

A scalable data pipeline is designed using modern data engineering practices to simulate real-world scenarios, enabling analysis of donation trends, demand-supply gaps, donor behavior, and operational efficiency.

The system follows a structured architecture from raw data ingestion to analytics and visualization, supporting data-driven decision-making for blood bank management.

--------------------------


## 🏗️ Architecture & Data Flow

The project is designed using a Medallion Architecture approach (Raw → Staging → Analytics) to ensure scalability, data quality, and maintainability.
This structure aligns with the Bronze → Silver → Gold layering pattern commonly used in modern data platforms.

### 🔄 Data Pipeline Flow

1. **Data Generation**

   * A sample dataset is expanded using Python (Pandas, Faker) to simulate large-scale, real-world blood bank data.

2. **Data Ingestion (Raw Layer)**

   * Generated CSV files are ingested into a PostgreSQL data warehouse using defined DDL schemas.
   * This layer stores data in its original form for traceability.

3. **Data Transformation (Staging Layer)**

   * dbt is used to clean, standardize, and validate raw data.
   * Ensures consistency across all entities.

4. **Analytics Layer**

   * Business-ready models are built using dbt.
   * Aggregations and transformations are applied for reporting use cases.

5. **Visualization**

   * Power BI dashboards are created on top of the analytics layer to deliver insights.

### 🧱 Architecture Pattern

CSV Data → Python Processing → PostgreSQL (Raw) → dbt (Staging → Analytics) → Power BI


-----------------------


## ⚙️ Tech Stack

### 🗄️ Data Storage

* PostgreSQL (Data Warehouse)

### 🧪 Data Generation & Processing

* Python

  * Pandas (data manipulation)
  * Faker (synthetic data generation)

### 🔄 Data Transformation

* dbt (Data Build Tool)

### 📊 Data Visualization

* Power BI

### 🧾 Querying

* SQL



-------------------------


## 📂 Dataset

The project includes multiple datasets representing different aspects of a blood bank system.
Large-scale data (millions of records) is synthetically generated using Python to simulate real-world scenarios.

### 📌 Tables Used

* donors
* donations
* blood_tests
* blood_inventory
* recipients
* recipient_requests
* blood_type_compatibility
* hospitals
* donor_history
* tasks
* technicians
* technician_tasks

These datasets collectively support end-to-end analysis of donor activity, blood availability, request management, and operational workflows.



----------------


## 📊 Dashboards & Insights

The project delivers multiple analytical dashboards in Power BI, providing actionable insights into blood bank operations.

### 📈 Monthly Donation Trends by Blood Type

Tracks donation patterns across different blood groups over time, helping identify trends and seasonal variations.
Supports drill-through to view detailed donation records for a selected month.

### 👥 Donor Demographics

Provides insights into the donor base, including:

* Distribution of donors by blood group
* Identification of most common blood groups
* Geographic distribution across states and cities

### 🔁 Donor Retention Risk

Identifies donors who have not donated in the last 180 days but are still eligible.
Helps estimate the number of donors at risk of becoming inactive and supports targeted engagement strategies.

### ⚖️ Hospital Demand vs Supply

Analyzes blood inventory availability against demand:

* Tracks available units and volume by day
* Supports drill-up analysis from daily to monthly and yearly trends

### 🚨 Urgent Requests Analysis

Evaluates high-priority requests by:

* Calculating the percentage of requests marked as "high" urgency
* Breaking down urgency trends across different blood groups

### 📅 Operations Summary

Provides a high-level overview of operational performance:

* Total donations collected
* Total blood tests completed
  Supports drill-up for monthly and yearly analysis.



--------------------


## 📂 Data Access

Due to large file sizes (1GB+), the complete datasets are not stored in this repository.

🔗 Download Full Dataset: <dataset-link>

### 📥 Setup Instructions

1. Download the dataset zip file from the above link
2. Extract the contents into the `master/CSV Files/` directory
3. Ensure file paths align with project configurations before running pipelines

⚠️ Note: Sample data is provided within the repository for quick testing and understanding of the schema.

---

## 📊 Power BI Reports

🔗 View Dashboard: <powerbi-report-link>

The Power BI reports are built on the analytics layer and provide interactive insights into:

* Donation trends
* Demand vs supply analysis
* Donor behavior and retention
* Operational performance

The dashboard supports interactive filtering and drill capabilities for deeper analysis.



--------------------


## 📁 Project Structure

```
DE_CAPSTONE_PROJECT/
│
├── master/
│   ├── blood_bank_management_system/   # dbt project
│   │   ├── models/                     # staging & analytics models
│   │   ├── macros/                     # reusable dbt macros
│   │   ├── seeds/                      # seed data
│   │   ├── snapshots/                  # slowly changing data
│   │   ├── tests/                      # data quality tests
│   │   └── dbt_project.yml             # dbt configuration
│   │
│   ├── Python Scripts/                 # data generation (Pandas, Faker)
│   ├── DDL's/                          # table creation scripts
│   ├── Source Data/                    # initial sample dataset
│   ├── CSV Files/                      # generated large datasets
│   └── Power BI Reports/               # dashboard files
│
└── README.md
```

> Note: Large data files and reports are not included in this repository. Refer to the Data Access section for details.



-----------------



## ▶️ How to Run the Project

### 1️⃣ Setup PostgreSQL

* Create a database for the project
* Execute the DDL scripts from the `master/DDL's/` folder to create required tables

---

### 2️⃣ Load Data into Raw Layer

* Download the dataset from the Data Access section

* Extract files into `master/CSV Files/`

* Use PostgreSQL `COPY` command to load data into tables:

```sql
COPY table_name
FROM 'path/to/file.csv'
DELIMITER ','
CSV HEADER;
```

---

### 3️⃣ Run dbt Models

Navigate to the dbt project directory:

```bash
cd master/blood_bank_management_system
```

Run transformations:

```bash
dbt run
```

Run tests:

```bash
dbt test
```

---

### 4️⃣ View Data in Analytics Layer

* Transformed data will be available in analytics models created by dbt
* Use SQL or connect Power BI to the PostgreSQL database

---

### 5️⃣ Open Power BI Dashboard

* Use the link provided in the Power BI section
* Explore dashboards with filters and drill capabilities
