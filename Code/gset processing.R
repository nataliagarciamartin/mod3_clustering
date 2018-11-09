##### Data Sourcing and Pre-processing ###########
library(Biobase)
library(GEOquery)

# Load series and platform data from GEO
gset <- getGEO("GSE33113")[[1]]

# Remove healthy patients from data
healthy <- c("GSM1100477", "GSM1100478", "GSM1100479", "GSM1100480", "GSM1100481", "GSM1100482")
gset <- gset[,!(sampleNames(gset) %in% healthy)]

# Extract gene expression information
gset <- exprs(gset)

# Check first 5 genes for 4 subjects
gset[1:5,1:4]

# Save as .RData

save(gset, file = "gset.RData")



