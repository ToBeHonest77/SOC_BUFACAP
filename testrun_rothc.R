#------------------------------------------------------------------------------#
# script to test rothc with data from literature research (template)
#
# edited by T. Ruhnau (10.07.2024)
#------------------------------------------------------------------------------#

### activate packages
library(SoilR)

## use condensed dataset from template to run test model
data_test <- readxl::read_excel("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Data/BUFACAP/Testdata_from_template2.xlsx")
data_soil <- readxl::read_excel("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Data/BUFACAP/Test_soil_data.xlsx")
### test data from Farak-ba, Burkina Faso

## climate data is taken from: https://climateknowledgeportal.worldbank.org/country/burkina-faso/climate-data-historical
# Temp=data.frame(Month=1:12, Temp=c(26.72, 26.72, 26.72, 32.82, 32.82, 32.82, 28.57, 28.57, 28.57, 28.85, 28.85, 28.85))
# Precip=data.frame(Month=1:12, Precip=c(2.18, 2.18, 2.18, 100.8, 100.8, 100.8, 526.68, 526.68, 526.68, 201.41, 201.41, 201.41))

## data from earthmap.org for year = 2023
### new data for Burkina from wikipedia.de

# Temp=data.frame(Month=1:12, Temp=c(24.9, 27.3, 29.8, 30.6, 29.3, 27.5, 26.2, 25.2, 25.9, 27.4, 27.6, 25.3))
# Precip=data.frame(Month=1:12, Precip=c(1, 2, 17, 48, 108, 130, 208, 308, 206, 74, 10, 1))

#!# monthly sum does lead to error because fW has negative values, data = kg/m²
# Evp=data.frame(Month=1:12, Evp=c(257, 287, 286, 229, 273, 247, 237, 196, 223, 179, 245, 227))
# 
# ## new data from chatgpt.com
# Temp=data.frame(Month=1:12, Temp=c(25, 27, 30, 32, 33, 31, 28, 27, 28, 30, 28, 26))
# Precip=data.frame(Month=1:12, Precip=c(0, 0, 5, 20, 50, 100, 180, 240, 150, 50, 5, 0))
# 
# ## new data from chatgpt.com
# #!# changed first value to fit fW.RothC > 60 does lead to negative values in fW
# Evp=data.frame(Month=1:12, Evp=c(60, 180, 200, 210, 220, 180, 150, 140, 160, 180, 160, 150))

## new data from ERA5 for 1970
Temp=data.frame(Month=1:12, Temp=c(26, 28, 30, 30, 28, 37, 25, 24, 24, 26, 26, 25))
Precip=data.frame(Month=1:12, Precip=c(0, 0, 5, 42, 123, 97, 162, 233, 243, 43, 1, 0))
#!# changed first value to fit fW.RothC > 60 does lead to negative values in fW
Evp=data.frame(Month=1:12, Evp=c(-0.3, -0.3, -0.3, -0.3, -0.26, -0.24, -0.19, -0.15, -0.15, -0.22, -0.26, -0.32))

## soil data
#!# changed values according to average of all experiments in database for 1970-1979
soil.thick=20   #Soil thickness (organic layer topsoil), in cm
SOC=23.6        #Soil organic carbon in Mg/ha 
clay=13.6       #Percent clay
Cinputs=2      #Annual C inputs to soil in Mg/ha/yr ##!## estimated value for historical land use from chatgpt

## create vector of time steps to run simulation
years=seq(1/12,500,by=1/12) 

## calculate effects of climate on decomposition
fT=fT.RothC(Temp[,2]) #Temperature effects per month 
fW=fW.RothC(P=(Precip[,2]), E=(Evp[,2]), #!# note: if value is negative, RothCModel cant work
            S.Thick = soil.thick, pClay = clay, 
            pE = 1.0, bare = FALSE)$b #Moisture effects per month
xi.frame=data.frame(years,rep(fT*fW,length.out=length(years)))

#!# not clear about this method
FallIOM=0.049*SOC^(1.139) #IOM using Falloon method

## run the model
Model1=RothCModel(t=years,C0=c(DPM=0, RPM=0, BIO=0, HUM=0, IOM=FallIOM),
                  In=Cinputs, clay=clay, xi=xi.frame) #Loads the model
Ct1=getC(Model1) #Calculates stocks for each pool per month

## plot results
matplot(years, Ct1, type="l", lty=1, col=1:5,
        xlab="Time (years)", ylab="C stocks (Mg/ha)")
legend("topleft", c("DPM", "RPM", "BIO", "HUM", "IOM"),
       lty=1, col=1:5, bty="n")

## final pool size
poolSize1=as.numeric(tail(Ct1,1))
names(poolSize1)<-c("DPM", "RPM", "BIO", "HUM", "IOM")
poolSize1