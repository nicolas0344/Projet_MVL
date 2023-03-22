###########################################################################"
library(readr)

## Extraction des R2 de prediction
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_225046/Model_2_2_3_3_2_2/R2")

R2_eq1 <- read.csv("R2_Eq1.csv", sep = ";")
R2_eq2 <- read.csv("R2_Eq2.csv", sep = ";")
View(R2_eq2)

## Extraction des coefficients de regression lineaire des var explicatives
setwd("/Users/Nicolas/OneDrive/Documents/Cours S10/AMV/Projet_MVL/R/THEME_225046/Model_2_2_3_3_2_2/coefficients")


