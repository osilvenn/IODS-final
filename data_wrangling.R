# Olli Silvennoinen
# Data wrangling for the final project of the IODS course

# Read the data file into R
cn <- read.table("/Users/ollisilvennoinen/OneDrive - University of Helsinki/data_art2_FINAL2.csv", sep = ";", header = TRUE)
str(cn)
dim(cn)

# Change the level names and reference levels
levels(cn$ConstructionType)
library(plyr)
cn$ConstructionType <- mapvalues(cn$ConstructionType, from = c("fin", "finand", "fincla", "ini", "iniasy", "inicla"), to = c("X_notY", "X_andnotY", "Exp_AffNeg", "notX_butY", "notX_Y", "Exp_NegAff"))
cn$SemType <- relevel(cn$SemType, ref = "rep")
cn$Mode <- relevel(cn$Mode, ref = "Written")
cn$NegGiven <- relevel(cn$NegGiven, ref = "n")

# Save this as a new file
write.table(cn, file = "/Users/ollisilvennoinen/OneDrive - University of Helsinki/cn_data_2017-02-20.txt", quote = FALSE, sep = ",", row.names = FALSE)
