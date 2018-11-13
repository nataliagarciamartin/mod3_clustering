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



install.packages('clues')


library(clues)


#Computing the Adjusted Rand Index between PAM cluster and hc consensus clusters

adjustedRand(labels, as.vector(my_y_hat)) #0.8947617

#We make use of HA