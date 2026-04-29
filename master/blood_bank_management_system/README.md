# dbt Project – Blood Bank Management System

This directory contains the dbt project responsible for transforming raw blood bank data into analytics-ready models.

## 📌 Purpose

* Clean and standardize raw data
* Build staging and analytics models
* Enable reliable reporting for downstream tools like Power BI

## 🧱 Project Structure

* `models/` – staging and analytics models
* `macros/` – reusable logic
* `seeds/` – static reference data
* `snapshots/` – historical tracking
* `tests/` – data quality checks

## ▶️ Running dbt

```bash
dbt run
dbt test
```

## 🔗 Note

For full project details, architecture, and setup instructions, refer to the main README in the root directory.
