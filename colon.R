##################################################################

# Load gene expression data

load("Data/gset.RData")

# Read in data using only 146 significant genes

pamoutput <- read.csv("Data/desousaemelo_146genes_pam.csv", header = TRUE)
