##################################################################

# Load gene expression data

load("Data/frma_gset.RData") # Full data after processing via fRMA
load("Data/affset_sub.RData") # Subset of data after application of the barcode algorithm
load("Data/mad_gset.RData") # Subset of barcode_sub after assessing median absolute deviance

# Read in data using only 146 significant genes

pamoutput <- read.csv("Data/desousaemelo_146genes_pam.csv", header = TRUE)

# Subset with 146 genes

x146<- frma_gset[as.character(pamoutput$identifier),]
x146 <- as.matrix(x146)
save(x146, file = "Data/x146.RData")

for (i in 1:nrow(x146)){
  
  x146[i,] <- x146[i,] - median(x146[i,])
  
}