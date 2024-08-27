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

#-------------------------------------------------------------------------------
## spin-up run to initialize carbon pools with fictional values from the past
## Spinup output = 68.7 SOC Mg/ha
#-------------------------------------------------------------------------------
# Adjusted climate data reflecting cooler and less intense conditions
Temp_adjusted <- data.frame(Month = 1:12, Temp = c(-2.0, -1.5, 2.0, 6.0, 11.0, 13.5,
                                                   15.5, 15.0, 11.0, 6.5, 1.5, -1.0))
Precip_adjusted <- data.frame(Month = 1:12, Precip = c(40, 35, 38, 35, 55, 52, 65,
                                                   52, 45, 42, 44, 52))
Evp_adjusted <- data.frame(Month = 1:12, Evp = c(10, 15, 30, 50, 75, 80, 85, 75,
                                                  50, 30, 12, 8))

# Adjusted soil data
soil.thick <- 25  # Keeping the same soil thickness in cm
SOC_initial <- 55 # Reduced initial SOC in Mg/ha to reflect minimal human intervention
clay <- 48        # Percent clay remains the same
Cinputs_Spinup <- 2.2 # Lower annual C inputs in Mg/ha/yr 

# Calculate the effects of climate on decomposition with adjusted data
fT_adjusted <- fT.RothC(Temp_adjusted[,2])
fW_adjusted <- fW.RothC(P = Precip_adjusted[,2], E = Evp_adjusted[,2], 
                        S.Thick = soil.thick, pClay = clay, pE = 1.0, bare = FALSE)$b

# Extend the climate data for 500 years (spin-up period)
years_spinup <- seq(1/12, 10000, by = 1/12)
xi.frame_spinup_adjusted <- data.frame(years = years_spinup, xi = rep(fT_adjusted * fW_adjusted, length.out = length(years_spinup)))

# Initial Inert Organic Matter (IOM) using Falloon method with adjusted SOC
FallIOM_adjusted <- 0.049 * SOC_initial^(1.139)

# Run the RothC model for the spin-up period with adjusted data
Model_Spinup_Adjusted <- RothCModel(t = years_spinup, C0 = c(DPM = 0, RPM = 0, BIO = 0, HUM = 0, IOM = FallIOM_adjusted),
                                    In = Cinputs_Spinup, clay = clay, xi = xi.frame_spinup_adjusted)
Ct_Spinup_Adjusted <- getC(Model_Spinup_Adjusted)

# Extract the final pool sizes after the spin-up
initial_pools_adjusted <- as.numeric(tail(Ct_Spinup_Adjusted, 1))
names(initial_pools_adjusted) <- c("DPM", "RPM", "BIO", "HUM", "IOM")

# Display the initial pool sizes after spin-up
initial_pools_adjusted

# Sum total SOC for the spin-up period
total_C_Spinup_Adjusted <- rowSums(Ct_Spinup_Adjusted)

# Determine the y-axis limits for the plot
max_C_spinup <- max(total_C_Spinup_Adjusted)

# Calculate the average total SOC stock over the spin-up period
average_total_SOC_spinup <- mean(total_C_Spinup_Adjusted)

# Display the result
average_total_SOC_spinup

# Plot individual pools and total SOC for the spin-up period
matplot(years_spinup, Ct_Spinup_Adjusted, type = "l", lty = 1, col = 1:5,
        xlab = "Time (years)", ylab = "C stocks (Mg/ha)",
        main = "SOC Pools and Total (Spin-Up)", ylim = c(0, max_C_spinup * 1.1))
lines(years_spinup, total_C_Spinup_Adjusted, col = "black", lty = 2)
legend("topright", c("DPM", "RPM", "BIO", "HUM", "IOM", "Total SOC"),
       lty = c(1, 1, 1, 1, 1, 1), col = c(1:5, "black"), bty = "n")
#-------------------------------------------------------------------------------

## start prediction into the future

#-------------------------------------------------------------------------------
## climate data for a agricultural site in southern Bavaria, Germany
Temp=data.frame(Month=1:12, Temp=c(-0.4, 0.3, 4.2, 8.3, 13.0, 15.9,
                                   18.0, 17.5, 13.4, 8.7, 3.9,  0.6))
Precip=data.frame(Month=1:12, Precip=c(49, 39, 44, 41, 61, 58, 71, 58, 51,
                                   48, 50, 58))
Evp=data.frame(Month=1:12, Evp=c(12, 18, 35, 58, 82, 90, 97, 84, 54, 31,
                                    14, 10))

## soil data
soil.thick=25  #Soil thickness (organic layer topsoil), in cm
SOC=68.7       #Soil organic carbon in Mg/ha 
clay=48        #Percent clay
Cinputs_BAU=2.7   #Annual C inputs to soil in Mg/ha/yr
Cinputs_IALM=3.5   # Assumed higher C inputs for Project scenario IALM = improved agriculture land management

## create vector of time steps to run simulation
years=seq(from=0, to=20, by=1/12) ## changed years from/to > output doesnt change

## calculate effects of climate on decomposition
fT=fT.RothC(Temp[,2]) #Temperature effects per month
fW=fW.RothC(P=(Precip[,2]), E=(Evp[,2]), 
            S.Thick = soil.thick, pClay = clay, 
            pE = 1.0, bare = FALSE)$b #Moisture effects per month
