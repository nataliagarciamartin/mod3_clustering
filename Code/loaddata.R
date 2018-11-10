##################################################################

# Load gene expression data

load("Data/frma_gset.RData")
load("Data/barcode_sub.RData")

# Read in data using only 146 significant genes

pamoutput <- read.csv("Data/desousaemelo_146genes_pam.csv", header = TRUE)

# Subset with 146 genes

x146<- gset[as.character(pamoutput$identifier),]
x146 <- as.data.frame(x146)
save(x146, file = "Data/x146.RData")

