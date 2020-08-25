# Mortality data wrangling !!!
# Lecture des données de table de mortalité des 9 pays récupérées dans la base 
# The Human Mortality Database : https://www.mortality.org/ (Un id et un mot de passe ont été créés pour avoir l'accès aux données)

DEN <- read.table("data/DEN.txt", header = TRUE)[,c("Year","Age","qx")]
FR <- read.table("data/FR.txt", header = TRUE)[,c("Year","Age","qx")]
EST <- read.table("data/EST.txt", header = TRUE)[,c("Year","Age","qx")]
HUN <- read.table("data/HUN.txt", header = TRUE)[,c("Year","Age","qx")]
IT <- read.table("data/IT.txt", header = TRUE)[,c("Year","Age","qx")]
POL <- read.table("data/POL.txt", header = TRUE)[,c("Year","Age","qx")]
SWE <- read.table("data/SWE.txt", header = TRUE)[,c("Year","Age","qx")]
ENGW <- read.table("data/ENGW.txt", header = TRUE)[,c("Year","Age","qx")]
CZE <- read.table("data/CZE.txt", header = TRUE)[,c("Year","Age","qx")]

DEN <- DEN[is.element(DEN$Year,c(1992:2009)),]
FR <- FR[is.element(FR$Year,c(1992:2009)),]
EST <- EST[is.element(EST$Year,c(1992:2009)),]
HUN <- HUN[is.element(HUN$Year,c(1992:2009)),]
IT <- IT[is.element(IT$Year,c(1992:2009)),]
POL <- POL[is.element(POL$Year,c(1992:2009)),]
SWE <- SWE[is.element(SWE$Year,c(1992:2009)),]
ENGW <- ENGW[is.element(ENGW$Year,c(1992:2009)),]
CZE <- CZE[is.element(CZE$Year,c(1992:2009)),]

DEN_reshape <- reshape(DEN, direction = "wide", idvar = "Age", timevar = "Year")
FR_reshape <- reshape(FR, direction = "wide", idvar = "Age", timevar = "Year")
EST_reshape <- reshape(EST, direction = "wide", idvar = "Age", timevar = "Year")
HUN_reshape <- reshape(HUN, direction = "wide", idvar = "Age", timevar = "Year")
IT_reshape <- reshape(IT, direction = "wide", idvar = "Age", timevar = "Year")
POL_reshape <- reshape(POL, direction = "wide", idvar = "Age", timevar = "Year")
SWE_reshape <- reshape(SWE, direction = "wide", idvar = "Age", timevar = "Year")
ENGW_reshape <- reshape(ENGW, direction = "wide", idvar = "Age", timevar = "Year")
CZE_reshape <- reshape(CZE, direction = "wide", idvar = "Age", timevar = "Year")

names(DEN_reshape) <- gsub("qx.", "", names(DEN_reshape))
names(FR_reshape) <- gsub("qx.", "", names(FR_reshape))
names(EST_reshape) <- gsub("qx.", "", names(EST_reshape))
names(HUN_reshape) <- gsub("qx.", "", names(HUN_reshape))
names(IT_reshape) <- gsub("qx.", "", names(IT_reshape))
names(POL_reshape) <- gsub("qx.", "", names(POL_reshape))
names(SWE_reshape) <- gsub("qx.", "", names(SWE_reshape))
names(ENGW_reshape) <- gsub("qx.", "", names(ENGW_reshape))
names(CZE_reshape) <- gsub("qx.", "", names(CZE_reshape))

DEN_reshape <- qx_return(DEN_reshape)
FR_reshape <- qx_return(FR_reshape)
EST_reshape <- qx_return(EST_reshape)
HUN_reshape <- qx_return(HUN_reshape)
IT_reshape <- qx_return(IT_reshape)
POL_reshape <- qx_return(POL_reshape)
SWE_reshape <- qx_return(SWE_reshape)
ENGW_reshape <- qx_return(ENGW_reshape)
CZE_reshape <- qx_return(CZE_reshape)
