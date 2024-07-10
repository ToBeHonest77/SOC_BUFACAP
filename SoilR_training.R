## install important packages for SOC modeling

install.packages("SoilR")
install.packages("deSolve")
install.packages ("ggplot")

# activate packages
library(SoilR)
library(deSolve)
library(ggplot2)

#-------------------------------------------------------------------------------
# ## test SoilR with code from literature (https://gmd.copernicus.org/articles/5/1045/2012/gmd-5-1045-2012.pdf)
# library(SoilR)
# Bare=ICBMModel(t=times, ks=c(k1=0.8, # k1 and k2 are decomposition rates
#                              k2=0.00605), h=0.13, r=1.32, 
#                c0=c(C10=0.3,C20=3.96), In=0) #c10 and c20 are initial conditions, In = mean annual carbon input
# 
# CtBare=getC(Bare) #store the ouput of ICBMModel
# 
# plot(times, rowSums(CtBare),type="l",
#      ylim=c(0,5), ylab="Topsoil carbon
# times=seq(0,20,by=0.1)
# mass (kg m-2)",xlab="Time (years)",
#      lwd=2)
# lines(times, CtBare[,1],lty=2)
# lines(times,CtBare[,2],lty=3,col=2,lwd=2)
# legend("topright",c("Total carbon",
#                     "Carbon in pool 1", "Carbon in pool 2"),
#        lty=c(1,2,3),col=c(1,1,2),lwd=c(2,1,2),
#        bty="n")
#-------------------------------------------------------------------------------

### test data from:https://www.bgc-jena.mpg.de/TEE/basics/2015/11/19/RothC/
## climate data for a agricultural site in southern Bavaria, Germany
Temp=data.frame(Month=1:12, Temp=c(-0.4, 0.3, 4.2, 8.3, 13.0, 15.9,
                                   18.0, 17.5, 13.4, 8.7, 3.9,  0.6))
Precip=data.frame(Month=1:12, Precip=c(49, 39, 44, 41, 61, 58, 71, 58, 51,
                                       48, 50, 58))
Evp=data.frame(Month=1:12, Evp=c(12, 18, 35, 58, 82, 90, 97, 84, 54, 31,
                                 14, 10))

## soil data
soil.thick=25  #Soil thickness (organic layer topsoil), in cm
SOC=69.7       #Soil organic carbon in Mg/ha 
clay=48        #Percent clay
Cinputs=2.7   #Annual C inputs to soil in Mg/ha/yr

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




