-- ============================================================
-- GLP-1 Commercial Analytics Database Schema
-- Purpose: Define fact and dimension tables used for SQL-based
-- prescription analytics and Tableau dashboard reporting.
-- ============================================================

-- Optional reset for reproducible local rebuilds.
-- Uncomment only when intentionally recreating the database.
-- DROP TABLE IF EXISTS public.fact_glp1_prescriptions;
-- DROP TABLE IF EXISTS public.dim_territory;
-- DROP TABLE IF EXISTS public.dim_drug;


-- ============================================================
-- Fact Table: Prescription-Level GLP-1 Utilization and Spend
-- Grain: one row per prescriber, state, prescriber type, and drug.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.fact_glp1_prescriptions (
    prscrbr_npi bigint,
    prscrbr_last_org_name text,
    prscrbr_first_name text,
    prscrbr_state_abrvtn text,
    prscrbr_type text,
    brnd_name text,
    gnrc_name text,
    tot_clms integer,
    tot_drug_cst numeric
);

COMMENT ON TABLE public.fact_glp1_prescriptions IS
'Fact table containing GLP-1 prescription utilization and drug cost metrics by prescriber, geography, specialty, and drug.';


-- ============================================================
-- Dimension Table: Territory
-- Purpose: maps state abbreviation to broader commercial region.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.dim_territory (
    state text,
    territory_region text
);

COMMENT ON TABLE public.dim_territory IS
'Territory dimension mapping state abbreviations to regional market groupings.';


-- ============================================================
-- Dimension Table: Drug
-- Purpose: standardizes brand, generic, and manufacturer metadata.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.dim_drug (
    brnd_name text,
    gnrc_name text,
    manufacturer text
);

COMMENT ON TABLE public.dim_drug IS
'Drug dimension containing GLP-1 brand, generic, and manufacturer metadata.';


-- ============================================================
-- Ownership
-- ============================================================

ALTER TABLE IF EXISTS public.fact_glp1_prescriptions OWNER TO postgres;
ALTER TABLE IF EXISTS public.dim_territory OWNER TO postgres;
ALTER TABLE IF EXISTS public.dim_drug OWNER TO postgres;