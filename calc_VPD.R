install.packages("Evapotranspiration")


#1.Script name:  agMERRA_pointFiles_conversionBGC-MAN
#2.Purpose of the script: Read in AgMERRA climate point data with these variables 
#(year; month; day; srad_MJ_day; tmax; tmin; prcp_mm; relhum_frac) 
#to the climate input data with the format (year;DOY; tmax; tmin;tday;precip_cm; VPD_Pa; srad_W;dayl_sec
#3.Johannes Pirker
#4.Date Created: Q4/2018
#5. Copyright statement / Usage Restrictions: CC-BY
#6.Contact Information: pirker@iiasa.ac.at; johannes.pirker@unique-landuse.de 


setwd("H:/GIS/temp/agMERRA")
#setwd("C:/Users/pirker/Downloads")

#install.packages("ggplot2")
#install.packages("data.table")
#install.packages("lubridate")
#install.packages("geosphere")
#install.packages("plantecophys")
#install.packages("bigleaf")

library(reshape)
library(data.table)
library(lubridate)#to calc/convert dates
library(geosphere)#to calc daylength
library(plantecophys)#to calc VPD from relative humidity
library(bigleaf)#to calc air pressure
library(erer)#to write out  list to dataframe 
library(progress)#to monitor the progress of an operation
##############################
#2. wrangle data
##############################

#concentate list
for (i in 1:length(list.filenames))
{
  list.IDN_agMERRA1[[i]]$date = str_c(list.IDN_agMERRA1[[i]]$year, list.IDN_agMERRA1[[i]]$month, list.IDN_agMERRA1[[i]]$day, sep="-")
}
tail(list.IDN_agMERRA1[2])

#Year, month, day in date format
for (i in 1:length(list.filenames))
{
  list.IDN_agMERRA1[[i]]$YMD = ymd(list.IDN_agMERRA1[[i]]$date)
}
head(list.IDN_agMERRA1[1])

#DOY - day of the year
for (i in 1:length(list.filenames))
{
  list.IDN_agMERRA1[[i]]$DOY = yday(list.IDN_agMERRA1[[i]]$YMD)
}
head(list.IDN_agMERRA1[1])

#CALCULATE DAYLENGTH (sec/day) for each day
#add filename as column
list.IDN_agMERRA2 <-list()

for (i in 1:length(list.filenames))
{list.IDN_agMERRA2[[i]]<-cbind(list.IDN_agMERRA1[[i]],
                               rep.int(list.filenames[[i]], 11323))
}
head(list.IDN_agMERRA2[[5]])

#change colname
colnames<-c("year","month","day_month","srad_MJ_day","tmax","tmin","prcp_mm","relhum_frac","windveloc_ms","date","YMD","DOY","pointname")

lapply(list.IDN_agMERRA2, setnames, colnames)

head(list.IDN_agMERRA2)

#for (i in 1:length(list.filenames))
#{list.IDN_agMERRA2[[i]]<-colnames(list.IDN_agMERRA2[[i]])[colnames(list.IDN_agMERRA2)=='rep.int(list.filenames[[i]], 11323)']<-'filename'
#}

#merge lst/long file w/ lat/long info in it
for (i in 1:length(list.filenames))
{list.IDN_agMERRA2[[i]]<-merge(list.IDN_agMERRA2[[i]],glob_agMERRA_lat_long,
                               by.x = "pointname", 
                               by.y = "filename")
}
head(list.IDN_agMERRA2[3500])

#calculate Daylength in sec
for (i in 1:length(list.filenames))
{
  list.IDN_agMERRA2[[i]]$dayl_sec = as.integer(daylength(list.IDN_agMERRA2[[i]]$long_, list.IDN_agMERRA2[[i]]$DOY)*3600)
}


head(list.IDN_agMERRA2[5])
#####################################################

# convert precip mm to cm
for (i in 1: length(list.filenames))
{
  list.IDN_agMERRA2[[i]]$precip_cm<- list.IDN_agMERRA2[[i]]$prcp_mm/10
}  
head(list.IDN_agMERRA2[1])

# convert srad MJ/m2/day to W/m2, rounded to 2 digits
for (i in 1: length(list.filenames))
{
  list.IDN_agMERRA2[[i]]$srad_W<- round((list.IDN_agMERRA2[[i]]$srad/(list.IDN_agMERRA2[[i]]$dayl_sec*0.000001)),2)
}
head(list.IDN_agMERRA2[1])

# calculate VPD
#1. calculate mean temp from max/min temp

for (i in 1: length(list.filenames))
{
  list.IDN_agMERRA2[[i]]$tMean<-((list.IDN_agMERRA2[[i]]$tmax + list.IDN_agMERRA2[[i]]$tmin) /2)
  
}  

#2. calculate tday from max/min temp
#tday = TEMPCF * (tmax-tavg)+tavg where TEMPCF=0.212 (see Pietsch & Burgmann)

for (i in 1: length(list.filenames))
{
  list.IDN_agMERRA2[[i]]$tday<-0.212*(list.IDN_agMERRA2[[i]]$tmax - list.IDN_agMERRA2[[i]]$tMean)+list.IDN_agMERRA2[[i]]$tMean
} 

#2.calculate elevation

#performed outside r in GIS (comes with the glob_agMERRA data)


#3.calculate air pressure from elevation
for (i in 1: length(list.filenames))
{
  list.IDN_agMERRA2[[i]]$kPa<-pressure.from.elevation(list.IDN_agMERRA2[[i]]$RASTERVALU,list.IDN_agMERRA2[[i]]$tday, VPD = NULL)
  
}  

#3.convert relhum to VPD
#RHtoVPD(RH, TdegC, Pa = 101) --> gives VPD in kPa --> multiply with 1000 for VPD in Pa as required by BGC

for (i in 1: length(list.filenames))
{
  list.IDN_agMERRA2[[i]]$VPD_Pa<- trunc((RHtoVPD(list.IDN_agMERRA2[[i]]$relhum*100, list.IDN_agMERRA2[[i]]$tday, Pa = list.IDN_agMERRA2[[i]]$kPa)*1000))
}  

# subset for 365 days only & select input for MtClim
selColumns<-c("year","DOY","tmax","tmin","tday","precip_cm","VPD_Pa","srad_W","dayl_sec")

list.IDN_agMERRA3<-lapply(list.IDN_agMERRA2, subset, DOY < 366, select = selColumns)

#view data
lapply(list.IDN_agMERRA3[[1999]], tail)

head(list.IDN_agMERRA3[[2845]])

##############################
#3. export data
##############################
#write .mtcin files
setwd("H:/GIS/temp/agMERRA_toBGC")

for (i in 1:length(list.IDN_agMERRA3)) {
  write.table(list.IDN_agMERRA3[i], file=paste0(list.filenames[i], ""),quote = FALSE, sep ="   ",row.names= FALSE)
}