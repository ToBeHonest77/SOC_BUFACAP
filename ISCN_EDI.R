# Package ID: edi.1160.1 Cataloging System:https://pasta.edirepository.org.
# Data set title: International Soil Carbon Network version 3 Database (ISCN3).
# Data set creator:  Luke Nave - University of Michigan 
# Data set creator:  Kris Johnson - USDA-Forest Service 
# Data set creator:  Catharine van Ingen - Microsoft Research 
# Data set creator:  Deborah Agarwal - Lawrence Berkeley National Laboratory 
# Data set creator:  Marty Humphrey - University of Virigina 
# Data set creator:  Norman Beekwilder - University of Virigina 
# Contact:  Katherine Todd-Brown -  International Soil Carbon Network  - ktodd-brown@ufl.edu
# Contact:  Luke Nave -  International Soil Carbon Network  - lukenave@umich.edu
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/1160/1/4af719a84f8981fcc63f1f92760cb253" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


dt1 <-read.csv(infile1,header=F 
               ,skip=1
               ,sep=";"  
               ,quot='"' 
               , col.names=c(
                 "ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.",     
                 "dataset_name_sub",     
                 "dataset_name_soc",     
                 "lat..paren.dec..deg.paren.",     
                 "long..paren.dec..deg.paren.",     
                 "datum..paren.datum.paren.",     
                 "state..paren.state_province.paren.",     
                 "country..paren.country.paren.",     
                 "site_name",     
                 "observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.",     
                 "profile_name",     
                 "layer_name",     
                 "layer_top..paren.cm.paren.",     
                 "layer_bot..paren.cm.paren.",     
                 "hzn_desgn_other",     
                 "hzn",     
                 "hzn_desgn",     
                 "layer_note",     
                 "color",     
                 "vegclass_local",     
                 "soil_taxon",     
                 "soil_series",     
                 "bd_method",     
                 "bd_samp..paren.g.cm.hyphen.3.paren.",     
                 "bd_tot..paren.g.cm.hyphen.3.paren.",     
                 "bd_whole..paren.g.cm.hyphen.3.paren.",     
                 "bd_other..paren.g.cm.hyphen.3.paren.",     
                 "bdNRCS_prep_code",     
                 "cNRCS_prep_code",     
                 "c_method",     
                 "c_tot..paren.percent.paren.",     
                 "oc..paren.percent.paren.",     
                 "loi..paren.percent.paren.",     
                 "n_tot..paren.percent.paren.",     
                 "c_to_n..paren.mass.ratio.paren.",     
                 "soc..paren.g.cm.hyphen.2.paren.",     
                 "soc_carbon_flag",     
                 "soc_method",     
                 "ph_method",     
                 "ph_cacl",     
                 "ph_h2o",     
                 "ph_other",     
                 "caco3..paren.percent.paren.",     
                 "sand_tot_psa..paren.percent.paren.",     
                 "silt_tot_psa..paren.percent.paren.",     
                 "clay_tot_psa..paren.percent.paren.",     
                 "wpg2_method",     
                 "wpg2..paren.percent.paren.",     
                 "cat_exch..paren.cmol.H.plus..kg.hyphen.1.paren.",     
                 "al_dith..paren.specified.by.al_fe_units.paren.",     
                 "al_ox..paren.specified.by.al_fe_units.paren.",     
                 "al_other..paren.specified.by.al_fe_units.paren.",     
                 "fe_dith..paren.specified.by.al_fe_units.paren.",     
                 "fe_ox..paren.specified.by.al_fe_units.paren.",     
                 "fe_other..paren.specified.by.al_fe_units.paren.",     
                 "mn_dith..paren.specified.by.al_fe_units.paren.",     
                 "mn_ox..paren.specified.by.al_fe_units.paren.",     
                 "mn_other..paren.specified.by.al_fe_units.paren.",     
                 "al_fe_units..paren.extract_units.paren.",     
                 "al_fe_method",     
                 "ca_al..paren.specified.by.bc_units.paren.",     
                 "ca_ext..paren.specified.by.bc_units.paren.",     
                 "k_ext..paren.specified.by.bc_units.paren.",     
                 "mg_ext..paren.specified.by.bc_units.paren.",     
                 "na_ext..paren.specified.by.bc_units.paren.",     
                 "bc_units..paren.extract_units.paren.",     
                 "bc_method",     
                 "base_sum..paren.specified.by.cec_h_units.paren.",     
                 "cec_sum..paren.specified.by.cec_h_units.paren.",     
                 "ecec..paren.specified.by.cec_h_units.paren.",     
                 "cec_h_units..paren.extract_units.paren.",     
                 "bs..paren.percent.paren.",     
                 "bs_sum..paren.percent.paren.",     
                 "h_ext..paren.specified.by.metal_ext_units.paren.",     
                 "zn_ext..paren.specified.by.metal_ext_units.paren.",     
                 "metal_ext_units..paren.extract_units.paren.",     
                 "metal_ext_method",     
                 "p_bray..paren.specified.by.p_units.paren.",     
                 "p_ox..paren.specified.by.p_units.paren.",     
                 "p_meh..paren.specified.by.p_units.paren.",     
                 "p_other..paren.specified.by.p_units.paren.",     
                 "p_units..paren.extract_units.paren.",     
                 "p_method",     
                 "root_quant_size",     
                 "root_weight..paren.g.paren.",     
                 "v_15n..paren.â°.paren.",     
                 "v_13c..paren.â°.paren.",     
                 "v_14c..paren.â°.paren.",     
                 "v_14c_sigma..paren.â°.paren.",     
                 "v_14c_age..paren.BP.paren.",     
                 "v_14c_age_sigma..paren.BP.paren.",     
                 "fraction_modern",     
                 "fraction_modern_sigma",     
                 "textureClass",     
                 "locator_parent_alias"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)!="factor") dt1$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.<- as.factor(dt1$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
if (class(dt1$dataset_name_sub)!="factor") dt1$dataset_name_sub<- as.factor(dt1$dataset_name_sub)
if (class(dt1$dataset_name_soc)!="factor") dt1$dataset_name_soc<- as.factor(dt1$dataset_name_soc)
if (class(dt1$lat..paren.dec..deg.paren.)!="factor") dt1$lat..paren.dec..deg.paren.<- as.factor(dt1$lat..paren.dec..deg.paren.)
if (class(dt1$long..paren.dec..deg.paren.)!="factor") dt1$long..paren.dec..deg.paren.<- as.factor(dt1$long..paren.dec..deg.paren.)
if (class(dt1$datum..paren.datum.paren.)!="factor") dt1$datum..paren.datum.paren.<- as.factor(dt1$datum..paren.datum.paren.)
if (class(dt1$state..paren.state_province.paren.)!="factor") dt1$state..paren.state_province.paren.<- as.factor(dt1$state..paren.state_province.paren.)
if (class(dt1$country..paren.country.paren.)!="factor") dt1$country..paren.country.paren.<- as.factor(dt1$country..paren.country.paren.)
if (class(dt1$site_name)!="factor") dt1$site_name<- as.factor(dt1$site_name)
if (class(dt1$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)!="factor") dt1$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.<- as.factor(dt1$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)
if (class(dt1$profile_name)!="factor") dt1$profile_name<- as.factor(dt1$profile_name)
if (class(dt1$layer_name)!="factor") dt1$layer_name<- as.factor(dt1$layer_name)
if (class(dt1$layer_top..paren.cm.paren.)!="factor") dt1$layer_top..paren.cm.paren.<- as.factor(dt1$layer_top..paren.cm.paren.)
if (class(dt1$layer_bot..paren.cm.paren.)!="factor") dt1$layer_bot..paren.cm.paren.<- as.factor(dt1$layer_bot..paren.cm.paren.)
if (class(dt1$hzn_desgn_other)!="factor") dt1$hzn_desgn_other<- as.factor(dt1$hzn_desgn_other)
if (class(dt1$hzn)!="factor") dt1$hzn<- as.factor(dt1$hzn)
if (class(dt1$hzn_desgn)!="factor") dt1$hzn_desgn<- as.factor(dt1$hzn_desgn)
if (class(dt1$layer_note)!="factor") dt1$layer_note<- as.factor(dt1$layer_note)
if (class(dt1$color)!="factor") dt1$color<- as.factor(dt1$color)
if (class(dt1$vegclass_local)!="factor") dt1$vegclass_local<- as.factor(dt1$vegclass_local)
if (class(dt1$soil_taxon)!="factor") dt1$soil_taxon<- as.factor(dt1$soil_taxon)
if (class(dt1$soil_series)!="factor") dt1$soil_series<- as.factor(dt1$soil_series)
if (class(dt1$bd_method)!="factor") dt1$bd_method<- as.factor(dt1$bd_method)
if (class(dt1$bd_samp..paren.g.cm.hyphen.3.paren.)!="factor") dt1$bd_samp..paren.g.cm.hyphen.3.paren.<- as.factor(dt1$bd_samp..paren.g.cm.hyphen.3.paren.)
if (class(dt1$bd_tot..paren.g.cm.hyphen.3.paren.)!="factor") dt1$bd_tot..paren.g.cm.hyphen.3.paren.<- as.factor(dt1$bd_tot..paren.g.cm.hyphen.3.paren.)
if (class(dt1$bd_whole..paren.g.cm.hyphen.3.paren.)!="factor") dt1$bd_whole..paren.g.cm.hyphen.3.paren.<- as.factor(dt1$bd_whole..paren.g.cm.hyphen.3.paren.)
if (class(dt1$bd_other..paren.g.cm.hyphen.3.paren.)!="factor") dt1$bd_other..paren.g.cm.hyphen.3.paren.<- as.factor(dt1$bd_other..paren.g.cm.hyphen.3.paren.)
if (class(dt1$bdNRCS_prep_code)!="factor") dt1$bdNRCS_prep_code<- as.factor(dt1$bdNRCS_prep_code)
if (class(dt1$cNRCS_prep_code)!="factor") dt1$cNRCS_prep_code<- as.factor(dt1$cNRCS_prep_code)
if (class(dt1$c_method)!="factor") dt1$c_method<- as.factor(dt1$c_method)
if (class(dt1$c_tot..paren.percent.paren.)!="factor") dt1$c_tot..paren.percent.paren.<- as.factor(dt1$c_tot..paren.percent.paren.)
if (class(dt1$oc..paren.percent.paren.)!="factor") dt1$oc..paren.percent.paren.<- as.factor(dt1$oc..paren.percent.paren.)
if (class(dt1$loi..paren.percent.paren.)!="factor") dt1$loi..paren.percent.paren.<- as.factor(dt1$loi..paren.percent.paren.)
if (class(dt1$n_tot..paren.percent.paren.)!="factor") dt1$n_tot..paren.percent.paren.<- as.factor(dt1$n_tot..paren.percent.paren.)
if (class(dt1$c_to_n..paren.mass.ratio.paren.)!="factor") dt1$c_to_n..paren.mass.ratio.paren.<- as.factor(dt1$c_to_n..paren.mass.ratio.paren.)
if (class(dt1$soc..paren.g.cm.hyphen.2.paren.)!="factor") dt1$soc..paren.g.cm.hyphen.2.paren.<- as.factor(dt1$soc..paren.g.cm.hyphen.2.paren.)
if (class(dt1$soc_carbon_flag)!="factor") dt1$soc_carbon_flag<- as.factor(dt1$soc_carbon_flag)
if (class(dt1$soc_method)!="factor") dt1$soc_method<- as.factor(dt1$soc_method)
if (class(dt1$ph_method)!="factor") dt1$ph_method<- as.factor(dt1$ph_method)
if (class(dt1$ph_cacl)!="factor") dt1$ph_cacl<- as.factor(dt1$ph_cacl)
if (class(dt1$ph_h2o)!="factor") dt1$ph_h2o<- as.factor(dt1$ph_h2o)
if (class(dt1$ph_other)!="factor") dt1$ph_other<- as.factor(dt1$ph_other)
if (class(dt1$caco3..paren.percent.paren.)!="factor") dt1$caco3..paren.percent.paren.<- as.factor(dt1$caco3..paren.percent.paren.)
if (class(dt1$sand_tot_psa..paren.percent.paren.)!="factor") dt1$sand_tot_psa..paren.percent.paren.<- as.factor(dt1$sand_tot_psa..paren.percent.paren.)
if (class(dt1$silt_tot_psa..paren.percent.paren.)!="factor") dt1$silt_tot_psa..paren.percent.paren.<- as.factor(dt1$silt_tot_psa..paren.percent.paren.)
if (class(dt1$clay_tot_psa..paren.percent.paren.)!="factor") dt1$clay_tot_psa..paren.percent.paren.<- as.factor(dt1$clay_tot_psa..paren.percent.paren.)
if (class(dt1$wpg2_method)!="factor") dt1$wpg2_method<- as.factor(dt1$wpg2_method)
if (class(dt1$wpg2..paren.percent.paren.)!="factor") dt1$wpg2..paren.percent.paren.<- as.factor(dt1$wpg2..paren.percent.paren.)
if (class(dt1$cat_exch..paren.cmol.H.plus..kg.hyphen.1.paren.)!="factor") dt1$cat_exch..paren.cmol.H.plus..kg.hyphen.1.paren.<- as.factor(dt1$cat_exch..paren.cmol.H.plus..kg.hyphen.1.paren.)
if (class(dt1$al_dith..paren.specified.by.al_fe_units.paren.)!="factor") dt1$al_dith..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$al_dith..paren.specified.by.al_fe_units.paren.)
if (class(dt1$al_ox..paren.specified.by.al_fe_units.paren.)!="factor") dt1$al_ox..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$al_ox..paren.specified.by.al_fe_units.paren.)
if (class(dt1$al_other..paren.specified.by.al_fe_units.paren.)!="factor") dt1$al_other..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$al_other..paren.specified.by.al_fe_units.paren.)
if (class(dt1$fe_dith..paren.specified.by.al_fe_units.paren.)!="factor") dt1$fe_dith..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$fe_dith..paren.specified.by.al_fe_units.paren.)
if (class(dt1$fe_ox..paren.specified.by.al_fe_units.paren.)!="factor") dt1$fe_ox..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$fe_ox..paren.specified.by.al_fe_units.paren.)
if (class(dt1$fe_other..paren.specified.by.al_fe_units.paren.)!="factor") dt1$fe_other..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$fe_other..paren.specified.by.al_fe_units.paren.)
if (class(dt1$mn_dith..paren.specified.by.al_fe_units.paren.)!="factor") dt1$mn_dith..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$mn_dith..paren.specified.by.al_fe_units.paren.)
if (class(dt1$mn_ox..paren.specified.by.al_fe_units.paren.)!="factor") dt1$mn_ox..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$mn_ox..paren.specified.by.al_fe_units.paren.)
if (class(dt1$mn_other..paren.specified.by.al_fe_units.paren.)!="factor") dt1$mn_other..paren.specified.by.al_fe_units.paren.<- as.factor(dt1$mn_other..paren.specified.by.al_fe_units.paren.)
if (class(dt1$al_fe_units..paren.extract_units.paren.)!="factor") dt1$al_fe_units..paren.extract_units.paren.<- as.factor(dt1$al_fe_units..paren.extract_units.paren.)
if (class(dt1$al_fe_method)!="factor") dt1$al_fe_method<- as.factor(dt1$al_fe_method)
if (class(dt1$ca_al..paren.specified.by.bc_units.paren.)!="factor") dt1$ca_al..paren.specified.by.bc_units.paren.<- as.factor(dt1$ca_al..paren.specified.by.bc_units.paren.)
if (class(dt1$ca_ext..paren.specified.by.bc_units.paren.)!="factor") dt1$ca_ext..paren.specified.by.bc_units.paren.<- as.factor(dt1$ca_ext..paren.specified.by.bc_units.paren.)
if (class(dt1$k_ext..paren.specified.by.bc_units.paren.)!="factor") dt1$k_ext..paren.specified.by.bc_units.paren.<- as.factor(dt1$k_ext..paren.specified.by.bc_units.paren.)
if (class(dt1$mg_ext..paren.specified.by.bc_units.paren.)!="factor") dt1$mg_ext..paren.specified.by.bc_units.paren.<- as.factor(dt1$mg_ext..paren.specified.by.bc_units.paren.)
if (class(dt1$na_ext..paren.specified.by.bc_units.paren.)!="factor") dt1$na_ext..paren.specified.by.bc_units.paren.<- as.factor(dt1$na_ext..paren.specified.by.bc_units.paren.)
if (class(dt1$bc_units..paren.extract_units.paren.)!="factor") dt1$bc_units..paren.extract_units.paren.<- as.factor(dt1$bc_units..paren.extract_units.paren.)
if (class(dt1$bc_method)!="factor") dt1$bc_method<- as.factor(dt1$bc_method)
if (class(dt1$base_sum..paren.specified.by.cec_h_units.paren.)!="factor") dt1$base_sum..paren.specified.by.cec_h_units.paren.<- as.factor(dt1$base_sum..paren.specified.by.cec_h_units.paren.)
if (class(dt1$cec_sum..paren.specified.by.cec_h_units.paren.)!="factor") dt1$cec_sum..paren.specified.by.cec_h_units.paren.<- as.factor(dt1$cec_sum..paren.specified.by.cec_h_units.paren.)
if (class(dt1$ecec..paren.specified.by.cec_h_units.paren.)!="factor") dt1$ecec..paren.specified.by.cec_h_units.paren.<- as.factor(dt1$ecec..paren.specified.by.cec_h_units.paren.)
if (class(dt1$cec_h_units..paren.extract_units.paren.)!="factor") dt1$cec_h_units..paren.extract_units.paren.<- as.factor(dt1$cec_h_units..paren.extract_units.paren.)
if (class(dt1$bs..paren.percent.paren.)!="factor") dt1$bs..paren.percent.paren.<- as.factor(dt1$bs..paren.percent.paren.)
if (class(dt1$bs_sum..paren.percent.paren.)!="factor") dt1$bs_sum..paren.percent.paren.<- as.factor(dt1$bs_sum..paren.percent.paren.)
if (class(dt1$h_ext..paren.specified.by.metal_ext_units.paren.)!="factor") dt1$h_ext..paren.specified.by.metal_ext_units.paren.<- as.factor(dt1$h_ext..paren.specified.by.metal_ext_units.paren.)
if (class(dt1$zn_ext..paren.specified.by.metal_ext_units.paren.)!="factor") dt1$zn_ext..paren.specified.by.metal_ext_units.paren.<- as.factor(dt1$zn_ext..paren.specified.by.metal_ext_units.paren.)
if (class(dt1$metal_ext_units..paren.extract_units.paren.)!="factor") dt1$metal_ext_units..paren.extract_units.paren.<- as.factor(dt1$metal_ext_units..paren.extract_units.paren.)
if (class(dt1$metal_ext_method)!="factor") dt1$metal_ext_method<- as.factor(dt1$metal_ext_method)
if (class(dt1$p_bray..paren.specified.by.p_units.paren.)!="factor") dt1$p_bray..paren.specified.by.p_units.paren.<- as.factor(dt1$p_bray..paren.specified.by.p_units.paren.)
if (class(dt1$p_ox..paren.specified.by.p_units.paren.)!="factor") dt1$p_ox..paren.specified.by.p_units.paren.<- as.factor(dt1$p_ox..paren.specified.by.p_units.paren.)
if (class(dt1$p_meh..paren.specified.by.p_units.paren.)!="factor") dt1$p_meh..paren.specified.by.p_units.paren.<- as.factor(dt1$p_meh..paren.specified.by.p_units.paren.)
if (class(dt1$p_other..paren.specified.by.p_units.paren.)!="factor") dt1$p_other..paren.specified.by.p_units.paren.<- as.factor(dt1$p_other..paren.specified.by.p_units.paren.)
if (class(dt1$p_units..paren.extract_units.paren.)!="factor") dt1$p_units..paren.extract_units.paren.<- as.factor(dt1$p_units..paren.extract_units.paren.)
if (class(dt1$p_method)!="factor") dt1$p_method<- as.factor(dt1$p_method)
if (class(dt1$root_quant_size)!="factor") dt1$root_quant_size<- as.factor(dt1$root_quant_size)
if (class(dt1$root_weight..paren.g.paren.)!="factor") dt1$root_weight..paren.g.paren.<- as.factor(dt1$root_weight..paren.g.paren.)
if (class(dt1$v_15n..paren.â°.paren.)!="factor") dt1$v_15n..paren.â°.paren.<- as.factor(dt1$v_15n..paren.â°.paren.)
if (class(dt1$v_13c..paren.â°.paren.)!="factor") dt1$v_13c..paren.â°.paren.<- as.factor(dt1$v_13c..paren.â°.paren.)
if (class(dt1$v_14c..paren.â°.paren.)!="factor") dt1$v_14c..paren.â°.paren.<- as.factor(dt1$v_14c..paren.â°.paren.)
if (class(dt1$v_14c_sigma..paren.â°.paren.)!="factor") dt1$v_14c_sigma..paren.â°.paren.<- as.factor(dt1$v_14c_sigma..paren.â°.paren.)
if (class(dt1$v_14c_age..paren.BP.paren.)!="factor") dt1$v_14c_age..paren.BP.paren.<- as.factor(dt1$v_14c_age..paren.BP.paren.)
if (class(dt1$v_14c_age_sigma..paren.BP.paren.)!="factor") dt1$v_14c_age_sigma..paren.BP.paren.<- as.factor(dt1$v_14c_age_sigma..paren.BP.paren.)
if (class(dt1$fraction_modern)!="factor") dt1$fraction_modern<- as.factor(dt1$fraction_modern)
if (class(dt1$fraction_modern_sigma)!="factor") dt1$fraction_modern_sigma<- as.factor(dt1$fraction_modern_sigma)
if (class(dt1$textureClass)!="factor") dt1$textureClass<- as.factor(dt1$textureClass)
if (class(dt1$locator_parent_alias)!="factor") dt1$locator_parent_alias<- as.factor(dt1$locator_parent_alias)

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
summary(dataset_name_sub)
summary(dataset_name_soc)
summary(lat..paren.dec..deg.paren.)
summary(long..paren.dec..deg.paren.)
summary(datum..paren.datum.paren.)
summary(state..paren.state_province.paren.)
summary(country..paren.country.paren.)
summary(site_name)
summary(observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)
summary(profile_name)
summary(layer_name)
summary(layer_top..paren.cm.paren.)
summary(layer_bot..paren.cm.paren.)
summary(hzn_desgn_other)
summary(hzn)
summary(hzn_desgn)
summary(layer_note)
summary(color)
summary(vegclass_local)
summary(soil_taxon)
summary(soil_series)
summary(bd_method)
summary(bd_samp..paren.g.cm.hyphen.3.paren.)
summary(bd_tot..paren.g.cm.hyphen.3.paren.)
summary(bd_whole..paren.g.cm.hyphen.3.paren.)
summary(bd_other..paren.g.cm.hyphen.3.paren.)
summary(bdNRCS_prep_code)
summary(cNRCS_prep_code)
summary(c_method)
summary(c_tot..paren.percent.paren.)
summary(oc..paren.percent.paren.)
summary(loi..paren.percent.paren.)
summary(n_tot..paren.percent.paren.)
summary(c_to_n..paren.mass.ratio.paren.)
summary(soc..paren.g.cm.hyphen.2.paren.)
summary(soc_carbon_flag)
summary(soc_method)
summary(ph_method)
summary(ph_cacl)
summary(ph_h2o)
summary(ph_other)
summary(caco3..paren.percent.paren.)
summary(sand_tot_psa..paren.percent.paren.)
summary(silt_tot_psa..paren.percent.paren.)
summary(clay_tot_psa..paren.percent.paren.)
summary(wpg2_method)
summary(wpg2..paren.percent.paren.)
summary(cat_exch..paren.cmol.H.plus..kg.hyphen.1.paren.)
summary(al_dith..paren.specified.by.al_fe_units.paren.)
summary(al_ox..paren.specified.by.al_fe_units.paren.)
summary(al_other..paren.specified.by.al_fe_units.paren.)
summary(fe_dith..paren.specified.by.al_fe_units.paren.)
summary(fe_ox..paren.specified.by.al_fe_units.paren.)
summary(fe_other..paren.specified.by.al_fe_units.paren.)
summary(mn_dith..paren.specified.by.al_fe_units.paren.)
summary(mn_ox..paren.specified.by.al_fe_units.paren.)
summary(mn_other..paren.specified.by.al_fe_units.paren.)
summary(al_fe_units..paren.extract_units.paren.)
summary(al_fe_method)
summary(ca_al..paren.specified.by.bc_units.paren.)
summary(ca_ext..paren.specified.by.bc_units.paren.)
summary(k_ext..paren.specified.by.bc_units.paren.)
summary(mg_ext..paren.specified.by.bc_units.paren.)
summary(na_ext..paren.specified.by.bc_units.paren.)
summary(bc_units..paren.extract_units.paren.)
summary(bc_method)
summary(base_sum..paren.specified.by.cec_h_units.paren.)
summary(cec_sum..paren.specified.by.cec_h_units.paren.)
summary(ecec..paren.specified.by.cec_h_units.paren.)
summary(cec_h_units..paren.extract_units.paren.)
summary(bs..paren.percent.paren.)
summary(bs_sum..paren.percent.paren.)
summary(h_ext..paren.specified.by.metal_ext_units.paren.)
summary(zn_ext..paren.specified.by.metal_ext_units.paren.)
summary(metal_ext_units..paren.extract_units.paren.)
summary(metal_ext_method)
summary(p_bray..paren.specified.by.p_units.paren.)
summary(p_ox..paren.specified.by.p_units.paren.)
summary(p_meh..paren.specified.by.p_units.paren.)
summary(p_other..paren.specified.by.p_units.paren.)
summary(p_units..paren.extract_units.paren.)
summary(p_method)
summary(root_quant_size)
summary(root_weight..paren.g.paren.)
summary(v_15n..paren.â°.paren.)
summary(v_13c..paren.â°.paren.)
summary(v_14c..paren.â°.paren.)
summary(v_14c_sigma..paren.â°.paren.)
summary(v_14c_age..paren.BP.paren.)
summary(v_14c_age_sigma..paren.BP.paren.)
summary(fraction_modern)
summary(fraction_modern_sigma)
summary(textureClass)
summary(locator_parent_alias) 
# Get more details on character variables

