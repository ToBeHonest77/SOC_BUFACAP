##Run the RothC vs 26.3 model for multiple sites and biopumps (i.e. plant species) with near present climate conditions

#SOURCES 
#https://www.bgc-jena.mpg.de/TEE/basics/2015/11/19/RothC/
#https://mpibgc-tee.github.io/SoilR-exp/RothCModel.html
#https://www.rdocumentation.org/packages/SoilR/versions/1.1-23/topics/fW.RothC

library(SoilR)

#RothC v26.3 POOLS (Coleman & Jenkinson)
# DPM Decomposable Plant Material
# RPM Resistant Plant Material
# BIO Microbial Biomass
# HUM Humified Organic Matter
# IOM Inert Organic Matter

#USER CHOICES
slope30 = TRUE 		#excludes areas with slope > slope.lim% (steep land according with FAO Problem Lands)
slope.lim = 15
optimvals = TRUE	#use optimal biopump ranges for temp, prec and pH (alternative: min and max tolerated values)
res.removal = TRUE	#remove part of plant residues for the bioeconomy, based on the SOC content (Iqbal et al. 2016)
res.removal.rate = 0	# 0 <= res.removal.rate <= 1

# Include full Myroute to the target source file containing target area table (colums: e.g. Region, GEZ, precipitation, temperature, etc.) and biopump tables (columns: speices, life form, life span, GEZ code, etc.)
Myroute<-"C:\\route\\"
Mycsv1<-"targetarea.csv"
Mycsv2<-"biopump.csv"	# data in this file contains pre-selected plant species (here referred to biopumps)
# Loading mydata data from a CSV1 and CSV2

Mydata1<-read.table(paste0(Myroute,Mycsv1), na.strings = "NA", nrows = -1, header=T, check.names = TRUE, strip.white = FALSE, blank.lines.skip = TRUE, sep = ",", dec =".")
Mydata2<-read.table(paste0(Myroute,Mycsv2), na.strings = "NA", nrows = -1, header=T, check.names = TRUE, strip.white = FALSE, blank.lines.skip = TRUE, sep = ",", dec =".")
names(Mydata1)
names(Mydata2)

dev.new(width=60, height=35)
par(mfrow=c(3,4))

