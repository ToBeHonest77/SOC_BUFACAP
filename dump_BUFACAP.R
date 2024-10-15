#---------------------- dump from climate_data.R (14.10.24) -------------------#

# generate_date_df <- function(start_date, end_date) {
#   start <- as.Date(start_date)
#   end <- as.Date(end_date)
# 
#   dates <- seq(start, end, by = "month")
# 
#   date_df <- data.frame(
#     year = year(dates),
#     month = month(dates),
#     date = dates
#   )
# 
#   return(date_df)
# }
# 
# # Generate the date data frame
# date_df <- generate_date_df("1970-01-01", "2024-06-01")
# 
# # Verify the result
# head(date_df)
# tail(date_df)
# nrow(date_df)  # This should be 654
# 
# # Create the final data frame
# result_temp1 <- data.frame(
#   year = rep(date_df$year, times = nrow(points)),
#   month = rep(date_df$month, times = nrow(points)),
#   value = as.vector(t(extracted_values)),
#   point_id = rep(1:nrow(points), each = nrow(date_df))
# )
# 
# result_list <- list()
# for (i in 1:nrow(points)) {
#   result_list[[i]] <- data.frame(
#     year = date_df$year,
#     month = date_df$month,
#     value = extracted_values[i,],
#     point_id = i
#   )
# }
# result_df <- do.call(rbind, result_list)

# # Create function to read n bands from raster stack
# generate_dates <- function(start_date, num_bands) {
#   start <- as.Date(start_date)
#   dates <- seq(start, by = "month", length.out = num_bands)
#   return(dates)
# }
# 
# dates <- generate_dates("1970-01", nlayers(climate_data))
# 
# 
# # Extract values for temp
# point_temp <- extract(temp_data, points)
# 
# result_temp <- data.frame(
#   year = year(dates),
#   month = month(dates),
#   value = as.vector(t(point_temp))
# )
# 
# # Add point identifier
# result_temp$point_id <- rep(1:nrow(points), each = nlayers(raster_stack))


# # Reorder columns
# result_temp <- result_temp %>% select(YearMonth, Temp, Experiment)
# 
# # View the first few rows
# head(result_temp)
# 
# # Überprüfen Sie die Struktur
# str(result_temp)
# 
# # Überprüfen Sie die Anzahl der Zeilen
# print(nrow(result_temp))  # Sollte 1308 sein (654 * 2)
# 
# # Überprüfen Sie die Verteilung der Experimente
# print(table(result_temp$Experiment))  # Sollte 654 für jedes Experiment zeigen
# 
# # Überprüfen Sie die einzigartigen YearMonth-Werte
# print(length(unique(result_temp$YearMonth)))  # Sollte 654 sein

# # Extract values for combined climate
# point_climate <- extract(climate_data, points)

# # Plot the points on the raster
# plot(climate_data)
# points(result$x, result$y, col = "red", pch = 16)


# # Normalize the data
# plot_data <- plot_data %>%
#   group_by(Variable) %>%
#   mutate(NormalizedValue = (Value - min(Value)) / (max(Value) - min(Value))) %>%
#   ungroup()
#
#---------------------- dump from XXX -------------------#
