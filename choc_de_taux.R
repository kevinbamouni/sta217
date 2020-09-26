library(FactoMineR)
library(RcppRoll)
library(factoextra)
library(ggplot2)
library(reshape2)
#########################################################################################################
# Lecture des données de variation de la courbe de taux
data <- read.csv("data/GLC_Nominal_daily_data_2005_to_2020_return.csv", header=TRUE, sep = ";", dec = ",")

# Représentation des données :
data_plot =  melt(data[,1:21])
ggplot(data_plot, aes(DATE, value, group=variable, color=variable)) + geom_line(show.legend = TRUE)

# Elimination de la colonne date pour ne traiter que les taux de return
data.active = data.matrix(data[,2:21])

# Annualisation des données journalières puis on centre et réduction des données
data.active = apply(X = data.active+1, 2,  RcppRoll::roll_prod, n=250)-1
data.active = scale(data.active)

# Pour visualiser les niveaux de variances explliqués
res.pca <- PCA(data.active, scale.unit = FALSE, ncp = 4, graph = TRUE)
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))
get_eigenvalue(res.pca)

# Choix du nombre de composantes principales / suite aux résultats de l'ACP donnant les nivaux de variance explique par chaque composante
n_pc = 3

# Valeurs propres et vecteurs propres des donnees originales annualisees
vectval_propres = eigen(cov(data.active))

vect_propre = vectval_propres$vectors[,1:n_pc]
colnames(vect_propre) <- c('level', 'slope', 'curvature')
vect_propre = as.data.frame(vect_propre)

val_propre = vectval_propres$values[1:n_pc]

# Plot des valeurs propres et des vecteurs propres
vect_propre_plot = vect_propre
vect_propre_plot$maturite=c(1:ncol(data.active))
ggplot(vect_propre_plot) + 
  geom_line(aes(x = maturite, y = level,  color = "red")) + geom_point(aes(x = maturite, y = level, color = "red")) +
  geom_line(aes(x = maturite, y = slope, color = "blue")) + geom_point(aes(x = maturite, y = slope, color = "blue")) +
  geom_line(aes(x = maturite, y = curvature, color = "green")) + geom_point(aes(x = maturite, y = curvature, color = "green")) +
  scale_color_manual(labels = c("level", "slope", "curvature"), values = c("red", "blue", "green")) + 
  labs(title = "COMPOSANTES PRINCIPALES", x = "Maturites", y ="Valeurs")
theme_bw() + guides(color=guide_legend("Axes principaux"))

#  Choc des composantes principales : Value at risk
pc_shoc_up = vect_propre * (sqrt(val_propre) * qnorm(.995, mean = 0, sd = 1))
pc_shoc_down = vect_propre * (sqrt(val_propre) * qnorm(1-0.995, mean = 0, sd = 1))


pc_shoc_up$level*.08354 + pc_shoc_up$slope*.0991 + pc_shoc_up$curvature*.052

data.active[nrow(data.active),] %*% vect_propre$level
data.active[nrow(data.active),] %*% vect_propre$slope
data.active[nrow(data.active),] %*% vect_propre$curvature