#SITES LOOP
for (val in 1:nrow(Mydata1))
{site = val

#Climatic data
#temperature is expressed as temp10, but temp.min and temp.max are calculated and expressed directly in degrees Celsius
Temp=data.frame(Month=1:12, Temp=c(Mydata1[site,6]/10, Mydata1[site,9]/10, Mydata1[site,12]/10, Mydata1[site,15]/10, Mydata1[site,18]/10, Mydata1[site,21]/10, Mydata1[site,24]/10, Mydata1[site,27]/10, Mydata1[site,30]/10, Mydata1[site,33]/10, Mydata1[site,36]/10, Mydata1[site,39]/10))
Precip=data.frame(Month=1:12, Precip=c(Mydata1[site,5], Mydata1[site,8], Mydata1[site,11], Mydata1[site,14], Mydata1[site,17], Mydata1[site,20], Mydata1[site,23], Mydata1[site,26], Mydata1[site,29], Mydata1[site,32], Mydata1[site,35], Mydata1[site,38]))
Evp=data.frame(Month=1:12, Evp=c(Mydata1[site,7], Mydata1[site,10], Mydata1[site,13], Mydata1[site,16], Mydata1[site,19], Mydata1[site,22], Mydata1[site,25], Mydata1[site,28], Mydata1[site,31], Mydata1[site,34], Mydata1[site,37], Mydata1[site,40]))
temp.min = Mydata1[site,60]
temp.max = Mydata1[site,61]
sum.prec = Mydata1[site,62]
pH = Mydata1[site,51]
texture = Mydata1[site,42]

#Soil data for Roth-C
soil.thick = 30			#Soil thickness (organic layer topsoil), in cm
SOC = Mydata1[site,50]		#Soil organic carbon in t/ha 
clay = Mydata1[site,47]		#Percent clay

#Soil and terrain data for biopump selection
gez = Mydata1[site,3]
slope = Mydata1[site,63]
elevation = Mydata1[site,64]

#SOC erosion data
#SOC eroded per year (Lugato et al. 2016)
#SOC_eroded = SOC * [erosion/(bulk density*depth)] * ER * CF --> Mg SOC/ha/yr
#Enrichment factor: ER = 1
#C-factor: CF = C = RUSLE cover-management factor 
#Panagos et al. 2015b, EU --> forests: 0.0001–0.003, permanent crops: 0.1–0.3, pastures: 0.05–0.15, scrub: 0.01–0.1, arable: 0.233 (no conservation management: *1.23, conservation management: *0.809, conservation tillage: *0.83, use of crop residues: *0.988, use of cover crops: *0.987)
#Borrelli et al. 2017, World --> forests: 0.0001–0.003, shrubland/grassland/savanna: 0.01-0.15, trees/fruit trees: 0.15, cereals: 0.1, fibre crops: 0.28, shrubs: 0.15, roots/tubers: 0.34
RUSLE = Mydata1[site,66] #soil erosion
bulk.dens = Mydata1[site,49]
depth = 30
ER = 1

cont.hits = 0

#CROPS LOOP
for (val1 in 1:nrow(Mydata2))
{crop = val1

cont = 0

#Biopump (i.e. plant species) data
bp.gez = c(Mydata2[crop,8], Mydata2[crop,9], Mydata2[crop,10], Mydata2[crop,11], Mydata2[crop,12], Mydata2[crop,13], Mydata2[crop,14], Mydata2[crop,15], Mydata2[crop,16], Mydata2[crop,17], Mydata2[crop,18], Mydata2[crop,19], Mydata2[crop,20], Mydata2[crop,21], Mydata2[crop,22], Mydata2[crop,23], Mydata2[crop,24], Mydata2[crop,25], Mydata2[crop,26])
bp.temp.min = Mydata2[crop,27]
bp.temp.max = Mydata2[crop,28]
bp.prec.min = Mydata2[crop,30]
bp.prec.max = Mydata2[crop,31]
bp.pH.min = Mydata2[crop,32]
bp.pH.max = Mydata2[crop,33]
bp.temp.min.abs = ifelse(is.na(Mydata2[crop,39]), bp.temp.min, Mydata2[crop,39])
bp.temp.max.abs = ifelse(is.na(Mydata2[crop,40]), bp.temp.min, Mydata2[crop,40])
bp.prec.min.abs = ifelse(is.na(Mydata2[crop,41]), bp.prec.min, Mydata2[crop,41])
bp.prec.max.abs = ifelse(is.na(Mydata2[crop,42]), bp.prec.min, Mydata2[crop,42])
bp.pH.min.abs = ifelse(is.na(Mydata2[crop,43]), bp.pH.min, Mydata2[crop,43])
bp.pH.max.abs = ifelse(is.na(Mydata2[crop,44]), bp.pH.min, Mydata2[crop,44])
bp.texture = c(Mydata2[crop,34], Mydata2[crop,35], Mydata2[crop,36])
bp.elev.min = ifelse(is.na(Mydata2[crop,45]), elevation, Mydata2[crop,45])
bp.elev.max = ifelse(is.na(Mydata2[crop,46]), elevation, Mydata2[crop,46]) 
bp.form = Mydata2[crop,2] #tree, grass or crop

#SITE/BIOPUMP MATCHING
if (any(na.omit(bp.gez) == gez) & temp.min >= ifelse(optimvals == TRUE, bp.temp.min, bp.temp.min.abs) & temp.max <= ifelse(optimvals == TRUE, bp.temp.max, bp.temp.max.abs) & sum.prec >= ifelse(optimvals == TRUE, bp.prec.min, bp.prec.min.abs) & sum.prec <= ifelse(optimvals == TRUE, bp.prec.max, bp.prec.max.abs) & pH >= ifelse(optimvals == TRUE, bp.pH.min, bp.pH.min.abs) & pH <= ifelse(optimvals == TRUE, bp.pH.max, bp.pH.max.abs) & sum(bp.texture, na.rm=TRUE) > 0 & ifelse(slope30 == TRUE, slope <= slope.lim, TRUE) & elevation >= bp.elev.min & elevation <= bp.elev.max) 
{
  Cres = Mydata2[crop,37] 	#AG+BG Residues annual C inputs to soil in t/ha/yr. Initially includes 100% of residue
  CresAG = Mydata2[crop,48] 	#AG Residues annual C inputs to soil in t/ha/yr. Initially includes 100% of residue
  CresBG = Mydata2[crop,49] 	#BG Residues annual C inputs to soil in t/ha/yr. Initially includes 100% of residue
  res.removal.rate = ifelse(res.removal == TRUE, 10*(SOC/(depth/100 * bulk.dens))/100, res.removal.rate)
  Cres = ifelse(res.removal == FALSE, Cres, CresAG * (1-res.removal.rate) + CresBG)	#Adjusted residue input, assuming a proportion is exported for the bioeconomy
  Cfert = Mydata2[crop,38]	#Organic fertiliser annual C inputs to soil in t/ha/yr
  CF = ifelse(bp.form == "tree", 0.15, ifelse(bp.form == "grass", mean(c(0.01, 0.15)), mean(c(0.1, 0.3))))
  #print(paste("YES --> R", site, "C", crop, "Cinputs =", Cres + Cfert))
  #cont = 1
} else {
  #print(paste("NO --> R", site, "C", crop))
  next
}

#if (cont == 1) {
#Lenght of RothC simulation
years=seq(1/12,80,by=1/12)

#Temperature effects per month
fT=fT.RothC(Temp[,2]) 
#Moisture effects per month
#Bare soils --> bare=TRUE; FALSE
#Evaporation coefficient --> pE = 0.75 (open pan evaporation); 1.0 (Potential evapotranspiration) --> we use AET
fW=fW.RothC(P=(Precip[,2]), E=(Evp[,2]), S.Thick = soil.thick, pClay = clay, pE = 1.0, bare = FALSE)$b 
xi.frame=data.frame(years,rep(fT*fW,length.out=length(years)))

#IOM using Falloon method (Falloon et al. 1998)
FallIOM=0.049*SOC^(1.139) 

#Pedotransfer functions, based on  a bulk density of 1.45 g/cm3 (Weihermueller et al. 2013)
RPMptf = (0.184*SOC + 0.1555)*(clay + 1.275)^(-0.1158)
HUMptf = (0.7148*SOC + 0.5069)*(clay + 0.3421)^(0.0184)
BIOptf = (0.014*SOC + 0.0075)*(clay + 8.8473)^(0.0567)
DPMptf = SOC-FallIOM-RPMptf-HUMptf-BIOptf
DPMptf = ifelse(DPMptf>0, DPMptf,0)
sim.SOC = sum(c(DPMptf, RPMptf, BIOptf, HUMptf, FallIOM))
#to correct cases where sum(c(DPMptf, RPMptf, BIOptf, HUMptf, FallIOM) > SOC
RPMptf = RPMptf * SOC/sim.SOC
HUMptf = HUMptf * SOC/sim.SOC
BIOptf = BIOptf * SOC/sim.SOC

#Loads the model
#DPM/RPM --> DR = arable: 1.44, grasslands: 0.67, forest: 0.25 (Gottschalk et al. 2012)
# FYM allocation: DPM: 49%, RPM: 49%, HUM: 2% (Weihermueller et al. 2013)

bpDR = ifelse(bp.form == "tree", 0.25, ifelse(bp.form == "grass", 0.67, 1.44))

#decomposition rates per pool --> ks = c(k.DPM = 10, k.RPM = 0.3, k.BIO = 0.66, k.HUM = 0.02, k.IOM = 0) (Weihermueller et al. 2013)
#pools initialised at 0
Model1=RothCModel(t=years,C0=c(DPM=0, RPM=0, BIO=0, HUM=0, IOM=FallIOM), In=Cres+Cfert, DR=bpDR, clay=clay, xi=xi.frame) 
Ct1=getC(Model1) #Calculates stocks for each pool per month
#pools initialised at <> 0
Model3=RothCModel(t=years,C0=c(DPMptf, RPMptf, BIOptf, HUMptf, FallIOM), In=Cres+Cfert, DR=bpDR, clay=clay, xi=xi.frame)
Ct3=getC(Model3)

#CHOSE MODEL
Mymodel=Ct3

#Plots results with final pool sizes
poolSize1=as.numeric(tail(Mymodel,1))
#names(poolSize1)<-c("DPM", "RPM", "BIO", "HUM", "IOM")
matplot(years, Mymodel, type="l", lty=1, col=1:5, xlab="Time (years)", ylab="C stocks (Mg/ha)", main=paste(Mydata1[site,2], " + ", Mydata1[site,4], " --> ", "\n", Mydata2[crop,1]))
legend("topleft", c(
  paste("DPM: ", format(DPMptf, digits=2), " --> ", format(poolSize1 [1], digits=2)), 
  paste("RPM: ", format(RPMptf, digits=2), " --> ", format(poolSize1 [2], digits=2)), 
  paste("BIO: ", format(BIOptf, digits=2), " --> ", format(poolSize1 [3], digits=2)), 
  paste("HUM: ", format(HUMptf, digits=2), " --> ", format(poolSize1 [4], digits=2)), 
  paste("IOM: ", format(FallIOM, digits=2), " --> ", format(poolSize1 [5], digits=2))), lty=1, col=1:5, bty="n")

#SOC loss via RUSLE --> calculate per year!
#SOC_eroded = SOC * [erosion/(bulk density*depth)] * ER * CF --> Mg SOC/ha/yr
SOC.eroded.years = 0
for (months1 in 1:nrow(Mymodel))
{year = months1
if (year/12 == round(year/12)) {
  SOC.eroded.years = SOC.eroded.years + (sum(Mymodel[year,]) * (RUSLE/(bulk.dens*depth)) * ER * CF)
  
}}
#Calculated using the final SOC only
SOC.eroded = sum(poolSize1) * (RUSLE/(bulk.dens*depth)) * ER * CF
SOC.eroded.years1 = SOC.eroded * max(years)

#Append results to results.csv
Myres <- data.frame(Mydata1[site,2], Mydata1[site,4], temp.min, temp.max, sum.prec, pH, Mydata2[crop,1], Mydata2[crop,47], DPMptf, poolSize1 [1], RPMptf, poolSize1 [2], BIOptf, poolSize1 [3], HUMptf, poolSize1 [4], FallIOM, poolSize1 [5], sum(poolSize1), SOC.eroded.years, sum(poolSize1)-SOC.eroded.years, Mydata1[site,67]) #SOC.eroded.years1
#LABELS: Region	GEZ, temp.min, temp.max, sum.prec, pH, Species, common.name, DPM.init, DMP.fin, RPM.ini, RPM.fin, BIO.ini, BIO.fin, HUM.ini, HUM.fin, IOM.ini, IOM.fin, SOC.fin, SOC.eroded, SOC.remaining, ha
print(Myres)
write.table(Myres, paste0(Myroute,"results.csv"), sep = ",", append = TRUE, quote = FALSE, col.names = FALSE, row.names = FALSE)

cont.hits = cont.hits + 1

#} #if (cont == 1)

if (cont.hits/12 == round(cont.hits/12)) {
  dev.new(width=60, height=35)
  par(mfrow=c(3,4))
}

#break #limits results to the first hit of Region x GEZ

} #CROPS LOOP

} #SITES LOOP

