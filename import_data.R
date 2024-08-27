## install packages for data import with excel and ggplot
# install.packages("ggplot2")
# install.packages("readxl")
# install.packages("janitor")

library(ggplot2)
library(readxl)
library(janitor)
library(tidyr)
library(dplyr)

## import data from personal drive: EJPSoil_template_BUFACAP.xlsx 
#!# should be changed in the future to most recent version of template

# data_crop <- readxl::read_excel("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Database/EJPSoil_BUFACAP_template.xlsx", sheet = "data-crop")
# data_soil <- readxl::read_excel("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Database/EJPSoil_BUFACAP_template.xlsx", sheet = "data-soil")
# data_soiltype <- readxl::read_excel("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Database/EJPSoil_BUFACAP_template.xlsx", sheet = "soil-type")

## use condensed dataset from template to run test model
data_test <- readxl::read_excel("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Database/Testdata_from_template.xlsx")

#------------------------------------------------------------------------------#
# what do I want? I need input data for RothC (this should be the output of this script):
# 
# >> climate data <<
# Temp=data.frame(Month=1:12, 
# Temp=c(-0.4, 0.3, 4.2, 8.3, 13.0, 15.9, 18.0, 17.5, 13.4, 8.7, 3.9,  0.6))
# Precip=data.frame(Month=1:12, Precip=c(49, 39, 44, 41, 61, 58, 71, 58, 51, 48, 50, 58))
# Evp=data.frame(Month=1:12, Evp=c(12, 18, 35, 58, 82, 90, 97, 84, 54, 31, 14, 10))
# 
# >> soil data <<
# soil.thick=25  #Soil thickness (organic layer topsoil), in cm
# SOC=69.7       #Soil organic carbon in Mg/ha 
# clay=48        #Percent clay
# Cinputs=2.7   #Annual C inputs to soil in Mg/ha/yr
#------------------------------------------------------------------------------#

## edit data to show important information
df <- data.frame(id=(data$...4), x = (data$...6), y = (data$...9))
df1 <- df[-c(1, 3:24),]
janitor::row_to_names(df1, row_number = 1) -> df1

## make everything numeric except ID
df1 <- data.frame(Crop_ID = (df1$`Crop ID`), Harvested_Yield_kg_ha = as.numeric(df1$`Harvested yield`), Residues_t_ha = as.numeric(df1$`Residue above-ground`))

## rename Crop_IDs for better understanding
df1$Crop_ID[df1$Crop_ID == "Farako-ba_all treatments_year1_>> Sorghum/Great millet/Sorghum bicolor"] <- "Sorghum_SSS_SF"
df1$Crop_ID[df1$Crop_ID == "Farako-ba_all treatments_year2_>> Sorghum/Great millet/Sorghum bicolor"] <- "Sorghum_GSC"
df1$Crop_ID[df1$Crop_ID == "Farako-ba_all treatments_year3_>> Sorghum/Great millet/Sorghum bicolor"] <- "Sorghum_GCS_CMS"
df1$Crop_ID[df1$Crop_ID == "Farako-ba_all treatments_year1_> Cotton plant/Gossypium sp."] <- "Cotton_CMS"
df1$Crop_ID[df1$Crop_ID == "Farako-ba_all treatments_year3_> Cotton plant/Gossypium sp."] <- "Cotton_avg"
df1$Crop_ID[df1$Crop_ID == "Farako-ba_all treatments_year1_>> Groundnut/Peanut/Arachis hypogaea"] <- "Groundnut"
df1$Crop_ID[df1$Crop_ID == "Farako-ba_all treatments_year2_> Maize/Corn/Zea mays"] <- "Maize"

# row.names(df1)[row.names(df1) == "Farako-ba_all treatments_year3_> Cotton plant/Gossypium sp."] <- "Cotton"
# row.names(df1)[1] <- "Sorghum_in_SSS"
# 
# df1 <- as_tibble(df1)
# df1 <- df1 %>% 
#   select(Crop_ID) %>% 
#   rename("Sorghum" = "Farako-ba_all treatments_year1_>> Sorghum/Great millet/Sorghum bicolor")

## edit data2 to show important information
df2 <- data.frame(id=(data2$...3), x = data2$...4, y = data2$...5, z = data2$...6, a = data2$...13, b = data2$...18)
df3 <- df2[-c(1, 3:12, 29:45),]
janitor::row_to_names(df3, row_number = 1) -> df3

## make everything numeric except ID
df3 <- data.frame(Treatment_ID = df3$`Treatment ID`, Sampling_Year = as.numeric(df3$`Sampling year`), Depth_From = as.numeric(df3$`Depth from`), Depth_To = as.numeric(df3$`Depth to`), Bulk_Density = as.numeric(df3$`Bulk density`), SOC_Stock_tC_ha = as.numeric(df3$`SOC stock`))

## plot data2 with ggplot2
ggplot(data = df3, aes(x= Sampling_Year, y=SOC_Stock_tC_ha, fill = Treatment_ID)) +
  geom_point(aes(colour = Treatment_ID))

## plot data with ggplot2
ggplot(data = df1, aes(x=Residues_t_ha, y=Harvested_Yield_kg_ha, fill = Crop_ID)) +
  geom_boxplot(aes(colour = Crop_ID))
