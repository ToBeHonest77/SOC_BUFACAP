# install.packages("readxl")
# install.packages("purrr")
# install.packages("dplyr")
# install.packages("tibble")

library(readxl)
library(purrr) # tidyverse
library(dplyr)
library(tibble)

#-------------- read EJPSoil BUFACAP database excel sheet ---------------------#

# The idea is to create a script which automatically reads data from excel-sheet database with many tabs
# Cloud location of sheet: https://uniquelandusede149.sharepoint.com/:x:/s/1_08ProjekteUL2022/ETngkp6ABnpLpmcY818BsJoBIw8DiQxCHEJqeEGT2SelKQ?e=fgagW1
# Download a copy into working directory > use getwd() to find out

# Track time for reading and splitting sheets
start <- Sys.time()

# Read database (db) from working directory (wd) using readxl
excel_file <- "EJPSoil_BUFACAP_template.xlsx" # make sure current version of db is in your wd
all_sheets <- lapply(excel_sheets(excel_file), read_excel, path = excel_file)

# Get sheet names
names(all_sheets) <- excel_sheets("EJPSoil_BUFACAP_template.xlsx")

# Function to extract only sheets with data
extract_non_empty_sheets <- function(excel_file) {
  # Get all sheet names
  sheet_names <- excel_sheets(excel_file)
  
  # Read all sheets and filter out empty ones
  all_sheets <- map(sheet_names, function(sheet) {
    df <- tryCatch(
      read_excel(excel_file, sheet = sheet),
      error = function(e) NULL
    )
    
    if (!is.null(df) && nrow(df) > 0 && ncol(df) > 0) {
      return(df)
    } else {
      return(NULL)
    }
  })
  
  # Remove NULL elements (empty sheets)
  non_empty_sheets <- compact(all_sheets)
  
  # Name the list elements with sheet names
  names(non_empty_sheets) <- sheet_names[sapply(all_sheets, function(x) !is.null(x))]
  
  return(non_empty_sheets)
}

# Use function on excel_file to create list
result <- extract_non_empty_sheets(excel_file)

# Create individual dataframes(dfs) from result
for (i in seq_along(result)) {
  assign(paste0("df_", names(result)[i]), result[[i]])
}

# Remove unnecessary dfs
rm(df_README, df_description, df_dropDownList, df_RothC)

#---------------------------- clean single dfs --------------------------------#

# # Make second row as column name
# colnames(df_amendment) <- as.character(df_amendment[2, ])
# 
# # Remove first 3 rows
# df_amendment <- df_amendment[-(1:3), ] # indicates rows exactly
# 
# # Resets rownames
# rownames(df_amendment) <- NULL
# 
# # Remove rows where all values are NA
# df_amendment_clean <- df_amendment[rowSums(is.na(df_amendment)) != ncol(df_amendment), ]

#-------------------------------- clean dfs -----------------------------------#

# Create list of tibbles from all dataframes
## always indicate df with tab to get real names, especially the high commata of `df_name` for certain dfs
tbl_list <- list(tbl_datacrop = `df_data-crop`, tbl_crops = `df_crops`, tbl_datasoil = `df_data-soil`,
                 tbl_experiment = `df_experiment`, tbl_soiltype = `df_soil-type`, tbl_tillage = df_tillage,
                 tbl_treatment = df_treatment, tbl_reference = df_reference, #tbl_rawdata = `df_raw-data`, 
                 tbl_irrigation = df_irrigation, tbl_amendment = df_amendment)

# Apply different cleaning steps to all tibbles inside list
clean_tibbles <- tbl_list %>%
  map(~ {
    # Make the second row the header
    names(.x) <- as.character(slice(.x, 2))
    .x %>%
      # Remove the first 3 rows
      slice(-(1:3)) %>%
      # Remove columns where all values are NA
      dplyr::select(where(~!all(is.na(.)))) %>%
      # Remove rows where all values are NA
      filter(rowSums(!is.na(.)) > 0)
  })

