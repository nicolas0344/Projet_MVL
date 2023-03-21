library(ade4)
library(readr)

data <- read.csv("wine.csv", sep = ",")
a <- acm.disjonctif(data[,2:3])
wine2 <- cbind(data,a)
VBA_THEME <- c("VBA_code",sample(c(0,1,2),length(wine2), replace = T))
wine2 <- rbind(wine2,VBA_THEME)
colnames(wine2)[1] <- "name"
rownames(wine2) <- wine2[,1]
write.table(wine2,"wine2.csv",sep = ';')