summary(as.factor(dt1$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)) 
summary(as.factor(dt1$dataset_name_sub)) 
summary(as.factor(dt1$dataset_name_soc)) 
summary(as.factor(dt1$lat..paren.dec..deg.paren.)) 
summary(as.factor(dt1$long..paren.dec..deg.paren.)) 
summary(as.factor(dt1$datum..paren.datum.paren.)) 
summary(as.factor(dt1$state..paren.state_province.paren.)) 
summary(as.factor(dt1$country..paren.country.paren.)) 
summary(as.factor(dt1$site_name)) 
summary(as.factor(dt1$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)) 
summary(as.factor(dt1$profile_name)) 
summary(as.factor(dt1$layer_name)) 
summary(as.factor(dt1$layer_top..paren.cm.paren.)) 
summary(as.factor(dt1$layer_bot..paren.cm.paren.)) 
summary(as.factor(dt1$hzn_desgn_other)) 
summary(as.factor(dt1$hzn)) 
summary(as.factor(dt1$hzn_desgn)) 
summary(as.factor(dt1$layer_note)) 
summary(as.factor(dt1$color)) 
summary(as.factor(dt1$vegclass_local)) 
summary(as.factor(dt1$soil_taxon)) 
summary(as.factor(dt1$soil_series)) 
summary(as.factor(dt1$bd_method)) 
summary(as.factor(dt1$bd_samp..paren.g.cm.hyphen.3.paren.)) 
summary(as.factor(dt1$bd_tot..paren.g.cm.hyphen.3.paren.)) 
summary(as.factor(dt1$bd_whole..paren.g.cm.hyphen.3.paren.)) 
summary(as.factor(dt1$bd_other..paren.g.cm.hyphen.3.paren.)) 
summary(as.factor(dt1$bdNRCS_prep_code)) 
summary(as.factor(dt1$cNRCS_prep_code)) 
summary(as.factor(dt1$c_method)) 
summary(as.factor(dt1$c_tot..paren.percent.paren.)) 
summary(as.factor(dt1$oc..paren.percent.paren.)) 
summary(as.factor(dt1$loi..paren.percent.paren.)) 
summary(as.factor(dt1$n_tot..paren.percent.paren.)) 
summary(as.factor(dt1$c_to_n..paren.mass.ratio.paren.)) 
summary(as.factor(dt1$soc..paren.g.cm.hyphen.2.paren.)) 
summary(as.factor(dt1$soc_carbon_flag)) 
summary(as.factor(dt1$soc_method)) 
summary(as.factor(dt1$ph_method)) 
summary(as.factor(dt1$ph_cacl)) 
summary(as.factor(dt1$ph_h2o)) 
summary(as.factor(dt1$ph_other)) 
summary(as.factor(dt1$caco3..paren.percent.paren.)) 
summary(as.factor(dt1$sand_tot_psa..paren.percent.paren.)) 
summary(as.factor(dt1$silt_tot_psa..paren.percent.paren.)) 
summary(as.factor(dt1$clay_tot_psa..paren.percent.paren.)) 
summary(as.factor(dt1$wpg2_method)) 
summary(as.factor(dt1$wpg2..paren.percent.paren.)) 
summary(as.factor(dt1$cat_exch..paren.cmol.H.plus..kg.hyphen.1.paren.)) 
summary(as.factor(dt1$al_dith..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$al_ox..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$al_other..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$fe_dith..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$fe_ox..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$fe_other..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$mn_dith..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$mn_ox..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$mn_other..paren.specified.by.al_fe_units.paren.)) 
summary(as.factor(dt1$al_fe_units..paren.extract_units.paren.)) 
summary(as.factor(dt1$al_fe_method)) 
summary(as.factor(dt1$ca_al..paren.specified.by.bc_units.paren.)) 
summary(as.factor(dt1$ca_ext..paren.specified.by.bc_units.paren.)) 
summary(as.factor(dt1$k_ext..paren.specified.by.bc_units.paren.)) 
summary(as.factor(dt1$mg_ext..paren.specified.by.bc_units.paren.)) 
summary(as.factor(dt1$na_ext..paren.specified.by.bc_units.paren.)) 
summary(as.factor(dt1$bc_units..paren.extract_units.paren.)) 
summary(as.factor(dt1$bc_method)) 
summary(as.factor(dt1$base_sum..paren.specified.by.cec_h_units.paren.)) 
summary(as.factor(dt1$cec_sum..paren.specified.by.cec_h_units.paren.)) 
summary(as.factor(dt1$ecec..paren.specified.by.cec_h_units.paren.)) 
summary(as.factor(dt1$cec_h_units..paren.extract_units.paren.)) 
summary(as.factor(dt1$bs..paren.percent.paren.)) 
summary(as.factor(dt1$bs_sum..paren.percent.paren.)) 
summary(as.factor(dt1$h_ext..paren.specified.by.metal_ext_units.paren.)) 
summary(as.factor(dt1$zn_ext..paren.specified.by.metal_ext_units.paren.)) 
summary(as.factor(dt1$metal_ext_units..paren.extract_units.paren.)) 
summary(as.factor(dt1$metal_ext_method)) 
summary(as.factor(dt1$p_bray..paren.specified.by.p_units.paren.)) 
summary(as.factor(dt1$p_ox..paren.specified.by.p_units.paren.)) 
summary(as.factor(dt1$p_meh..paren.specified.by.p_units.paren.)) 
summary(as.factor(dt1$p_other..paren.specified.by.p_units.paren.)) 
summary(as.factor(dt1$p_units..paren.extract_units.paren.)) 
summary(as.factor(dt1$p_method)) 
summary(as.factor(dt1$root_quant_size)) 
summary(as.factor(dt1$root_weight..paren.g.paren.)) 
summary(as.factor(dt1$v_15n..paren.â°.paren.)) 
summary(as.factor(dt1$v_13c..paren.â°.paren.)) 
summary(as.factor(dt1$v_14c..paren.â°.paren.)) 
summary(as.factor(dt1$v_14c_sigma..paren.â°.paren.)) 
summary(as.factor(dt1$v_14c_age..paren.BP.paren.)) 
summary(as.factor(dt1$v_14c_age_sigma..paren.BP.paren.)) 
summary(as.factor(dt1$fraction_modern)) 
summary(as.factor(dt1$fraction_modern_sigma)) 
summary(as.factor(dt1$textureClass)) 
summary(as.factor(dt1$locator_parent_alias))
detach(dt1)               


