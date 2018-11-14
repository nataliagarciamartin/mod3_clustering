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



# Consensus with k means

results2 = ConsensusClusterPlus(mad_gset, maxK=3, reps=1000, pItem=0.98, pFeature=1, distance="euclidean", seed=5, clusterAlg="km",plot="pdf")
groups_k_con = results2[[3]]$consensusClass  # class results for 3 clusters



# Hierarchical clustering without consensus 

d <-dist(t(mad_gset), method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
hclus <- hclust(d)
groups_hc<-cutree(hclus, k=3)  #clusters from hc wthout consensus

#htest <- hclust(d, method = "average")
#plot(htest)


# K means without consensus 

kclus <- kmeans(t(mad_gset), 3)
groups_k = kclus$cluster       # clusters from k wthout consensus




#Calculating ARI between different clustering methods

install.packages('clues')


library(clues)

#Computing the Adjusted Rand Index between hc clusters with and without consensus
 
adjustedRand(labels, groups_hc) # 0.6462908


#Computing the Adjusted Rand Index between k mean clusters with and without consensus

adjustedRand(groups_k, groups_k_con) # 1   perfect! no change with consensus.


#Computing the Adjusted Rand Index between PAM clusters and hc consensus clusters

adjustedRand(labels, pamr_predictions) #0.8947617

#We make use of HA

#Computing the Adjusted Rand Index between PAM clusters and hc without consensus clusters

adjustedRand(groups_hc, pamr_predictions) #0.5984025


#Computing the Adjusted Rand Index between PAM clusters and k means with consensus clusters

adjustedRand(groups_k_con, pamr_predictions) #0.8028830





