\# GLP-1 Commercial Analytics Dashboard



\# GLP-1 Market Access \& Commercial Analytics



\## Project Overview



\## Business Objective



\## Data Source



\## Architecture Diagram



\## Data Model



\## SQL Analytics Pipeline



\## Dashboard Overview



\### KPI Cards

\### Spend per Provider by State

\### Total Spend by State

\### GLP-1 Utilization per Provider by State

\### Drug Market Share by State

\### State Benchmarking

\### Market Opportunity Segmentation

\### Medical Specialty Penetration



\## How to Interpret the Dashboard



\## Example Insights



\## Repository Structure



\## Future Improvements





\## Architecture Diagram



```text

Public Medicare / Part D GLP-1 Data

&#x20;               │

&#x20;               ▼

&#x20;       PostgreSQL Database

&#x20;               │

&#x20;     ┌─────────┴─────────┐

&#x20;     │                   │

&#x20;     ▼                   ▼

&#x20;Dimension Tables      Fact Table

&#x20;(Drug, Territory)     Prescriptions

&#x20;     │                   │

&#x20;     └─────────┬─────────┘

&#x20;               ▼

&#x20;        SQL Analytics Views

&#x20;     ┌────────────────────────┐

&#x20;     │ vw\_kpi\_metrics         │

&#x20;     │ vw\_drug\_market\_share   │

&#x20;     │ vw\_specialty\_penetration│

&#x20;     │ vw\_state\_normalized\_metrics │

&#x20;     │ vw\_territory\_glp1\_summary   │

&#x20;     └────────────────────────┘

&#x20;               │

&#x20;               ▼

&#x20;        Tableau Dashboard

&#x20;               │

&#x20;               ▼

&#x20;Commercial Analytics Insights

```



\### GLP-1 Market Opportunity Segmentation



This scatterplot compares provider-level utilization and spend intensity across states.



\*\*How to read it\*\*



\- X-axis = claims per provider (utilization intensity)

\- Y-axis = spend per provider (commercial value)

\- Bubble size = provider count (market size)



Quadrants help segment market opportunities:



| Quadrant | Interpretation |

|-----------|---------------|

| Upper right | High-value, high-utilization markets |

| Upper left | High spend but lower utilization |

| Lower right | Underpenetrated opportunity markets |

| Lower left | Lower-priority markets |



The reference lines represent portfolio averages and help identify outlier markets.



Example interpretation:

\- \*\*New York\*\* appears as a mature, high-value market with strong utilization.

\- \*\*Pennsylvania\*\* demonstrates comparatively high provider scale with lower spend intensity, potentially suggesting pricing, prescribing mix, or market maturity differences.



\### GLP-1 Drug Market Share by State



Displays competitive market share across GLP-1 therapies by geography.



\*\*How to read it\*\*



Each bar represents a state.



Colors represent GLP-1 brands:



\- Ozempic

\- Wegovy

\- Mounjaro

\- Trulicity

\- Rybelsus



The length of each colored segment represents percentage contribution to total drug spend within a market.



This visualization helps identify:



\- competitive dominance

\- geographic variation in prescribing patterns

\- commercialization opportunities



\### GLP-1 State Benchmarking



Compares commercial performance across states using normalized metrics.



Includes:



\- Claims per provider

\- Cost per claim

\- Provider count

\- Spend per provider



\*\*How to read it\*\*



The table enables quick comparison of market efficiency and provider utilization.



Color formatting highlights outlier markets relative to peers.



\### Medical Specialty Penetration



Ranks provider specialties by average GLP-1 prescribing utilization.



\*\*How to read it\*\*



Longer bars indicate specialties with greater prescribing activity.



This analysis helps identify:



\- core prescribing specialties

\- commercialization targeting opportunities

\- specialty-specific adoption trends