inUrl2  <- "https://pasta.lternet.edu/package/data/eml/edi/1160/1/40527580cc045d33d9a5aaf728bf204e" 
infile2 <- tempfile()
try(download.file(inUrl2,infile2,method="curl"))
if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")


dt2 <-read.csv(infile2,header=F 
               ,skip=1
               ,sep=";"  
               ,quot='"' 
               , col.names=c(
                 "ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.",     
                 "dataset_name_sub",     
                 "dataset_name_soc",     
                 "lat..paren.dec..deg.paren.",     
                 "long..paren.dec..deg.paren.",     
                 "datum..paren.datum.paren.",     
                 "state..paren.state_province.paren.",     
                 "country..paren.country.paren.",     
                 "observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.",     
                 "site_name",     
                 "profile_name",     
                 "profile_zero_ref..paren.profile_zero_ref.paren.",     
                 "layer_top..paren.cm.paren.",     
                 "layer_bot..paren.cm.paren.",     
                 "total_lcount",     
                 "carbon_lcount",     
                 "soc_lcount",     
                 "soc_depth..paren.cm.paren.",     
                 "soc..paren.g.cm.hyphen.2.paren.",     
                 "soc_method",     
                 "soc_spatial_flag",     
                 "soc_carbon_flag",     
                 "soil_taxon",     
                 "soil_series",     
                 "elevation..paren.m.paren.",     
                 "ecoregion",     
                 "landuse..paren.landsat.paren.",     
                 "vegclass_local",     
                 "surface_veg",     
                 "landscape..paren.landscape.paren.",     
                 "landform..paren.landform.paren.",     
                 "v_2d_position..paren.2d_position.paren.",     
                 "landform_note",     
                 "aspect_deg..paren.degree.paren.",     
                 "slope..paren.percent.paren.",     
                 "drainagecl..paren.drainage.paren.",     
                 "map..paren.mm.paren.",     
                 "mat..paren.Â°C.paren.",     
                 "runoff..paren.runoff.paren.",     
                 "site_perm..paren.site_perm.paren.",     
                 "site_note",     
                 "thaw_depth_profile..paren.cm.paren.",     
                 "locator_alias",     
                 "locator_parent_alias"    ), check.names=TRUE)

