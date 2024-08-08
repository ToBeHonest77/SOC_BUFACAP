plot <- read.csv2("C:/Users/t.ruhnau/Downloads/plot.csv")
plot1 <- as.numeric(plot$value_avg)

### from chatgpt 8.8.24 for Johannes
# Load necessary library
library(ggplot2)

# Create a fictional dataset
set.seed(123)  # For reproducibility
set.seed(1234)  # For reproducibility
data <- data.frame(
  Category = rep(c("Energy Efficiency", "Nature Restoration (excl. Blue Carbon)", 
                   "Non-CO2 Gas", "REDD+", "Renewable Energy"), each = 50),
  Price = c(runif(50, min = 5, max = 8),  # Fictional data for Energy Efficiency
            runif(50, min = 4, max = 35), # Fictional data for Nature Restoration
            runif(50, min = 3, max = 8), # Fictional data for Non-CO2 Gas
            runif(50, min = 3, max = 6),  # Fictional data for REDD+
            runif(50, min = 2, max = 4))  # Fictional data for Renewable Energy
)

# Create a boxplot with minimal design
ggplot(data, aes(x = Category, y = Price)) +
  geom_boxplot(outlier.colour = "red", outlier.size = 2) +
  coord_cartesian(ylim = c(0, 35)) +  # Set y-axis limits
  theme_minimal() +  # Use a minimal theme
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1), # Rotate x-axis labels
    axis.title.x = element_blank(),  # Remove x-axis title
    axis.title.y = element_blank(),  # Remove y-axis title
    plot.margin = margin(20, 20, 20, 20)  # Add some margin around the plot
  ) +
  ggtitle("Carbon Credit Prices Q1 2024 (USD/tCO2e)")

# Create a custom boxplot with minimal design, displaying only quantile lines and mean point
ggplot(data, aes(x = Category, y = Price)) +
  stat_summary(fun.min = function(x) quantile(x, 0.25),
               fun.max = function(x) quantile(x, 0.75),
               fun = median,
               geom = "errorbar", 
               width = 0.25, 
               colour = "black") +  # Show only the quantile lines
  stat_summary(fun = mean, 
               geom = "point", 
               shape = 4, 
               size = 3, 
               colour = "red") +  # Show mean as a cross point
  coord_cartesian(ylim = c(0, 35)) +  # Set y-axis limits
  theme_minimal() +  # Use a minimal theme
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1), # Rotate x-axis labels
    axis.title.x = element_blank(),  # Remove x-axis title
    axis.title.y = element_blank(),  # Remove y-axis title
    plot.margin = margin(20, 20, 20, 20)  # Add some margin around the plot
  ) +
  ggtitle("Carbon Credit Prices Q1 2024 (USD/tCO2e)")


# Create a custom boxplot with minimal design, displaying quantile lines, median, and mean
ggplot(data, aes(x = Category, y = Price)) +
  stat_summary(fun.min = function(x) quantile(x, 0.25),
               fun.max = function(x) quantile(x, 0.75),
               geom = "errorbar", 
               width = 0.25, 
               colour = "black") +  # Show 25th and 75th percentile lines
  stat_summary(fun = median, 
               geom = "point", 
               shape = 95, 
               size = 6, 
               colour = "blue") +  # Show median as a horizontal line
  stat_summary(fun = mean, 
               geom = "point", 
               shape = 4, 
               size = 3, 
               colour = "red") +  # Show mean as a cross point
  coord_cartesian(ylim = c(0, 35)) +  # Set y-axis limits
  theme_minimal() +  # Use a minimal theme
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1), # Rotate x-axis labels
    axis.title.x = element_blank(),  # Remove x-axis title
    axis.title.y = element_blank(),  # Remove y-axis title
    plot.margin = margin(20, 20, 20, 20)  # Add some margin around the plot
  ) +
  ggtitle("Carbon Credit Prices Q1 2024 (USD/tCO2e)")


# Create a custom boxplot with better scaling
ggplot(data, aes(x = Category, y = Price)) +
  stat_summary(fun.min = function(x) quantile(x, 0.25),
               fun.max = function(x) quantile(x, 0.75),
               geom = "errorbar", 
               width = 0.4, 
               colour = "black", 
               size = 1) +  # Thicker lines for quantiles
  stat_summary(fun = median, 
               geom = "point", 
               shape = 95, 
               size = 8, 
               colour = "blue") +  # Larger, thicker line for median
  stat_summary(fun = mean, 
               geom = "point", 
               shape = 4, 
               size = 4, 
               colour = "red") +  # Slightly larger cross for mean
  coord_cartesian(ylim = c(0, 35)) +  # Set y-axis limits
  theme_minimal(base_size = 14) +  # Increase base font size for better readability
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1, size = 12), # Rotate and scale x-axis labels
    axis.title.x = element_blank(),  # Remove x-axis title
    axis.title.y = element_blank(),  # Remove y-axis title
    plot.margin = margin(20, 20, 20, 20),  # Add some margin around the plot
    plot.title = element_text(size = 16, hjust = 0.5)  # Center the title and scale up
  ) +
  ggtitle("Carbon Credit Prices Q1 2024 (USD/tCO2e)")
