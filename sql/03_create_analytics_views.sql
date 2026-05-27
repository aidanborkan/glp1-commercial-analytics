-- View: public.vw_territory_glp1_summary

-- DROP VIEW public.vw_territory_glp1_summary;

CREATE OR REPLACE VIEW public.vw_territory_glp1_summary
 AS
 SELECT prscrbr_state_abrvtn,
    brnd_name,
    prscrbr_type,
    count(DISTINCT prscrbr_npi) AS provider_count,
    sum(tot_clms) AS total_claims,
    round(sum(tot_drug_cst), 2) AS total_drug_cost,
    round(avg(tot_drug_cst), 2) AS avg_provider_cost
   FROM fact_glp1_prescriptions
  GROUP BY prscrbr_state_abrvtn, brnd_name, prscrbr_type;

ALTER TABLE public.vw_territory_glp1_summary
    OWNER TO postgres;