unlink(infile2)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt2$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)!="factor") dt2$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.<- as.factor(dt2$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
if (class(dt2$dataset_name_sub)!="factor") dt2$dataset_name_sub<- as.factor(dt2$dataset_name_sub)
if (class(dt2$dataset_name_soc)!="factor") dt2$dataset_name_soc<- as.factor(dt2$dataset_name_soc)
if (class(dt2$lat..paren.dec..deg.paren.)!="factor") dt2$lat..paren.dec..deg.paren.<- as.factor(dt2$lat..paren.dec..deg.paren.)
if (class(dt2$long..paren.dec..deg.paren.)!="factor") dt2$long..paren.dec..deg.paren.<- as.factor(dt2$long..paren.dec..deg.paren.)
if (class(dt2$datum..paren.datum.paren.)!="factor") dt2$datum..paren.datum.paren.<- as.factor(dt2$datum..paren.datum.paren.)
if (class(dt2$state..paren.state_province.paren.)!="factor") dt2$state..paren.state_province.paren.<- as.factor(dt2$state..paren.state_province.paren.)
if (class(dt2$country..paren.country.paren.)!="factor") dt2$country..paren.country.paren.<- as.factor(dt2$country..paren.country.paren.)
if (class(dt2$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)!="factor") dt2$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.<- as.factor(dt2$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)
if (class(dt2$site_name)!="factor") dt2$site_name<- as.factor(dt2$site_name)
if (class(dt2$profile_name)!="factor") dt2$profile_name<- as.factor(dt2$profile_name)
if (class(dt2$profile_zero_ref..paren.profile_zero_ref.paren.)!="factor") dt2$profile_zero_ref..paren.profile_zero_ref.paren.<- as.factor(dt2$profile_zero_ref..paren.profile_zero_ref.paren.)
if (class(dt2$layer_top..paren.cm.paren.)!="factor") dt2$layer_top..paren.cm.paren.<- as.factor(dt2$layer_top..paren.cm.paren.)
if (class(dt2$layer_bot..paren.cm.paren.)!="factor") dt2$layer_bot..paren.cm.paren.<- as.factor(dt2$layer_bot..paren.cm.paren.)
if (class(dt2$total_lcount)!="factor") dt2$total_lcount<- as.factor(dt2$total_lcount)
if (class(dt2$carbon_lcount)!="factor") dt2$carbon_lcount<- as.factor(dt2$carbon_lcount)
if (class(dt2$soc_lcount)!="factor") dt2$soc_lcount<- as.factor(dt2$soc_lcount)
if (class(dt2$soc_depth..paren.cm.paren.)!="factor") dt2$soc_depth..paren.cm.paren.<- as.factor(dt2$soc_depth..paren.cm.paren.)
if (class(dt2$soc..paren.g.cm.hyphen.2.paren.)!="factor") dt2$soc..paren.g.cm.hyphen.2.paren.<- as.factor(dt2$soc..paren.g.cm.hyphen.2.paren.)
if (class(dt2$soc_method)!="factor") dt2$soc_method<- as.factor(dt2$soc_method)
if (class(dt2$soc_spatial_flag)!="factor") dt2$soc_spatial_flag<- as.factor(dt2$soc_spatial_flag)
if (class(dt2$soc_carbon_flag)!="factor") dt2$soc_carbon_flag<- as.factor(dt2$soc_carbon_flag)
if (class(dt2$soil_taxon)!="factor") dt2$soil_taxon<- as.factor(dt2$soil_taxon)
if (class(dt2$soil_series)!="factor") dt2$soil_series<- as.factor(dt2$soil_series)
if (class(dt2$elevation..paren.m.paren.)!="factor") dt2$elevation..paren.m.paren.<- as.factor(dt2$elevation..paren.m.paren.)
if (class(dt2$ecoregion)!="factor") dt2$ecoregion<- as.factor(dt2$ecoregion)
if (class(dt2$landuse..paren.landsat.paren.)!="factor") dt2$landuse..paren.landsat.paren.<- as.factor(dt2$landuse..paren.landsat.paren.)
if (class(dt2$vegclass_local)!="factor") dt2$vegclass_local<- as.factor(dt2$vegclass_local)
if (class(dt2$surface_veg)!="factor") dt2$surface_veg<- as.factor(dt2$surface_veg)
if (class(dt2$landscape..paren.landscape.paren.)!="factor") dt2$landscape..paren.landscape.paren.<- as.factor(dt2$landscape..paren.landscape.paren.)
if (class(dt2$landform..paren.landform.paren.)!="factor") dt2$landform..paren.landform.paren.<- as.factor(dt2$landform..paren.landform.paren.)
if (class(dt2$v_2d_position..paren.2d_position.paren.)!="factor") dt2$v_2d_position..paren.2d_position.paren.<- as.factor(dt2$v_2d_position..paren.2d_position.paren.)
if (class(dt2$landform_note)!="factor") dt2$landform_note<- as.factor(dt2$landform_note)
if (class(dt2$aspect_deg..paren.degree.paren.)!="factor") dt2$aspect_deg..paren.degree.paren.<- as.factor(dt2$aspect_deg..paren.degree.paren.)
if (class(dt2$slope..paren.percent.paren.)!="factor") dt2$slope..paren.percent.paren.<- as.factor(dt2$slope..paren.percent.paren.)
if (class(dt2$drainagecl..paren.drainage.paren.)!="factor") dt2$drainagecl..paren.drainage.paren.<- as.factor(dt2$drainagecl..paren.drainage.paren.)
if (class(dt2$map..paren.mm.paren.)!="factor") dt2$map..paren.mm.paren.<- as.factor(dt2$map..paren.mm.paren.)
if (class(dt2$mat..paren.Â°C.paren.)!="factor") dt2$mat..paren.Â°C.paren.<- as.factor(dt2$mat..paren.Â°C.paren.)
if (class(dt2$runoff..paren.runoff.paren.)!="factor") dt2$runoff..paren.runoff.paren.<- as.factor(dt2$runoff..paren.runoff.paren.)
if (class(dt2$site_perm..paren.site_perm.paren.)!="factor") dt2$site_perm..paren.site_perm.paren.<- as.factor(dt2$site_perm..paren.site_perm.paren.)
if (class(dt2$site_note)!="factor") dt2$site_note<- as.factor(dt2$site_note)
if (class(dt2$thaw_depth_profile..paren.cm.paren.)!="factor") dt2$thaw_depth_profile..paren.cm.paren.<- as.factor(dt2$thaw_depth_profile..paren.cm.paren.)
if (class(dt2$locator_alias)!="factor") dt2$locator_alias<- as.factor(dt2$locator_alias)
if (class(dt2$locator_parent_alias)!="factor") dt2$locator_parent_alias<- as.factor(dt2$locator_parent_alias)

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt2)                            
attach(dt2)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
summary(dataset_name_sub)
summary(dataset_name_soc)
summary(lat..paren.dec..deg.paren.)
summary(long..paren.dec..deg.paren.)
summary(datum..paren.datum.paren.)
summary(state..paren.state_province.paren.)
summary(country..paren.country.paren.)
summary(observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)
summary(site_name)
summary(profile_name)
summary(profile_zero_ref..paren.profile_zero_ref.paren.)
summary(layer_top..paren.cm.paren.)
summary(layer_bot..paren.cm.paren.)
summary(total_lcount)
summary(carbon_lcount)
summary(soc_lcount)
summary(soc_depth..paren.cm.paren.)
summary(soc..paren.g.cm.hyphen.2.paren.)
summary(soc_method)
summary(soc_spatial_flag)
summary(soc_carbon_flag)
summary(soil_taxon)
summary(soil_series)
summary(elevation..paren.m.paren.)
summary(ecoregion)
summary(landuse..paren.landsat.paren.)
summary(vegclass_local)
summary(surface_veg)
summary(landscape..paren.landscape.paren.)
summary(landform..paren.landform.paren.)
summary(v_2d_position..paren.2d_position.paren.)
summary(landform_note)
summary(aspect_deg..paren.degree.paren.)
summary(slope..paren.percent.paren.)
summary(drainagecl..paren.drainage.paren.)
summary(map..paren.mm.paren.)
summary(mat..paren.Â°C.paren.)
summary(runoff..paren.runoff.paren.)
summary(site_perm..paren.site_perm.paren.)
summary(site_note)
summary(thaw_depth_profile..paren.cm.paren.)
summary(locator_alias)
summary(locator_parent_alias) 
# Get more details on character variables

