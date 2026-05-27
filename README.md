# GLP-1 Market Access & Commercial Analytics

SQL + Tableau analytics project evaluating GLP-1 utilization, provider behavior, market share, specialty penetration, and commercial opportunity using Medicare Part D prescription data.

---

## Project Overview

This project demonstrates an end-to-end commercial analytics workflow:

**Raw prescription data → PostgreSQL dimensional model → SQL analytics views → Tableau dashboard**

The objective was to model and analyze GLP-1 prescribing trends, provider utilization, spend intensity, market share, and market opportunities across U.S. states.

---

## Business Objective

This project explores several commercial analytics questions relevant to pharmaceutical market access and commercialization strategy:

- Which markets demonstrate the highest GLP-1 utilization?
- Which states generate the greatest spend intensity per provider?
- Which provider specialties drive GLP-1 adoption?
- How does competitive market share vary geographically?
- Which markets represent potential commercial opportunities?

---

## Data Source

This project uses publicly available **Medicare Part D prescription utilization data** focused on GLP-1 therapies.

The dataset includes:

- National Provider Identifier (NPI)
- Provider specialty
- Prescriber geography (state)
- Drug brand and generic names
- Total prescription claims
- Drug spend

GLP-1 therapies analyzed include:

- Ozempic
- Wegovy
- Mounjaro
- Trulicity
- Rybelsus

Data were modeled in PostgreSQL and transformed into analytical SQL views for Tableau visualization.

---

## Architecture Diagram

```text
Public Medicare Part D GLP-1 Data
                │
                ▼
        PostgreSQL Database
                │
      ┌─────────┴─────────┐
      │                   │
      ▼                   ▼
 Dimension Tables      Fact Table
 (Drug, Territory)     Prescriptions
      │                   │
      └─────────┬─────────┘
                ▼
         SQL Analytics Views
      ┌─────────────────────────────┐
      │ vw_kpi_metrics              │
      │ vw_drug_market_share        │
      │ vw_specialty_penetration    │
      │ vw_state_normalized_metrics │
      │ vw_territory_glp1_summary   │
      └─────────────────────────────┘
                │
                ▼
          Tableau Dashboard
                │
                ▼
    Commercial Analytics Insights
```

---

## Data Model

The project uses a dimensional schema.

### Fact Table

`fact_glp1_prescriptions`

Contains:

- Prescription claims
- Provider utilization
- Drug spend
- Geography
- Provider specialty

### Dimension Tables

`dim_drug`

- Brand name
- Generic name
- Manufacturer

`dim_territory`

- State
- Territory region mapping

---

## SQL Analytics Pipeline

SQL views were created to support dashboard-ready analytics.

### Analytical Views

| View | Purpose |
|------|---------|
| `vw_kpi_metrics` | Dashboard KPI calculations |
| `vw_drug_market_share` | State-level GLP-1 competitive market share |
| `vw_specialty_penetration` | Specialty prescribing analysis |
| `vw_state_normalized_metrics` | State benchmarking metrics |
| `vw_territory_glp1_summary` | Primary Tableau summary layer |

---

## Dashboard Overview

![Dashboard Overview](screenshots/dashboard_overview.png)

---

### KPI Cards

Executive summary metrics used for rapid performance evaluation.

Includes:

- Total Claims
- Cost per Claim
- Total Spend
- Provider Count
- Spend per Provider

These provide a quick commercial snapshot of overall market performance.

---

### Spend per Provider by State

Ranks states by provider-level spend intensity.

**How to read it**

Higher bars indicate markets where providers generate greater GLP-1 spend.

This can suggest:

- stronger adoption
- higher-value prescribing
- more mature markets

---

### Total Spend by State

Compares aggregate GLP-1 spend across states.

**How to read it**

Larger bars indicate states contributing greater total commercial value.

This helps identify:

- high-priority commercial markets
- regional revenue concentration

---

### GLP-1 Utilization per Provider by State

Ranks provider-level utilization intensity.

**How to read it**

Higher values indicate providers write more GLP-1 claims on average.

Useful for identifying:

- high-adoption markets
- provider engagement opportunities

---

### GLP-1 Drug Market Share by State

Displays competitive market share across GLP-1 therapies by geography.

**How to read it**

Each bar represents a state.

Colors represent GLP-1 brands:

- Ozempic
- Wegovy
- Mounjaro
- Trulicity
- Rybelsus

The length of each colored segment represents percentage contribution to total spend.

This visualization helps identify:

- competitive dominance
- geographic variation in prescribing behavior
- commercialization opportunities

---

### GLP-1 State Benchmarking

Compares commercial performance across states using normalized metrics.

Includes:

- Claims per Provider
- Cost per Claim
- Provider Count
- Spend per Provider

**How to read it**

Allows rapid benchmarking across markets to identify unusually strong or weak commercial performance.

Conditional formatting highlights relative outliers.

---

### GLP-1 Market Opportunity Segmentation

This scatterplot compares provider utilization and spend intensity across states.

**How to read it**

- X-axis = Claims per Provider (utilization intensity)
- Y-axis = Spend per Provider (commercial value)
- Bubble size = Provider Count (market size)

Quadrants help segment market opportunities:

| Quadrant | Interpretation |
|---|---|
| Upper Right | High-value, high-utilization markets |
| Upper Left | High spend but lower utilization |
| Lower Right | Underpenetrated opportunity markets |
| Lower Left | Lower-priority markets |

Reference lines represent portfolio averages and help identify outlier markets.

Example interpretation:

- **New York** appears as a mature, high-value market with strong utilization.
- **Pennsylvania** demonstrates strong provider scale but comparatively lower spend intensity.

---

### Medical Specialty Penetration

Ranks provider specialties by GLP-1 prescribing intensity.

**How to read it**

Longer bars indicate specialties with stronger prescribing activity.

Useful for identifying:

- core prescribing specialties
- commercialization targeting opportunities
- specialty-specific adoption trends

---

## Example Insights

Example findings from the dashboard include:

- Northeastern states demonstrate comparatively high GLP-1 utilization and spend intensity.
- Market share varies considerably across geographies.
- Provider specialty penetration highlights endocrinology and primary care as major prescribing groups.
- Several markets demonstrate differing utilization versus spend dynamics, suggesting regional variation in prescribing behavior.

---

## Repository Structure

```text
sql/
├── 01_create_schema_tables.sql
├── 02_load_raw_data.sql
├── 03_create_analytics_views.sql
└── 04_validation_checks.sql

tableau/
screenshots/
docs/
```

---

## Future Improvements

Potential extensions include:

- Time-series forecasting
- Provider specialty deep dives
- Commercial opportunity scoring
- Automated ETL workflows
- Geographic market expansion analysis
