###########################################################################"
library(readr)

## Extraction des R2 de prediction
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_225046/Model_2_2_3_3_2_2/R2")

R2_eq1 <- read.csv("R2_Eq1.csv", sep = ";")
R2_eq2 <- read.csv("R2_Eq2.csv", sep = ";")

View(R2_eq2)

## Extraction des coefficients de regression lineaire des var explicatives
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_225046/Model_2_2_3_3_2_2/coefficients")

Beta_eq1_note_gout <- read.csv("Beta_Eq1_B4.csv", sep = ";")
Beta_eq1_forme <- read.csv("Beta_Eq1_B5.csv", sep = ";")
Beta_eq1_composition <- read.csv("Beta_Eq1_B6.csv", sep = ";")
cst_eq1 <- read.csv("Cste_Eq1.csv", sep = ";")

Beta_eq2_arome <- read.csv("Beta_Eq2_B2.csv", sep = ";")
Beta_eq2_gout <- read.csv("Beta_Eq2_B3.csv", sep = ";")
cst_eq2 <- read.csv("Cste_Eq2.csv", sep = ";")

View(Beta_eq2_arome)

## Extraction des predictions des var des blocs odeur(Eq2) et gout(Eq1)
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_225046/Model_2_2_3_3_2_2/Prediction")

Ypred_eq1 <- read.csv("Ypred_Eq1.csv", sep = ";")
Ypred_eq2 <- read.csv("Ypred_Eq2.csv", sep = ";")

View(Ypred_eq2)