summary(as.factor(dt2$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)) 
summary(as.factor(dt2$dataset_name_sub)) 
summary(as.factor(dt2$dataset_name_soc)) 
summary(as.factor(dt2$lat..paren.dec..deg.paren.)) 
summary(as.factor(dt2$long..paren.dec..deg.paren.)) 
summary(as.factor(dt2$datum..paren.datum.paren.)) 
summary(as.factor(dt2$state..paren.state_province.paren.)) 
summary(as.factor(dt2$country..paren.country.paren.)) 
summary(as.factor(dt2$observation_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)) 
summary(as.factor(dt2$site_name)) 
summary(as.factor(dt2$profile_name)) 
summary(as.factor(dt2$profile_zero_ref..paren.profile_zero_ref.paren.)) 
summary(as.factor(dt2$layer_top..paren.cm.paren.)) 
summary(as.factor(dt2$layer_bot..paren.cm.paren.)) 
summary(as.factor(dt2$total_lcount)) 
summary(as.factor(dt2$carbon_lcount)) 
summary(as.factor(dt2$soc_lcount)) 
summary(as.factor(dt2$soc_depth..paren.cm.paren.)) 
summary(as.factor(dt2$soc..paren.g.cm.hyphen.2.paren.)) 
summary(as.factor(dt2$soc_method)) 
summary(as.factor(dt2$soc_spatial_flag)) 
summary(as.factor(dt2$soc_carbon_flag)) 
summary(as.factor(dt2$soil_taxon)) 
summary(as.factor(dt2$soil_series)) 
summary(as.factor(dt2$elevation..paren.m.paren.)) 
summary(as.factor(dt2$ecoregion)) 
summary(as.factor(dt2$landuse..paren.landsat.paren.)) 
summary(as.factor(dt2$vegclass_local)) 
summary(as.factor(dt2$surface_veg)) 
summary(as.factor(dt2$landscape..paren.landscape.paren.)) 
summary(as.factor(dt2$landform..paren.landform.paren.)) 
summary(as.factor(dt2$v_2d_position..paren.2d_position.paren.)) 
summary(as.factor(dt2$landform_note)) 
summary(as.factor(dt2$aspect_deg..paren.degree.paren.)) 
summary(as.factor(dt2$slope..paren.percent.paren.)) 
summary(as.factor(dt2$drainagecl..paren.drainage.paren.)) 
summary(as.factor(dt2$map..paren.mm.paren.)) 
summary(as.factor(dt2$mat..paren.Â°C.paren.)) 
summary(as.factor(dt2$runoff..paren.runoff.paren.)) 
summary(as.factor(dt2$site_perm..paren.site_perm.paren.)) 
summary(as.factor(dt2$site_note)) 
summary(as.factor(dt2$thaw_depth_profile..paren.cm.paren.)) 
summary(as.factor(dt2$locator_alias)) 
summary(as.factor(dt2$locator_parent_alias))
detach(dt2)               