xi.frame=data.frame(years,rep(fT*fW,length.out=length(years)))

# Falloon is the standard method, other options are Zimmermann et al. (2017) fractionation or pedotransfer functions
FallIOM=0.049*SOC^(1.139) #IOM using Falloon method

## run the model for BAU scenario
Model_BAU=RothCModel(t=years,C0=initial_pools_adjusted,
                  In=Cinputs_BAU, clay=clay, xi=xi.frame) #Loads the model
Ct_BAU=getC(Model_BAU) #Calculates stocks for each pool per month

## run the model for IALM scenario
Model_IALM=RothCModel(t=years,C0=initial_pools_adjusted,
                  In=Cinputs_IALM, clay=clay, xi=xi.frame) #Loads the model
Ct_IALM=getC(Model_IALM) #Calculates stocks for each pool per month

# # Plot BAU scenario
# matplot(years, Ct_BAU, type = "l", lty = 1, col = 1:5, xlab = "Time (years)", ylab = "C stocks (Mg/ha)")
# legend("topleft", c("DPM", "RPM", "BIO", "HUM", "IOM"), lty = 1, col = 1:5, bty = "n")
# 
# # Plot IALM scenario
# matplot(years, Ct_IALM, type = "l", lty = 1, col = 1:5, xlab = "Time (years)", ylab = "C stocks (Mg/ha)")
# legend("topleft", c("DPM", "RPM", "BIO", "HUM", "IOM"), lty = 1, col = 1:5, bty = "n")
# 
# # Final pool sizes for BAU
# poolSize_BAU <- as.numeric(tail(Ct_BAU, 1))
# names(poolSize_BAU) <- c("DPM", "RPM", "BIO", "HUM", "IOM")
# poolSize_BAU
# 
# # Final pool sizes for IALM
# poolSize_IALM <- as.numeric(tail(Ct_IALM, 1))
# names(poolSize_IALM) <- c("DPM", "RPM", "BIO", "HUM", "IOM")
# poolSize_IALM

# Sum the carbon stocks for each scenario
total_C_BAU <- rowSums(Ct_BAU)
total_C_IALM <- rowSums(Ct_IALM)

# Calculate the difference in total SOC at the end of the time period
difference_total_C <- tail(total_C_IALM, 1) - tail(total_C_BAU, 1)

# Display the result
difference_total_C

# # Determine the y-axis limits for the plot
# max_C_BAU <- max(total_C_BAU)
# max_C_IALM <- max(total_C_IALM)

# Determine the maximum y-axis limit to fit both lines comfortably
max_C_plot <- max(total_C_IALM, total_C_BAU)

# Plot the total SOC for IALM and BAU scenarios (order changed to IALM first for better line visibility)
plot(years, total_C_IALM, type = "l", col = "red", lty = 2, 
     xlab = "Time (years)", ylab = "Total C stocks (Mg/ha)",
     main = "SOC Stocks Comparison: BAU vs IALM", ylim = c(0, max_C_plot * 1.1))

# Add the BAU line to the plot
lines(years, total_C_BAU, col = "blue", lty = 1)

# Add a legend
legend("topright", legend = c("IALM", "BAU"), col = c("red", "blue"), lty = c(2, 1), bty = "n")

# Display the difference in total SOC at the end on the plot
text(x = max(years) * 0.7, y = 40,
     labels = paste("Delta after 20 years:", round(difference_total_C, 2), "Mg/ha"), pos = 4, col = "black")
# 
# # Plot individual pools and total SOC for the BAU scenario
# matplot(years, Ct_BAU, type = "l", lty = 1, col = 1:5,
#         xlab = "Time (years)", ylab = "C stocks (Mg/ha)",
#         main = "SOC Pools and Total (BAU Scenario)", ylim = c(0, max_C_BAU * 1.1))
# lines(years, total_C_BAU, col = "black", lty = 2)
# legend("topright", c("DPM", "RPM", "BIO", "HUM", "IOM", "Total SOC"),
#        lty = c(1, 1, 1, 1, 1, 2), col = c(1:5, "black"), bty = "n")
# 
# # Plot individual pools and total SOC for the Project scenario
# matplot(years, Ct_IALM, type = "l", lty = 1, col = 1:5,
#         xlab = "Time (years)", ylab = "C stocks (Mg/ha)",
#         main = "SOC Pools and Total (Project Scenario)", ylim = c(0, max_C_IALM * 1.1))
# lines(years, total_C_IALM, col = "black", lty = 2)
# legend("topright", c("DPM", "RPM", "BIO", "HUM", "IOM", "Total SOC"),
#        lty = c(1, 1, 1, 1, 1, 2), col = c(1:5, "black"), bty = "n")
# 
# 
# # Plot the total SOC for BAU and IALM scenarios
# plot(years, total_C_BAU, type = "l", col = "blue", lty = 1, xlab = "Time (years)", ylab = "Total C stocks (Mg/ha)",
#      main = "SOC Stocks Comparison: BAU vs IALM", ylim = c(0, max_C_IALM * 1.1))
# lines(years, total_C_IALM, col = "red", lty = 2)
# legend("topright", legend = c("BAU", "IALM"), col = c("blue", "red"), lty = c(1, 2), bty = "n")
#-------------------------------------------------------------------------------
