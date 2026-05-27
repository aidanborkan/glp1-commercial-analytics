# GLP-1 Market Access & Commercial Analytics

**Commercial analytics dashboard evaluating GLP-1 utilization, provider prescribing behavior, spend intensity, specialty penetration, and competitive market share using public Medicare Part D prescription data.**

**Technology Stack:** Python (Jupyter), Azure Data Factory, PostgreSQL, SQL, Tableau Public, GitHub Pages

---

## Executive Summary

This project demonstrates an end-to-end pharmaceutical commercial analytics workflow for evaluating GLP-1 prescribing patterns across the United States.

Using public Medicare Part D prescription data, I developed a reproducible analytics pipeline to model provider behavior, market utilization, geographic prescribing trends, and commercial opportunity segmentation.

The workflow combines data engineering, SQL analytics, and business intelligence reporting to transform raw prescription records into actionable commercial insights.

### Core Questions Addressed

- Which states demonstrate the strongest GLP-1 utilization?
- Which markets generate the highest spend intensity per provider?
- Which medical specialties drive prescribing behavior?
- How does competitive market share vary geographically?
- Which markets represent underpenetrated commercial opportunities?

---

## End-to-End Architecture

```text
Raw Medicare Part D GLP-1 Data
                │
                ▼
      Jupyter / Python Data Cleaning
                │
                ▼
        Azure Data Factory ETL
                │
                ▼
         PostgreSQL Data Warehouse
                │
     ┌──────────┴──────────┐
     ▼                     ▼
Dimension Tables        Fact Table
(Drug, Territory)    Prescriptions
     │                     │
     └──────────┬──────────┘
                ▼
          SQL Analytics Views
                │
                ▼
          Tableau Dashboard
                │
                ▼
      Commercial Market Insights
```

Data Engineering Workflow
1. Data Extraction

Public Medicare Part D prescription utilization data were used as the source system for analysis.

The dataset includes:

National Provider Identifier (NPI)
Provider specialty
State geography
Drug brand and generic names
Prescription claims volume
Drug spend
2. Data Cleaning & Feature Engineering (Python/Jupyter)

Python and Jupyter Notebook were used to prepare dashboard-ready analytics tables.

Key preprocessing steps
Filtering GLP-1 therapies of interest
Standardizing provider and drug naming
Cleaning state and specialty metadata
Creating derived business metrics
Preparing structured tables for relational modeling
Derived metrics
Spend per provider
Claims per provider
Drug market share
Provider utilization intensity
State benchmarking metrics
3. Azure Data Factory ETL

An ETL workflow was developed using Azure Data Factory to orchestrate ingestion and transformation.

Pipeline responsibilities
Source ingestion
Data movement and staging
Schema validation
Relational loading preparation
Workflow orchestration

This step simulates how commercial analytics pipelines are commonly operationalized in pharmaceutical and healthcare environments.

4. Relational Modeling (PostgreSQL)

Data were loaded into PostgreSQL using a dimensional schema optimized for downstream business intelligence reporting.

Fact Table

fact_glp1_prescriptions

Core transactional dataset containing:

Prescription claims
Spend
Provider utilization
Specialty
Geography
Dimension Tables

dim_drug

Brand name
Generic name
Manufacturer

dim_territory

State
Regional mapping

SQL Analytics Layer

SQL views were developed to support reusable, dashboard-ready commercial metrics.

| View                          | Purpose                              |
| ----------------------------- | ------------------------------------ |
| `vw_kpi_metrics`              | Executive KPI calculations           |
| `vw_drug_market_share`        | State-level competitive market share |
| `vw_specialty_penetration`    | Provider specialty analysis          |
| `vw_state_normalized_metrics` | State benchmarking metrics           |
| `vw_territory_glp1_summary`   | Tableau reporting layer              |

Dashboard Overview

The Tableau dashboard was designed to support exploratory commercial analysis and executive-level reporting.

KPI Summary

Provides a high-level performance snapshot across the GLP-1 market.

Metrics included
Total Claims
Total Spend
Cost per Claim
Provider Count
Spend per Provider

These KPIs establish baseline market context before deeper segmentation analysis.

Spend per Provider by State

Measures provider-level spend intensity across geographic markets.

Higher values may reflect:

Stronger adoption
Higher prescribing concentration
More mature commercial markets
Total Spend by State

Compares aggregate GLP-1 spending across states to identify regions contributing disproportionate commercial value.

Useful for:

Prioritization of commercial markets
Regional performance assessment
Market concentration analysis
Utilization per Provider

Evaluates prescribing intensity on a per-provider basis.

Higher utilization may indicate:

Stronger market penetration
Higher provider engagement
Increased adoption maturity
Drug Market Share by State

Displays competitive distribution of GLP-1 therapies across geographies.

Supports evaluation of:

Competitive dominance
Geographic prescribing variation
Commercialization opportunities
Market Opportunity Segmentation

A multivariate market segmentation view comparing:

X-axis: Claims per Provider
Y-axis: Spend per Provider
Bubble Size: Provider Count

This enables rapid identification of:

| Segment                         | Interpretation                   |
| ------------------------------- | -------------------------------- |
| High utilization / high spend   | Mature commercial markets        |
| High spend / lower utilization  | Premium prescribing environments |
| High utilization / lower spend  | Expansion opportunities          |
| Lower utilization / lower spend | Lower-priority markets           |


Medical Specialty Penetration

Ranks provider specialties according to GLP-1 prescribing behavior.

Useful for:

Physician targeting strategies
Specialty prioritization
Commercialization planning
Example Insights

Illustrative findings include:

Northeastern markets demonstrate relatively high utilization and spend intensity.
Competitive market share varies considerably across states.
Endocrinology and primary care specialties represent major prescribing groups.
Several states show divergent utilization and spend dynamics, suggesting heterogeneous prescribing behavior.



## Repository Structure

```text
glp1-commercial-analytics/
├── README.md
├── index.html
├── notebooks/
│   └── glp1_data_cleaning.ipynb
├── sql/
│   ├── 01_create_schema_tables.sql
│   ├── 02_load_raw_data.sql
│   ├── 03_create_analytics_views.sql
│   └── 04_validation_checks.sql
├── screenshots/
│   └── dashboard_overview.png
└── docs/