inUrl3  <- "https://pasta.lternet.edu/package/data/eml/edi/1160/1/320e31ca911f187550ca2143c31fd408" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")


dt3 <-read.csv(infile3,header=F 
               ,skip=1
               ,sep=";"  
               ,quot='"' 
               , col.names=c(
                 "ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.",     
                 "dataset_name",     
                 "dataset_type..paren.dataset_type.paren.",     
                 "curator_name",     
                 "curator_organization",     
                 "curator_email",     
                 "reference",     
                 "citation",     
                 "citation_usage",     
                 "acknowledgement",     
                 "acknowledgement_usage",     
                 "modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren."    ), check.names=TRUE)

unlink(infile3)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt3$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)!="factor") dt3$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.<- as.factor(dt3$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
if (class(dt3$dataset_name)!="factor") dt3$dataset_name<- as.factor(dt3$dataset_name)
if (class(dt3$dataset_type..paren.dataset_type.paren.)!="factor") dt3$dataset_type..paren.dataset_type.paren.<- as.factor(dt3$dataset_type..paren.dataset_type.paren.)
if (class(dt3$curator_name)!="factor") dt3$curator_name<- as.factor(dt3$curator_name)
if (class(dt3$curator_organization)!="factor") dt3$curator_organization<- as.factor(dt3$curator_organization)
if (class(dt3$curator_email)!="factor") dt3$curator_email<- as.factor(dt3$curator_email)
if (class(dt3$reference)!="factor") dt3$reference<- as.factor(dt3$reference)
if (class(dt3$citation)!="factor") dt3$citation<- as.factor(dt3$citation)
if (class(dt3$citation_usage)!="factor") dt3$citation_usage<- as.factor(dt3$citation_usage)
if (class(dt3$acknowledgement)!="factor") dt3$acknowledgement<- as.factor(dt3$acknowledgement)
if (class(dt3$acknowledgement_usage)!="factor") dt3$acknowledgement_usage<- as.factor(dt3$acknowledgement_usage)
if (class(dt3$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)!="factor") dt3$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.<- as.factor(dt3$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt3)                            
attach(dt3)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
summary(dataset_name)
summary(dataset_type..paren.dataset_type.paren.)
summary(curator_name)
summary(curator_organization)
summary(curator_email)
summary(reference)
summary(citation)
summary(citation_usage)
summary(acknowledgement)
summary(acknowledgement_usage)
summary(modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.) 
# Get more details on character variables

summary(as.factor(dt3$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)) 
summary(as.factor(dt3$dataset_name)) 
summary(as.factor(dt3$dataset_type..paren.dataset_type.paren.)) 
summary(as.factor(dt3$curator_name)) 
summary(as.factor(dt3$curator_organization)) 
summary(as.factor(dt3$curator_email)) 
summary(as.factor(dt3$reference)) 
summary(as.factor(dt3$citation)) 
summary(as.factor(dt3$citation_usage)) 
summary(as.factor(dt3$acknowledgement)) 
summary(as.factor(dt3$acknowledgement_usage)) 
summary(as.factor(dt3$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.))
detach(dt3)               


inUrl4  <- "https://pasta.lternet.edu/package/data/eml/edi/1160/1/cdd0c7a4cac3f28d6d788c91f506775f" 
infile4 <- tempfile()
try(download.file(inUrl4,infile4,method="curl"))
if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")


dt4 <-read.csv(infile4,header=F 
               ,skip=1
               ,sep=";"  
               ,quot='"' 
               , col.names=c(
                 "ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.",     
                 "dataset_name",     
                 "dataset_type..paren.dataset_type.paren.",     
                 "curator_name",     
                 "curator_organization",     
                 "curator_email",     
                 "contact_name",     
                 "contact_email",     
                 "dataset_description",     
                 "total_scount",     
                 "total_pcount",     
                 "total_lcount",     
                 "soc_scount",     
                 "soc_pcount",     
                 "soc_lcount",     
                 "soc_scount_ISCN",     
                 "soc_pcount_ISCN",     
                 "soc_lcount_ISCN",     
                 "modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren."    ), check.names=TRUE)

unlink(infile4)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt4$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)!="factor") dt4$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.<- as.factor(dt4$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
if (class(dt4$dataset_name)!="factor") dt4$dataset_name<- as.factor(dt4$dataset_name)
if (class(dt4$dataset_type..paren.dataset_type.paren.)!="factor") dt4$dataset_type..paren.dataset_type.paren.<- as.factor(dt4$dataset_type..paren.dataset_type.paren.)
if (class(dt4$curator_name)!="factor") dt4$curator_name<- as.factor(dt4$curator_name)
if (class(dt4$curator_organization)!="factor") dt4$curator_organization<- as.factor(dt4$curator_organization)
if (class(dt4$curator_email)!="factor") dt4$curator_email<- as.factor(dt4$curator_email)
if (class(dt4$contact_name)!="factor") dt4$contact_name<- as.factor(dt4$contact_name)
if (class(dt4$contact_email)!="factor") dt4$contact_email<- as.factor(dt4$contact_email)
if (class(dt4$dataset_description)!="factor") dt4$dataset_description<- as.factor(dt4$dataset_description)
if (class(dt4$total_scount)!="factor") dt4$total_scount<- as.factor(dt4$total_scount)
if (class(dt4$total_pcount)!="factor") dt4$total_pcount<- as.factor(dt4$total_pcount)
if (class(dt4$total_lcount)!="factor") dt4$total_lcount<- as.factor(dt4$total_lcount)
if (class(dt4$soc_scount)!="factor") dt4$soc_scount<- as.factor(dt4$soc_scount)
if (class(dt4$soc_pcount)!="factor") dt4$soc_pcount<- as.factor(dt4$soc_pcount)
if (class(dt4$soc_lcount)!="factor") dt4$soc_lcount<- as.factor(dt4$soc_lcount)
if (class(dt4$soc_scount_ISCN)!="factor") dt4$soc_scount_ISCN<- as.factor(dt4$soc_scount_ISCN)
if (class(dt4$soc_pcount_ISCN)!="factor") dt4$soc_pcount_ISCN<- as.factor(dt4$soc_pcount_ISCN)
if (class(dt4$soc_lcount_ISCN)!="factor") dt4$soc_lcount_ISCN<- as.factor(dt4$soc_lcount_ISCN)
if (class(dt4$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)!="factor") dt4$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.<- as.factor(dt4$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.)

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt4)                            
attach(dt4)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)
summary(dataset_name)
summary(dataset_type..paren.dataset_type.paren.)
summary(curator_name)
summary(curator_organization)
summary(curator_email)
summary(contact_name)
summary(contact_email)
summary(dataset_description)
summary(total_scount)
summary(total_pcount)
summary(total_lcount)
summary(soc_scount)
summary(soc_pcount)
summary(soc_lcount)
summary(soc_scount_ISCN)
summary(soc_pcount_ISCN)
summary(soc_lcount_ISCN)
summary(modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.) 
# Get more details on character variables

