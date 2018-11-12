#Consensus Clustering


source("http://bioconductor.org/biocLite.R")

biocLite("ConsensusClusterPlus")

library(ConsensusClusterPlus)
results = ConsensusClusterPlus(mad_gset, maxK=3, reps=1000, pItem=0.98, pFeature=1, distance="pearson", seed=5, clusterAlg="hc")
icl = calcICL(results)  
icl[["clusterConsensus"]]
icl[["itemConsensus"]][1:5,]

sum(results[[3]]$consensusClass==1)/90
sum(results[[3]]$consensusClass==2)/90
sum(results[[3]]$consensusClass==3)/90

labels = results[[3]]$consensusClass  # class results for 3 clusters


# PAM Classifier

# PAM

#install package from zip file

#library(pamr)

# For Interactive analysis, use:
#pamr.menu(mad_gset)


#Non-interactive analysis

## Train the classifier
x = mad_gset
y = labels

my_mad_gset = list(x=x, y = factor(y))

gset.train <- pamr.train(my_mad_gset)

#Results of gset.train

gset.train


## Cross-validate the classifier
# pamr carries out cross-validation for a nearest shrunken centroid classifier.
gset.train.cv<- pamr.cv(gset.train, my_mad_gset)

#View cross-validation results

gset.train.cv

# Plotting the cross-validated error curves

pamr.plotcv(gset.train.cv)

# Make a gene plot of the most significant genes

pamr.geneplot(gset.train, my_mad_gset, threshold=5.3)

#List the most significant genes
pamr.listgenes(gset.train,  my_mad_gset, threshold=3.0, genenames = T)
