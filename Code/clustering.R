library(ConsensusClusterPlus)

# Consensus with hierarchical

title=tempdir()

results = ConsensusClusterPlus(mad_gset, maxK=3, reps=1000, pItem=0.98, pFeature=1, distance="pearson", seed=5, clusterAlg="hc",plot="pdf")
results[[3]]$consensusClass  # class results for 3 clusters


# Consensus with k means

results2 = ConsensusClusterPlus(mad_gset, maxK=3, reps=1000, pItem=0.98, pFeature=1, distance="Euclidean", seed=5, clusterAlg="km",plot="pdf")
results2[[3]]$consensusClass  # class results for 3 clusters



# Hierarchical

d <-dist(t(x146), method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
hclus <- hclust(d)
groups<-cutree(hclus, k=3) 

#htest <- hclust(d, method = "average")
#plot(htest)


# K means

kclus <- kmeans(heat, 3)
kclus$cluster