summary(as.factor(dt4$ISCN.1.hyphen.1..paren.2015.hyphen.12.hyphen.10.paren.)) 
summary(as.factor(dt4$dataset_name)) 
summary(as.factor(dt4$dataset_type..paren.dataset_type.paren.)) 
summary(as.factor(dt4$curator_name)) 
summary(as.factor(dt4$curator_organization)) 
summary(as.factor(dt4$curator_email)) 
summary(as.factor(dt4$contact_name)) 
summary(as.factor(dt4$contact_email)) 
summary(as.factor(dt4$dataset_description)) 
summary(as.factor(dt4$total_scount)) 
summary(as.factor(dt4$total_pcount)) 
summary(as.factor(dt4$total_lcount)) 
summary(as.factor(dt4$soc_scount)) 
summary(as.factor(dt4$soc_pcount)) 
summary(as.factor(dt4$soc_lcount)) 
summary(as.factor(dt4$soc_scount_ISCN)) 
summary(as.factor(dt4$soc_pcount_ISCN)) 
summary(as.factor(dt4$soc_lcount_ISCN)) 
summary(as.factor(dt4$modification_date..paren.YYYY.hyphen.MM.hyphen.DD.paren.))
detach(dt4)               

dt2_relevant <- filter(dt2, country..paren.country.paren.=="Senegal")



