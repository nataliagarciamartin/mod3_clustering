##### Data Sourcing and Pre-processing ###########

source("http://bioconductor.org/biocLite.R")
biocLite("GEOquery")

library(GEOquery)

# Load series and platform data from GEO
gset <- getGEO("GSE33113")[[1]]

# Remove healthy patients from data
healthy <- c("GSM1100477", "GSM1100478", "GSM1100479", "GSM1100480", "GSM1100481", "GSM1100482")
gset <- gset[,!(sampleNames(gset) %in% healthy)]

# Install frma packages

biocLite("frma")
biocLite("hgu133afrmavecs")

library(frma)
library(hgu133afrmavecs)

# Run barcode algorithm

barcode <- barcode(gset, platform = "GPL570")
barcode <- exprs(barcode)

# Save as .RData

save(barcode, file = "Data/gset.RData")