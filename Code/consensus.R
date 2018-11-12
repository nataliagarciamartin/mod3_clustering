library(ConsensusClusterPlus)
results = ConsensusClusterPlus(mad_gset, maxK=3, reps=1000, pItem=0.98, pFeature=1, distance="pearson", seed=5, clusterAlg="hc")
icl = calcICL(results)
icl[["clusterConsensus"]]
icl[["itemConsensus"]][1:5,]

sum(results[[3]]$consensusClass==1)/90
sum(results[[3]]$consensusClass==2)/90
sum(results[[3]]$consensusClass==3)/90

results[[3]]$consensusClass  # class results for 3 clusters


