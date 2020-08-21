
# Retraitement des données de mortalités avant calcul des probabilités de décès
# Ceci dans l'objectif d'homogénéiser les données
df = fra_mortality
df = df[df$Year1 < 1998,]

df_fra <- data.frame(c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95))
colnames(df_fra) <- c("Age")

for (i in 1:length(unique(df$Year1))){
  df_fra[paste(unique(df$Year1)[i])] <- df[df$Sex==2 & df$Ref.ID=="1303.1" & is.element(df$TypeLT,c(2)) & is.element(df$Age, c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95)) & df$Year1 == unique(df$Year1)[i], "l.x."]
}

df = fra_mortality
df = df[df$Year1 > 1997,]

for (i in 1:length(unique(df$Year1))){
  df_fra[paste(unique(df$Year1)[i])] <- df[df$Sex==2 & is.element(df$Ref.ID,c("1567.04","1567.03","1567.02","1656.01","1656.02","1656.03","1656.04","1656.05","1656.06","1567.01","1656.07","1765.01","3201.03","1854.01","3201.01","1855.01","3201.04","3201.02","3201.05","3201.06")) & is.element(df$TypeLT,c(2)) & is.element(df$Age, c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95)) & df$Year1 == unique(df$Year1)[i], "l.x."]
}

for (i in 1:length(c(2014,2015))){
  df_fra[paste(c(2014,2015)[i])] <- df[df$Sex==2 & is.element(df$Ref.ID,c("3201.05","3201.06")) & is.element(df$TypeLT,c(4)) & is.element(df$Age, c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95)) & df$Year1 == c(2014,2015)[i], "l.x."]
}

write.csv(df_fra,'/data/df_fra.csv', row.names = FALSE)