# Unpack list to global environment
list2env(clean_tibbles, .GlobalEnv)

rm(df_amendment, df_climate, df_crops, `df_data-crop`, `df_data-soil`, df_experiment,
   df_irrigation, df_reference, `df_soil-type`, df_tillage, df_treatment, `df_raw-climate`,
   all_sheets)

# Print time for processing code
print(Sys.time() - start)
#--------------------- merge tbls and group by experiment ---------------------#
## merging all tbls (full_join) makes no sense and takes way too long...
### hence, performing experiment- and treatment-wise filters and selections should work! 

# # Perform the full join, but way to memory intensive
# merged_tbl <- clean_tibbles %>%
#   reduce(full_join, by = "Experiment ID")

# Select columns for experiment
f1 <- tbl_experiment %>% 
  select(`Experiment ID`,Latitude,Longitude,Country,`Land use prior experiment`) %>% 
  rename(eID = `Experiment ID`, y = Latitude, x = Longitude, Prior_landuse = `Land use prior experiment`)

# Set coordinates as numeric
f1$y <- as.numeric(f1$y) 
f1$x <- as.numeric(f1$x) 

# Select columns for amendments  
f2 <- tbl_amendment %>% 
  select(`Experiment ID`,`Treatment ID`,Rotation,`Type of fertilizer/amendment`, `Fertilizer/Amendment application rate`,
         `Fertilizer/Amendment application method`,`Estimated C input`) %>% 
  rename(eID = `Experiment ID`, tID = `Treatment ID`, Type = `Type of fertilizer/amendment`, Rate_kg.ha.y = `Fertilizer/Amendment application rate`,
         Method = `Fertilizer/Amendment application method`, C_input = `Estimated C input`)

# Set as.numeric
f2$Rate_kg.ha.y <- as.numeric(f2$Rate_kg.ha.y)
f2$C_input <- as.numeric(f2$C_input)

# Select, filter NAs and rename columns for crops
f3 <- tbl_crops %>% 
  select(!(`Residues burning`:`Crop (comment)`)) %>% 
  rename(eID = `Experiment ID`, tID = `Treatment ID`, cID = `Crop ID`, Crop_type = `Crop type`, 
         Cropping_system = `Cropping system`, Harvesting_method = `Harvesting/Termination method`,
         Harvesting_freq = `Harvesting frequency`, Sowing_period = `Sowing period`, 
         Harvesting_period = `Harvesting/Termination period`, Residues_removal = `Residues removal`,
         Residues_inc = `Residues incorporation`) %>% 
  filter(if_any(everything(), # cID retains "___" from automatic field generator in excel
                ~!grepl("___", ., fixed = TRUE) & !is.na(.))) 

# Set as.numeric
f3$Harvesting_freq <- as.numeric(f3$Harvesting_freq)

# Select and rename columns for datacrop
f4 <- tbl_datacrop %>% 
  select(!(`Publication ID`)) %>% 
  rename(eID = `Experiment ID`, tID = `Treatment ID`, cID = `Crop ID`, Sample_year = `Sampling year`,
         Yield_kg.ha = `Harvested yield`, Water_content = `Harvested yield water content`,
         Water_content_mass = `Harvested yield water content amount`, Residues_above_Mg.ha = `Residue above-ground`,
         Sample_depth_cm = `Below-ground sampling depth`, DC_Comment = `Data crop (comment)`)

# Set as.numeric
f4$Sample_year <- as.numeric(f4$Sample_year) # NAs where year is not given
f4$Yield_kg.ha <- as.numeric(f4$Yield_kg.ha)
f4$Water_content_mass <- as.numeric(f4$Water_content_mass)
f4$Residues_above_Mg.ha <- as.numeric(f4$Residues_above_Mg.ha)
f4$Sample_depth_cm <- as.numeric(f4$Sample_depth_cm)

