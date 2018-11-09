








# Filter out genes which are not highly expressed

#https://www.bioconductor.org/packages/devel/workflows/vignettes/RnaSeqGeneEdgeRQL/inst/doc/edgeRQL.html#filtering-to-remove-low-counts

library(edgeR)
y <- DGEList(gset,
             genes=gset[,1,drop=FALSE])
options(digits=3)
y$samples
dim(y)
library(org.Mm.eg.db)
y$genes$Symbol <- mapIds(org.Mm.eg.db, rownames(y),
                         keytype="ENTREZID", column="SYMBOL")
head(y$genes)
keep <- filterByExpr(y)
table(keep)
y <- y[keep, , keep.lib.sizes=FALSE]
dim(y)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("genefilter", version = "3.8")

x=as.matrix(y$counts)
nrow(x)

variability <- numeric(nrow(x))
for (i in 1:nrow(x)){
  variability[i] <- mad(x[i,])
}

summary(variability)



sum(variability>71)

hist(variability, breaks=20)

installed.packages("StabPerf")
library(StabPerf)
smad(x)


#####
gset
variability2 <- numeric(nrow(gset))
for (i in 1:nrow(gset)){
  variability2[i] <- mad(gset[i,])
}

summary(variability2)
hist(variability2, breaks=30)
sum(variability2>75)


###


installed.packages("marray")
library(marray)

#maNormMAD(x=NULL, y="maM", geo=TRUE, subset=TRUE)
maNormMain(x)


###

