# Plot le graphique des densités d'un dataset
# dataf : données en input
# age :age pour lequel il faut le graphique
plotagedensite <- function(dataf, age){
  
  dataf <- dataf %>% filter(Age %in% c(age))
#  p6 <- ggplot(dataf, aes(value)) +
#    geom_histogram( bins = 50, color="darkblue", fill="white") +
#    xlab("taux d'évolution") + ylab("Nombre d'occurrence") + ggtitle("Histogramme des taux d'évolution de la longévité") +
#    theme_classic()
  
  p7 <- ggplot(dataf, aes(value)) +
    geom_density(color="aquamarine2", fill = "aquamarine2", alpha = 0.1) +
    stat_function(fun = dnorm, args = list(mean(dataf$value), sd(dataf$value)), color = "brown") +
    geom_vline(xintercept = mean(dataf$value), colour = "#FF3721", linetype = "dashed") +
    xlab("taux d'évolution") + ylab("frequence en %") + 
    theme_classic()
  
  return(plot_grid(p7))
}

# Calcul l'Expected Shortfall
# df : vecteur des rendements ou tout simplement les données en input
# qtle : quantile
# ct : sens de calcul de l'ES ">=" ou "<="
calcul_es <- function(df, qtle, ct){
  
  if (ct==">="){
    a <-  round(mean(df[df>=qtle]), 4)
  }
  if (ct=="<="){
    a <-  round(mean(df[df<=qtle]), 4)
  }
  
  return(a)
}

# Calcul de la matrice des improvments de la mortalité au fil des années.
qx_return <- function(df){
  a <- df
  a[,c("1993" ,"1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009")] <- 
    (df[,c("1993" ,"1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009")] -
       df[,c("1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008")]) /
    df[,c("1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008")]
  
  return(a[,c("Age","1993" ,"1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009")])
}