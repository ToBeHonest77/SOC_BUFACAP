# install.packages("raster")
# install.packages("sp")
# install.packages("lubridate")

library(dplyr)
library(tidyr)
library(raster)
library(sp)
library(lubridate)

# # Track time
# start <- Sys.time()
# print(Sys.time() - start)

#----- read raster files and create point shapefiles for each experiment ------#

# Read the .tif file from wd
temp_data <- stack("ERA5/ERA5_Land_monthly_temperature_Layer_Stack.tif")
prec_data <- stack("ERA5/ERA5_Land_Monthly_Prec_Layer_Stack.tif")
evapo_data <- stack("ERA5/ERA5_Land_monthly_potential_evapo_Layer_Stack.tif")

# # Combine to one raster file
# climate_data <- merge(temp_data, prec_data, evapo_data)

# Read coordinates from tbl_experiment (auto_database.R)
locations <- data.frame(
    x = tbl_experiment$Longitude,
    y = tbl_experiment$Latitude,
    Experiment = tbl_experiment$`Experiment ID`
)

# Convert to numeric values
locations$x <- as.numeric(locations$x)
locations$y <- as.numeric(locations$y)

# Remove NAs
locations <- na.omit(locations)

# Convert coordinates to spatial points
points <- SpatialPoints(locations, proj4string = crs(climate_data))

#------------ extract raster values for temp, prec and evapo ------------------#
## this process takes approx. 15 mins per raster stack

#------------------------------temp
# Start time measurement for extracting raster data with point shapefile
start <- Sys.time()         
# Extract values for temp
point_temp <- raster::extract(temp_data, points)
# Remove NAs
point_temp <- na.omit(point_temp)
# Print time for processing
print(Sys.time() - start)

#------------------------------prec
# Track time for process
start <- Sys.time()
# Extract values for prec
point_prec <- raster::extract(prec_data, points)
# Print time
print(Sys.time() - start) # 15.26714 mins
# Remove NAs
point_prec <- na.omit(point_prec)

#------------------------------evapo
# Track time for process
start <- Sys.time()
# Extract values for evapo
point_evapo <- raster::extract(evapo_data, points)
# Print time
print(Sys.time() - start) # 13.46965 mins
# Remove NAs
point_evapo <- na.omit(point_evapo)

#----------------------- pivot into long data frame ---------------------------#
## 1 = Farako-ba, 2 = Sapone
### waiting for climate data for sub-Saharan West-Africa (14.10.24)

# Create a sequence of dates
## Last 01 gets trimmed in next stept
dates <- seq(as.Date("1970-01-01"), by = "month", length.out = ncol(point_temp))

# Convert into data frame for temp
result_temp <- data.frame(
  YearMonth = rep(format(dates, "%Y-%m"), each = 2),
  Temp = as.vector(point_temp),
  Experiment = rep(c(1, 2), times = ncol(point_temp)) # adjust according to number of experiments
)

# Convert into data frame for prec
result_prec <- data.frame(
  YearMonth = rep(format(dates, "%Y-%m"), each = 2),
  Prec = as.vector(point_prec),
  Experiment = rep(c(1, 2), times = ncol(point_prec)) # adjust according to number of experiments
)

# Convert into data frame for evapo
result_evapo <- data.frame(
  YearMonth = rep(format(dates, "%Y-%m"), each = 2),
  Evapo = as.vector(point_evapo),
  Experiment = rep(c(1, 2), times = ncol(point_evapo)) # adjust according to number of experiments
)

# Multiply evapo x -1000 to convert to positive mm units
## Original evaporation values are in m
result_evapo1 <- result_evapo %>% 
  mutate(Evapo = Evapo * -1000)

# Re-assign after value check
result_evapo <- result_evapo1

# Remove unused dfs
rm(result_evapo1)

# Merge, reorder and pivot results
result_climate <- result_temp %>% 
  left_join(result_prec, by = c("YearMonth", "Experiment")) %>% 
  left_join(result_evapo, by = c("YearMonth", "Experiment")) %>% 
  select(YearMonth, Temp, Prec, Evapo, Experiment) %>% 
  pivot_longer(cols = c(Temp, Prec, Evapo), names_to = "Variable", values_to = "Value")

# Rename values with '1' = Experiment1 etc...
result_climate <- result_climate %>%
  mutate(Experiment = case_when(
    Experiment == 1 ~ "Farako-ba",
    Experiment == 2 ~ "Sapone",
    TRUE ~ as.character(Experiment)
  ))

#---------------------- save results to output (wd) ---------------------------#

