###########################################################################"
library(readr)
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R")
wine2 <- read.csv("wine2.csv", sep = ";")


####Modele sans CV-backward
## Extraction des R2 de prediction
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_2eq/Model_2_2_3_3_2_2/R2")

R2_eq1 <- read.csv("R2_Eq1.csv", sep = ";")
R2_eq2 <- read.csv("R2_Eq2.csv", sep = ";")

## Extraction des coefficients de regression lineaire des var explicatives
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_2eq/Model_2_2_3_3_2_2/coefficients")

Beta_eq1_note_gout <- read.csv("Beta_Eq1_B4.csv", sep = ";")
Beta_eq1_forme <- read.csv("Beta_Eq1_B5.csv", sep = ";")
Beta_eq1_composition <- read.csv("Beta_Eq1_B6.csv", sep = ";")
cst_eq1 <- read.csv("Cste_Eq1.csv", sep = ";")

Beta_eq2_arome <- read.csv("Beta_Eq2_B2.csv", sep = ";")
Beta_eq2_gout <- read.csv("Beta_Eq2_B3.csv", sep = ";")
cst_eq2 <- read.csv("Cste_Eq2.csv", sep = ";")

Coeff_var_Eq1 <- rbind(cst_eq1,Beta_eq1_note_gout,Beta_eq1_forme,Beta_eq1_composition)
Coeff_var_Eq2 <- rbind(cst_eq2,Beta_eq2_arome,Beta_eq2_gout)

# write.table(Coeff_var_Eq1,"Coeff_var_Eq1.csv", sep = ";", row.names = F)
# write.table(Coeff_var_Eq2,"Coeff_var_Eq2.csv", sep = ";", row.names = F)

## Extraction des predictions des var des blocs odeur(Eq2) et gout(Eq1)
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_2eq/Model_2_2_3_3_2_2/Prediction")

Ypred_eq1 <- read.csv("Ypred_Eq1.csv", sep = ";")
Ypred_eq2 <- read.csv("Ypred_Eq2.csv", sep = ";")

##remplacer la virgule par un point dans un caractere
correction <- function(a){
  as.numeric(gsub(",", ".", gsub("\\."," ", a)))
}

PRESS_eq1 <- matrix(0,ncol = 5)
colnames(PRESS_eq1) <- colnames(Ypred_eq1)[-1]
for (j in colnames(PRESS_eq1)){
  for (i in 1:21){
    PRESS_eq1[,j] <- PRESS_eq1[,j] + (wine2[i,j] - correction(Ypred_eq1[i,j]))^2
  }
}

PRESS_eq2 <- matrix(0,ncol = 3)
colnames(PRESS_eq2) <- colnames(Ypred_eq2)[-1]
for (j in colnames(PRESS_eq2)){
  for (i in 1:21){
    PRESS_eq2[,j] <- PRESS_eq2[,j] + (wine2[i,j] - correction(Ypred_eq2[i,j]))^2
  }
}

#### Modele avec CV backward
## Extraction des R2 de prediction
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_CROSS/Model_2_2_0_3_2_2/R2")

R2_cross <- read.csv("R2_Eq1.csv", sep = ";")

## Extraction des coefficients de regression lineaire des var explicatives
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_CROSS/Model_2_2_0_3_2_2/coefficients")

Beta_cross_arome <- read.csv("Beta_Eq1_B2.csv", sep = ";")
Beta_cross_note_gout <- read.csv("Beta_Eq1_B4.csv", sep = ";")
Beta_cross_forme <- read.csv("Beta_Eq1_B5.csv", sep = ";")
Beta_cross_composition <- read.csv("Beta_Eq1_B6.csv", sep = ";")
cst_cross <- read.csv("Cste_Eq1.csv", sep = ";")

Coeff_var_cross <- rbind(cst_cross,Beta_cross_arome,Beta_cross_note_gout,Beta_cross_forme,Beta_cross_composition)

# write.table(Coeff_var_cross,"Coeff_var_cross.csv", sep = ";", row.names = F)
