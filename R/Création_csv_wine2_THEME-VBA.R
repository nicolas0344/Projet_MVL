library(ade4)
library(readr)

###################################################################
data <- read.csv("wine.csv", sep = ",")

# a voir si on prend en compte le type de sol et le label 
a <- acm.disjonctif(data[,2:3])
wine2 <- cbind(data,a)

# dans le cas contraire 
wine2 <- data

#############################################################
#THEME odeur, arome, gout, note_gout, forme, composition

##odeur : 
odeur <- c("Odor.Intensity.before.shaking","Odor.Intensity","Quality.of.odour")

##arome : 
arome <- c("Aroma.quality.before.shaking","Aroma.intensity","Aroma.persistency","Aroma.quality")

##gout : 
gout <- c("Fruity.before.shaking","Fruity","Acidity","Spice.before.shaking","Spice")

##note_gout : 
note_gout <- c("Balance","Smooth","Bitterness","Attack.intensity","Intensity","Harmony","Typical")

##Forme : 
forme <- c("Flower.before.shaking","Visual.intensity","Nuance","Surface.feeling")

##composition : 
composition <- c("Astringency","Alcohol","Phenolic","Plante","Flower")

##Overall.quality n'est pas prit en compte dans le modele THEME 


VBA_THEME <- c("VBA_code") ## A adapter si on considere le type de sol et de label
for (i in colnames(wine2)[-1]){
  if (i %in% odeur){
    VBA_THEME <- c(VBA_THEME, 1)
  }
  else if  (i %in% arome){
    VBA_THEME <- c(VBA_THEME, 2)
  }
  else if (i %in% gout){
    VBA_THEME <- c(VBA_THEME, 3)
  }
  else if (i %in% note_gout){
    VBA_THEME <- c(VBA_THEME, 4)
  }
  else if(i %in% forme){
    VBA_THEME <- c(VBA_THEME, 5)
  }
  else if (i %in% composition){
    VBA_THEME <- c(VBA_THEME, 6)
  }
  else {
    VBA_THEME <- c(VBA_THEME, 0)
  }
}

wine2 <- rbind(wine2,VBA_THEME)
colnames(wine2)[1] <- "name"
rownames(wine2) <- wine2[,1]
write.table(wine2,"wine2.csv",sep = ';')