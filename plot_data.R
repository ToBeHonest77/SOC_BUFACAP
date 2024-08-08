### plot trial data from template ###

# Load missing packages
install.packages("viridis")

# Load required libraries
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)
library(viridis)

# Read the CSV file
data <- read.csv("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Data/BUFACAP/Years_SOC-stock.csv", sep = ";")
data1 <- na.omit(data)

# Clean column names
# colnames(data1) <- c("Experiment", "Treatment", "Year", "SOC_stock", "Practice")
data1 <- data1 %>%
  rename(Experiment = `Experiment.ID`,
         Treatment = `Treatment.ID`,
         Year = `Sampling.year`,
         SOC_stock = `SOC.stock`) 

# Convert comma to point in SOC_stock and change to numeric
data1$SOC_stock <- as.numeric(gsub(",", ".", data1$SOC_stock))

# Calculate relative years for each experiment
data2 <- data1 %>%
  group_by(Experiment) %>%
  mutate(RelativeYear = Year - min(Year))

# Create the plot BAU vs SALM
p <- ggplot(data2, aes(x = factor(RelativeYear), y = SOC_stock, fill = Practice)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.8), 
              size = 2, alpha = 0.7, aes(color = Practice)) +
  facet_wrap(~ Experiment, scales = "free", ncol = 1) +
  labs(title = "SOC Stock Over Relative Years: BAU vs SALM",
       x = "Relative Years",
       y = "SOC Stock",
       fill = "Practice",
       color = "Practice") +
  theme_minimal() +
  theme(legend.position = "right",
        strip.background = element_rect(fill = "lightgrey"),
        strip.text = element_text(face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_discrete(labels = function(x) as.numeric(x)) +
  scale_fill_manual(values = c("BAU" = "#FFA07A", "SALM" = "#98FB98")) +
  scale_color_manual(values = c("BAU" = "#FF6347", "SALM" = "#32CD32"))

# Print the plot
print(p)

# Print summary of the data
print(summary(data))

# Print unique values in the Experiment column
print(unique(data$Experiment))

# 
# # Create the plot with geom_line
# ggplot(data2, aes(x = RelativeYear, y = SOC_stock, color = Treatment, shape = Experiment)) +
#   geom_point(size = 3) +
#   geom_line() +
#   facet_wrap(~ Experiment, scales = "free_y", ncol = 1) +
#   labs(title = "SOC Stock Over Relative Years",
#        x = "Relative Years",
#        y = "SOC Stock",
#        color = "Treatment",
#        shape = "Experiment") +
#   theme_minimal() +
#   theme(legend.position = "right",
#         strip.background = element_rect(fill = "lightgrey"),
#         strip.text = element_text(face = "bold"))
# 
# # Create the plot with geom_boxplot
# ggplot(data2, aes(x = factor(RelativeYear), y = SOC_stock, color = Treatment)) +
#   geom_boxplot(outlier.shape = NA) +
#   geom_jitter(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.8), size = 2, alpha = 0.7) +
#   facet_wrap(~ Experiment, scales = "free_y", ncol = 1) +
#   labs(title = "SOC Stock Over Relative Years",
#        x = "Relative Years",
#        y = "SOC Stock",
#        color = "Treatment") +
#   theme_minimal() +
#   theme(legend.position = "right",
#         strip.background = element_rect(fill = "lightgrey"),
#         strip.text = element_text(face = "bold"),
#         axis.text.x = element_text(angle = 45, hjust = 1)) +
#   scale_x_discrete(labels = function(x) as.numeric(x))
# 
# # Create the plot
# ggplot(data2, aes(x = factor(RelativeYear), y = SOC_stock, fill = SOC_stock)) +
#   geom_boxplot(outlier.shape = NA) +
#   geom_jitter(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.8), 
#               size = 2, alpha = 0.7, aes(color = SOC_stock)) +
#   facet_wrap(~ Experiment, scales = "free", ncol = 1) +
#   labs(title = "SOC Stock Over Relative Years",
#        x = "Relative Years",
#        y = "SOC Stock",
#        fill = "SOC Stock",
#        color = "SOC Stock") +
#   theme_minimal() +
#   theme(legend.position = "right",
#         strip.background = element_rect(fill = "lightgrey"),
#         strip.text = element_text(face = "bold"),
#         axis.text.x = element_text(angle = 45, hjust = 1)) +
#   scale_x_discrete(labels = function(x) as.numeric(x)) +
#   scale_fill_viridis(option = "plasma", direction = -1) +
#   scale_color_viridis(option = "plasma", direction = -1)