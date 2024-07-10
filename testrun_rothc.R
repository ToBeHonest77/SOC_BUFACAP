#------------------------------------------------------------------------------#
# script to test rothc with data from literature research (template)
#
# edited by T. Ruhnau (10.07.2024)
#------------------------------------------------------------------------------#

### activate packages
library(SoilR)

## use condensed dataset from template to run test model
data_test <- readxl::read_excel("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Database/Testdata_from_template.xlsx")
evapo <- read.csv2("C:/Users/t.ruhnau/OneDrive - Unique/Dokumente/SOC-Project/Data/Earthmap/Burkina Faso-Potential Evapotranspiration-Monthly time series 2001-2023.csv",sep = ",")
### test data from Farak-ba, Burkina Faso

## climate data is taken from: https://climateknowledgeportal.worldbank.org/country/burkina-faso/climate-data-historical
# Temp=data.frame(Month=1:12, Temp=c(26.72, 26.72, 26.72, 32.82, 32.82, 32.82, 28.57, 28.57, 28.57, 28.85, 28.85, 28.85))
# Precip=data.frame(Month=1:12, Precip=c(2.18, 2.18, 2.18, 100.8, 100.8, 100.8, 526.68, 526.68, 526.68, 201.41, 201.41, 201.41))

## data from earthmap.org for year = 2023
Temp=data.frame(Month=1:12, Temp=c(25.45, 28.47, 31.40, 32.61, 32.72, 30.40, 28.67, 26.79, 27.87, 29.59, 29.65, 25.78))
Precip=data.frame(Month=1:12, Precip=c(0.03, 0.06, 4.39, 9.07, 22.07, 57.06, 89.33, 224.99, 96.36, 26.00, 1.55, 0.03))
#!# monthly sum does lead error because fW has negative values
Evp=data.frame(Month=1:12, Evp=c(257, 287, 286, 229, 273, 247, 237, 196, 223, 179, 245, 227))

## soil data
soil.thick=20  #Soil thickness (organic layer topsoil), in cm
SOC=12.14       #Soil organic carbon in Mg/ha 
clay=7       #Percent clay
Cinputs=3.83 #Annual C inputs to soil in Mg/ha/yr

## create vector of time steps to run simulation
years=seq(1/12,500,by=1/12) 

## calculate effects of climate on decomposition
fT=fT.RothC(Temp[,2]) #Temperature effects per month
fW=fW.RothC(P=(Precip[,2]), E=(Evp[,2]), 
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

## from the examples
matplot(t,Ct,type="l",col=1:5, ylim=c(0,25),
        ylab=expression(paste("Carbon stores (Mg C ", ha^-1,")")),
        xlab="Time (years)", lty=1)
lines(t,rowSums(Ct),lwd=2)
legend("topleft",
       c("Pool 1, DPM",
         "Pool 2, RPM",
         "Pool 3, BIO",
         "Pool 4, HUM",
         "Pool 5, IOM",
         "Total Carbon"),
       lty=1,
       lwd=c(rep(1,5),2),
       col=c(1:5,1),
       bty="n"
)