##################################################################

# Load gene expression data

load("gset.RData")

# Read in data using only 146 significant genes

pamoutput <- read.csv("desousaemelo_146genes_pam.csv", header = TRUE)