# # Save results as csv
# ## Watch out! overwrite = T
# write.csv2(result_temp, file = "output/result_temp.csv")
# write.csv2(result_prec, file = "output/result_prec.csv")
# write.csv2(result_evapo, file = "output/result_evapo.csv")
# write.csv2(result_climate, file = "output/result_climate.csv")

# # Write raster to working directory
# writeRaster(merged_raster, "path/to/merged_output.tif", format="GTiff")

#------------------------------- plot results ---------------------------------#
library(ggplot2)

# Assign climate data
plot_data <- result_climate

# Focus on annual trends
annual_data <- plot_data %>%
  mutate(Year = substr(YearMonth, 1, 4)) %>%
  group_by(Year, Experiment, Variable) %>%
  summarise(AnnualMean = mean(Value, na.rm = TRUE)) %>%
  ungroup()

# Convert to numeric for plotting
annual_data$Year <- as.numeric(as.character(annual_data$Year))

# First, let's separate temperature data from precipitation and evaporation
annual_temp <- annual_data %>% filter(Variable == "Temp")
annual_prec_evap <- annual_data %>% filter(Variable != "Temp")

# Calculate the ratio for scaling
temp_range <- range(annual_temp$AnnualMean, na.rm = TRUE)
prec_evap_range <- range(annual_prec_evap$AnnualMean, na.rm = TRUE)
scale_ratio <- diff(prec_evap_range) / diff(temp_range)

# Create a plot combining all variables by scaling
combined_plot <- ggplot() +
  # Temperature data
  geom_line(data = annual_temp, aes(x = Year, y = AnnualMean, color = Variable)) +
  geom_point(data = annual_temp, aes(x = Year, y = AnnualMean, color = Variable), size = 1) +
  # Precipitation and Evaporation data
  geom_line(data = annual_prec_evap, aes(x = Year, y = AnnualMean / scale_ratio, color = Variable)) +
  geom_point(data = annual_prec_evap, aes(x = Year, y = AnnualMean / scale_ratio, color = Variable), size = 1) +
  facet_wrap(~Experiment, ncol = 1) +
  scale_x_continuous(breaks = seq(1970, 2024, by = 5)) +
  scale_y_continuous(
    name = "Temperature [°C]",
    sec.axis = sec_axis(~.*scale_ratio, name = "Precipitation & Evaporation [mm]")
  ) +
  scale_color_manual(values = c("Temp" = "red", "Prec" = "blue", "Evapo" = "green")) +
  labs(title = "Annual Mean Temperature, Precipitation, and Evaporation (1970-2024)",
       x = "Year",
       color = "Variable") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom",
    axis.title.y.left = element_text(color = "red"),
    axis.title.y.right = element_text(color = "blue") + 
  geom_text(data = data.frame(x = 1970, y = Inf, Experiment = unique(annual_data$Experiment)),
      aes(x = x, y = y, label = Experiment), 
      hjust = 0, vjust = 1, inherit.aes = FALSE, color = "black", size = 3
    )
  )

# Temperature plot
temp_plot <- ggplot(annual_temp, aes(x = Year, y = AnnualMean, color = Experiment)) +
  geom_line() +
  geom_point(size = 1) +
  scale_x_continuous(breaks = seq(1970, 2024, by = 5)) +
  scale_color_manual(values = c("Farako-ba" = "red", "Sapone" = "blue")) +
  labs(title = "Annual Mean Temperature (1970-2024)",
       x = "Year",
       y = "Temperature [°C]",
       color = "Location") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "bottom")

# Precipitation and Evaporation plot
prec_evap_plot <- ggplot(annual_prec_evap, aes(x = Year, y = AnnualMean, color = Variable, linetype = Experiment)) +
  geom_line() +
  geom_point(size = 1) +
  scale_x_continuous(breaks = seq(1970, 2024, by = 5)) +
  scale_color_manual(values = c("Prec" = "blue", "Evapo" = "green")) +
  scale_linetype_manual(values = c("Farako-ba" = "solid", "Sapone" = "dashed")) +
  labs(title = "Annual Mean Precipitation and Evaporation (1970-2024)",
       x = "Year",
       y = "Precipitation & Evaporation [mm]",
       color = "Variable",
       linetype = "Location") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "bottom")

# Print the plots
print(temp_plot)
print(prec_evap_plot)
print(combined_plot)

# # Save the plots
# ggsave("plots/temp_plot.png", temp_plot, width = 10, height = 6)
# ggsave("plots/prec_evap_plot.png", prec_evap_plot, width = 10, height = 6)
# ggsave("plots/combined_plot.png", combined_plot, width = 10, height = 6)
