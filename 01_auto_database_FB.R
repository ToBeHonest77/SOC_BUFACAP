# install.packages("readxl")
# install.packages("purrr")
# install.packages("dplyr")
# install.packages("tibble")

library(readxl)
library(purrr) # tidyverse
library(dplyr)
library(tibble)
library(readr) # read and write as csv

#----------------------- read from output/*experiment*/ -----------------------#
## this step only works after the whole script has been performed beforehand
### for plotting and further processing continue at the bottom >>>

# Specify the directory where your CSV files are located
csv_dir <- "output/farako_ba/" # change dir to different LTFEs

# Get a list of all CSV files in the directory
csv_files <- list.files(path = csv_dir, pattern = "*.csv", full.names = TRUE)

# Read all CSV files into a list of dataframes
df_list <- map(csv_files, ~read_csv2(.) %>% select(-1)) # -1 to get rid of first column

# Name the dataframes based on the file names (without extension)
names(df_list) <- tools::file_path_sans_ext(basename(csv_files))

# # Rename experiments for consistency
# df_list1 <- lapply(df_list, rename, "Farako-Ba" = "Farako-ba")
# 
# for (eID in seq_along(df_list)) {
#   if (names(df_list)[eID] == "Farako-ba") {
#     names(df_list)[eID] <- "Farako-Ba"
#   }
# }

# Unpack list to global environment
list2env(df_list, .GlobalEnv)

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
## they should be cleaned as well eventually

#------------------------- filter a specific experiment -----------------------#
## saves specific experiment to output/dir and from there it can be further processed
### 1 = experiment, 2 = amendments, 3 = crops, 4 = datacrop, 5 = datasoil, 6 = soiltype, 7 = treatment

# Make a list for filtering
list_f <- list(f1, f2, f3, f4, f5, f6, f7)

##---------- Change names of experiment in next run!
# Define filter criteria
filter_criteria <- function(df) {
  df %>% 
    filter(eID == "Farako-ba") %>% # name any experiment
    # rename("Farako-Ba" = "Farako-ba")
}

# Apply filter to all dfs in list
list_farako_ba <- map(list_f, filter_criteria)

names(list_farako_ba) <- c("fb_experiment", "fb_amendments", "fb_crops", "fb_datacrop", 
                           "fb_datasoil", "fb_soiltype", "fb_treatment")

# Unpack list to global environment
list2env(list_farako_ba, .GlobalEnv)

# Define output directory
output_dir <- "output/farako_ba/"

# Save all dfs from list as CSV to wd
map2(list_farako_ba, names(list_farako_ba), function(df, name) {
  write.csv2(df, file = paste0(output_dir, name, ".csv"))
})

# # Only dfs with eID and tID
# list_fb_eID_tID <- list(fb_amendments, fb_crops, fb_treatment, fb_datacrop, fb_datasoil)
# 
# # Only dfs for datasoil and datacrop
# list_fb_eID_tID <- list(fb_amendments, fb_crops, fb_treatment, fb_datacrop, fb_datasoil)
# 
# # # Perform full join, maybe this time it works?
# # merged_farako_ba <- list_fb_eID_tID %>%
# #   reduce(full_join, by = c("eID", "tID"))
# 
# # Filter and merge different treatments
# c_fb <- list_fb_eID_tID %>%
#   map(~ filter(., tID == "C-FB")) %>% # filter for treatment
#   reduce(left_join, by = "tID") %>% # not sure if it works
#   dplyr::select(where(~!all(is.na(.)))) %>% # remove columns where all values are NA
#   distinct(across(everything()), .keep_all = TRUE) # only keep distinct rows
# 
# # Only join fb_datacrop and _datasoil
# cropsoil_fb <- fb_datasoil %>% 
#   left_join(fb_datacrop, by = c("tID", "eID")) %>% 
#   dplyr::select(where(~!all(is.na(.)))) # remove columns where all values are NA

# # For Farako-Ba there is no data available regarding harvested yields per year,
# # only average numbers > thus, table above makes no sense
# c_fb2 <- c_fb1 %>% 
#   filter(cID.y == "Farako-ba_all treatments_year1_>> Sorghum/Great millet/Sorghum bicolor")

# Print time for processing code
print(Sys.time() - start)

#---------------------- plot treatments and SOC stocks ------------------------#
library(ggplot2)
library(tidyr)
library(gridExtra) # Now, let's combine all plots into a single figure

# Calculate the overall min and max of SOC_stock
y_min <- min(fb_datasoil$SOC_stock_Mg.ha, na.rm = TRUE)
y_max <- max(fb_datasoil$SOC_stock_Mg.ha, na.rm = TRUE)

# Calculate a reasonable step size (e.g., 1/10th of the range)
y_step <- (y_max - y_min) / 10

# Create a list of plots, one for each treatment
plot_list <- fb_datasoil %>%
  split(.$tID) %>% # split plots for each treatment
  map(function(data) {
    ggplot(data, aes(x = Sample_year, y = SOC_stock_Mg.ha, group = 1)) +
      geom_line() +
      geom_point() +
      theme_minimal(base_line_size = 20) +
      labs(title = paste("Treatment:", unique(data$tID)),
           x = "Year",
           y = "SOC stock (Mg/ha)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            plot.title = element_text(size = 10),
            axis.title = element_text(size = 9),
            axis.text = element_text(size = 8)) +
      scale_y_continuous(
        limits = c(y_min, y_max),
                         breaks = seq(y_min, y_max, by = y_step)) +  # Set common y-axis limits
      scale_x_continuous(
        breaks = function(x) seq(ceiling(min(x)), floor(max(x)), by = 5),
        labels = function(x) format(x, nsmall = 0)
      )
  })


# please note: C2-FB shows the natural grassland and hence, has the highest SOC stock (no conversion)
combined_plot <- do.call(grid.arrange, c(plot_list, ncol = length(plot_list)))
 
# ## If necessary, this helps!
# # Arrange the plots in a 2x5 grid (5 plots in first row, 4 in second)
# combined_plot <- grid.arrange(
#   grobs = plot_list,
#   layout_matrix = rbind(1:5, c(6:9, NA)),
#   widths = rep(1, 5),
#   heights = c(1, 1)
# )

# Display the combined plot
print(combined_plot)

# If you want to save the plot
ggsave("plots/SOC_treatments_FB.png", combined_plot, width = 20, height = 10, units = "in")
