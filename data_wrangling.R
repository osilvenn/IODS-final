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
cn$Negator <- relevel(cn$Negator, ref = "not")

# Turn length difference into a categorical variable
bins <- quantile(cn$LogLengthDiff)
bins
cn$LengthDiff <- cut(cn$LogLengthDiff, breaks = bins, include.lowest = TRUE, label = c("low", "med_low", "med_high", "high"))
table(LengthDiff) # this variable has four levels, as specified on the line above

# Create a binary variable on negators
levels(cn$Negator)
library(forcats)
cn$Neg <- fct_collapse(cn$Negator, no = c("bynomeans", "neither", "never", "no", "nobody", "nolonger", "none", "noone", "nor", "nothing", "nowt"))
levels(cn$Neg) # this variable now has two levels, "not" and "no"

# Exclude unneeded columns
library(dplyr)
keep_columns <- c("ConstructionType", "Neg", "SemType", "LengthDiff", "NegType", "NegGiven", "NegFocusCx", "Genre")
cn2 <- select(cn, one_of(keep_columns))
str(cn2)

# Saving this dataset onto my computer
write.csv(cn2, "/Users/ollisilvennoinen/OneDrive - University of Helsinki/cn2.csv", col.names = TRUE)

