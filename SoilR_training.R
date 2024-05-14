## install important packages for SOC modeling

install.packages("SoilR")
install.packages("deSolve")

## test SoilR with code from literature (https://gmd.copernicus.org/articles/5/1045/2012/gmd-5-1045-2012.pdf)
library(SoilR)
times=seq(0,20,by=0.1)
Bare=ICBMModel(t=times, ks=c(k1=0.8, # k1 and k2 are decomposition rates
                             k2=0.00605), h=0.13, r=1.32, 
               c0=c(C10=0.3,C20=3.96), In=0) #c10 and c20 are initial conditions, In = mean annual carbon input

CtBare=getC(Bare) #store the ouput of ICBMModel

plot(times, rowSums(CtBare),type="l",
     ylim=c(0,5), ylab="Topsoil carbon
mass (kg m-2)",xlab="Time (years)",
     lwd=2)
lines(times, CtBare[,1],lty=2)
lines(times,CtBare[,2],lty=3,col=2,lwd=2)
legend("topright",c("Total carbon",
                    "Carbon in pool 1", "Carbon in pool 2"),
       lty=c(1,2,3),col=c(1,1,2),lwd=c(2,1,2),
       bty="n")













