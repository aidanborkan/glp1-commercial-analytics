-- Load raw GLP-1 prescription fact data
-- Update the file path before running locally.

COPY public.fact_glp1_prescriptions
FROM '"C:\Users\suzan\Downloads\northeast_glp1_prescriptions_processed.csv"'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"'
);