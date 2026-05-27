-- ============================================================
-- Validation Checks
-- Purpose: Confirm row counts, totals, joins, and dashboard-ready
-- aggregates before connecting Tableau.
-- ============================================================


-- 1. Row counts by source table
SELECT 'fact_glp1_prescriptions' AS table_name, COUNT(*) AS row_count
FROM public.fact_glp1_prescriptions
UNION ALL
SELECT 'dim_drug', COUNT(*)
FROM public.dim_drug
UNION ALL
SELECT 'dim_territory', COUNT(*)
FROM public.dim_territory;


-- 2. Missing drug dimension matches
SELECT
    f.brnd_name,
    f.gnrc_name,
    COUNT(*) AS unmatched_rows
FROM public.fact_glp1_prescriptions f
LEFT JOIN public.dim_drug d
    ON f.brnd_name = d.brnd_name
WHERE d.brnd_name IS NULL
GROUP BY f.brnd_name, f.gnrc_name
ORDER BY unmatched_rows DESC;


-- 3. Missing territory dimension matches
SELECT
    f.prscrbr_state_abrvtn,
    COUNT(*) AS unmatched_rows
FROM public.fact_glp1_prescriptions f
LEFT JOIN public.dim_territory t
    ON f.prscrbr_state_abrvtn = t.state
WHERE t.state IS NULL
GROUP BY f.prscrbr_state_abrvtn
ORDER BY unmatched_rows DESC;


-- 4. Dashboard totals from final summary view
SELECT
    COUNT(*) AS summary_rows,
    COUNT(DISTINCT prscrbr_state_abrvtn) AS states,
    COUNT(DISTINCT brnd_name) AS brands,
    SUM(total_claims) AS total_claims,
    ROUND(SUM(total_drug_cost), 2) AS total_drug_cost,
    SUM(provider_count) AS provider_count
FROM public.vw_territory_glp1_summary;


-- 5. State-level validation totals
SELECT
    prscrbr_state_abrvtn,
    SUM(total_claims) AS total_claims,
    ROUND(SUM(total_drug_cost), 2) AS total_drug_cost,
    SUM(provider_count) AS provider_count
FROM public.vw_territory_glp1_summary
GROUP BY prscrbr_state_abrvtn
ORDER BY total_drug_cost DESC;


-- 6. Cost per claim sanity check
SELECT
    prscrbr_state_abrvtn,
    ROUND(SUM(total_drug_cost) / NULLIF(SUM(total_claims), 0), 2) AS cost_per_claim
FROM public.vw_territory_glp1_summary
GROUP BY prscrbr_state_abrvtn
ORDER BY cost_per_claim DESC;