# Select and rename columns for datasoil
f5 <- tbl_datasoil %>% 
  select(!(`Publication ID`)) %>% 
  rename(eID = `Experiment ID`, tID = `Treatment ID`, Sample_year = `Sampling year`, 
         Depth_from_cm = `Depth from`, Depth_to_cm = `Depth to`, SOC_conc_g.kg = `SOC conc`, 
         SOC_conc_SE_g.kg = `SOC conc SE`, Bulk_density_Mg.m3 = `Bulk density`, 
         BD_method = `Bulk density method`, BD_nsamples = `Bulk density nb samples`, 
         SOC_stock_Mg.ha = `SOC stock`, SOC_stock_SE_Mg.ha = `SOC stock SE`, 
         pH_method = `pH method`, DS_comment = `Data soil (comment)`)

# Set as.numeric
f5$Sample_year <- as.numeric(f5$Sample_year)
f5$Depth_from_cm <- as.numeric(f5$Depth_from_cm)
f5$Depth_to_cm <- as.numeric(f5$Depth_to_cm)
f5$SOC_conc_g.kg <- as.numeric(f5$SOC_conc_g.kg)
f5$SOC_conc_SE_g.kg <- as.numeric(f5$SOC_conc_SE_g.kg)
f5$Bulk_density_Mg.m3 <- as.numeric(f5$Bulk_density_Mg.m3)
f5$BD_nsamples <- as.numeric(f5$BD_nsamples)
f5$SOC_stock_Mg.ha <- as.numeric(f5$SOC_stock_Mg.ha)
f5$SOC_stock_SE_Mg.ha <- as.numeric(f5$SOC_stock_SE_Mg.ha)
f5$pH <- as.numeric(f5$pH)

# Select all columns and rename for soiltype
f6 <- tbl_soiltype %>% 
  select(!(`Gravel (> 2 mm)`)) %>% 
  rename(eID = `Experiment ID`, Top_depth_cm = `Top depth of layer`, Bottom_depth_cm = `Bottom depth of layer`,
         Clay = `Clay (< 0.002 mm)`, Silt = `Silt (0.002 - 0.05 mm)`, Sand = `Sand (0.05 - 2 mm)`, 
         Texture_USDA = `Soil texture USDA`, Group_WRB = `Soil group WRB`, Group_quali_WRB = `Soil group WRB qualifier`,
         Type_USDA = `Soil type USDA`, ST_comment = `Soil (comment)`)

# Set as.numeric
f6$Top_depth_cm <- as.numeric(f6$Top_depth_cm)
f6$Bottom_depth_cm <- as.numeric(f6$Bottom_depth_cm)
f6$Clay <- as.numeric(f6$Clay)
f6$Silt <- as.numeric(f6$Silt)
f6$Sand <- as.numeric(f6$Sand)

# Rename columns for treatment
f7 <- tbl_treatment %>% 
  rename(eID = `Experiment ID`, tID = `Treatment ID`, Definition = `Treatment definition`,
         Land_use = `Land use`, Start_year = `Year started`, End_year = `Year ended`,
         Crop_rotation = `Crop rotation`, T_comment = `Treatment (comment)`, Practice_category = Category)

# Set as.numeric
f7$Start_year <- as.numeric(f7$Start_year)
f7$End_year <- as.numeric(f7$End_year)

### and so on... tbls missing are: tbl_irrigation, tbl_tillage
## should be cleaned as well eventually

#------------------------- filter experiment to work with ---------------------#
### 1 = experiment, 2 = amendments, 3 = crops, 4 = datacrop, 5 = datasoil, 6 = soiltype, 7 = treatment

# Make a list for filtering
list_f <- list(f1, f2, f3, f4, f5, f6, f7)

# Define filter criteria
filter_criteria <- function(df) {
  df %>% 
    filter(eID == "Farako-ba")
}

# Apply filter to all dfs in list
list_farako_ba <- map(f_list, filter_criteria)

names(list_farako_ba) <- c("fb_experiment", "fb_amendments", "fb_crops", "fb_datacrop", 
                           "fb_datasoil", "fb_soiltype", "fb_treatment")

# Unpack list to global environment
list2env(list_farako_ba, .GlobalEnv)
