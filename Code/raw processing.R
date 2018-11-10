##### Data Sourcing and Pre-processing ###########

source("http://bioconductor.org/biocLite.R")

# Install affy from bioconductor
biocLite("affy")
library(affy)

# Import .CEL files as an AffyBatch; need .CEL files in current working directory
affset <- ReadAffy()

# Perform fRMA to obtain gene expressions
fraffset <- frma(affset)

# Extract the gene expressions
newaffset <- exprs(fraffset)
head(newaffset)
dim(newaffset)

# Remove the healthy individuals
healthy2 <- c("GSM1100477_COL_27.CEL.gz", "GSM1100478_COL_28.CEL.gz", "GSM1100479_COL_29.CEL.gz", "GSM1100480_COL_30.CEL.gz", "GSM1100481_COL_31.CEL.gz", "GSM1100482_COL_32.CEL.gz")
newaffset <- newaffset[,!(colnames(newaffset) %in% healthy2)]

frma_gset <- newaffset
save(frma_gset, file = "frma_gset.RData")

# Install required data files for barcode
biocLite("hgu133afrmavecs")
biocLite("hgu133plus2frmavecs")

library(hgu133afrmavecs)
library(hgu133plus2frmavecs)

# Run barcode algorithm
newbarcode <- barcode(newaffset, platform = "GPL570")

# Check which genes are fully unexpressed and remove them
nbcode_gset <- rowSums(newbarcode)
sum(nbcode_gset == 0)

remove <- c(nbcode_gset != 0)
barcode_sub <- newbarcode[remove,]
dim(barcode_sub)

save(barcode_sub, file = "barcode_sub.RData")

# Assess median absolute deviation

affset_sub <- newaffset[remove,]
dim(affset_sub)

variability2 <- rep(0, nrow(affset_sub))
for (i in 1:nrow(affset_sub)){
  variability2[i] <- mad(affset_sub[i,])
}

sum(variability2 > 0.5)
