#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# ============================================================
# Medicare Part D Commercial Analytics ETL Preparation Script
#
# PURPOSE:
# This script prepares a healthcare commercial analytics dataset
# for Azure Data Factory ETL workflows.
#
# WORKFLOW:
# 1. Unzip CMS Medicare Part D dataset
# 2. Read large CSV in chunks
# 3. Filter to Northeast U.S. states
# 4. Filter to GLP-1 medications
# 5. Keep relevant analytics columns
# 6. Export cleaned CSV for Azure upload
#
# AUTHOR:
# Aidan Borkan
# ============================================================

# -------------------------
# Import required libraries
# -------------------------

import pandas as pd
from pathlib import Path
import zipfile

# ------------------------------------------------
# Define input ZIP file downloaded from CMS
# ------------------------------------------------

zip_file = Path(
    r"C:\Users\suzan\Downloads\Medicare Part D Prescribers - by Provider and Drug.zip"
)

# ------------------------------------------------
# Define folder where ZIP contents will be extracted
# ------------------------------------------------

extract_folder = Path(
    r"C:\Users\suzan\Downloads\medicare_partd_unzipped"
)

# Create folder if it does not exist
extract_folder.mkdir(exist_ok=True)

# ------------------------------------------------
# Unzip CMS dataset
# ------------------------------------------------

print("Extracting ZIP file...")

with zipfile.ZipFile(zip_file, 'r') as zip_ref:
    zip_ref.extractall(extract_folder)

print("Extraction complete.")

# ------------------------------------------------
# Locate extracted CSV automatically
# ------------------------------------------------

# Recursively search all subfolders for CSV files
csv_files = list(extract_folder.rglob("*.csv"))

if len(csv_files) == 0:
    raise FileNotFoundError("No CSV file found after extraction.")

# Use first CSV found
input_csv = csv_files[0]

print(f"Using CSV file: {input_csv}")

# ------------------------------------------------
# Define output CSV path
# ------------------------------------------------

output_file = Path(
    r"C:\Users\suzan\Downloads\northeast_glp1_prescriptions.csv"
)

# ------------------------------------------------
# Define Northeast states for territory analysis
# ------------------------------------------------

northeast_states = {
    "MA",  # Massachusetts
    "CT",  # Connecticut
    "RI",  # Rhode Island
    "NY",  # New York
    "NJ",  # New Jersey
    "PA",  # Pennsylvania
    "VT",  # Vermont
    "NH",  # New Hampshire
    "ME"   # Maine
}

# ------------------------------------------------
# Define GLP-1 medications of interest
# ------------------------------------------------

glp1_drugs = {
    "OZEMPIC",
    "WEGOVY",
    "MOUNJARO",
    "TRULICITY",
    "RYBELSUS"
}

# ------------------------------------------------
# Define columns we actually need
#
# This dramatically reduces memory usage.
# ------------------------------------------------

use_cols = [

    # Provider unique identifier
    "Prscrbr_NPI",

    # Provider name
    "Prscrbr_Last_Org_Name",
    "Prscrbr_First_Name",

    # Geographic territory
    "Prscrbr_State_Abrvtn",

    # Provider specialty
    "Prscrbr_Type",

    # Drug information
    "Brnd_Name",
    "Gnrc_Name",

    # Commercial KPIs
    "Tot_Clms",
    "Tot_Drug_Cst"
]

# ------------------------------------------------
# Prepare list to store filtered chunks
# ------------------------------------------------

filtered_chunks = []

# ------------------------------------------------
# Read very large CSV in chunks
#
# Why chunks?
# CMS datasets are extremely large and may not fit
# comfortably into memory all at once.
#
# Why usecols?
# Only reading necessary columns greatly reduces RAM usage.
#
# Why engine="python"?
# Helps avoid some parser/memory issues on huge CMS files.
# ------------------------------------------------

print("Filtering dataset...")

for chunk in pd.read_csv(
    input_csv,
    usecols=use_cols,
    chunksize=50_000,
    #low_memory=False,
    engine="python"
):

    # --------------------------------------------
    # Clean column names
    # --------------------------------------------

    chunk.columns = chunk.columns.str.strip()

    # --------------------------------------------
    # CMS column names
    # --------------------------------------------

    state_col = "Prscrbr_State_Abrvtn"
    brand_col = "Brnd_Name"

    # --------------------------------------------
    # Filter:
    # 1. Northeast states
    # 2. GLP-1 medications
    # --------------------------------------------

    filtered = chunk[
        chunk[state_col].isin(northeast_states)
        &
        chunk[brand_col]
            .astype(str)
            .str.upper()
            .isin(glp1_drugs)
    ]

    # --------------------------------------------
    # Store filtered rows if any exist
    # --------------------------------------------

    if not filtered.empty:
        filtered_chunks.append(filtered)

# ------------------------------------------------
# Combine all filtered chunks into one dataframe
# ------------------------------------------------

result = pd.concat(filtered_chunks, ignore_index=True)

# ------------------------------------------------
# Save cleaned dataset
# ------------------------------------------------

result.to_csv(output_file, index=False)

# ------------------------------------------------
# Print summary statistics
# ------------------------------------------------

print("===================================")
print("ETL PREPARATION COMPLETE")
print("===================================")
print(f"Rows exported: {len(result):,}")
print(f"Output file: {output_file}")
print("===================================")


# In[4]:


print(wd)


# In[ ]:




