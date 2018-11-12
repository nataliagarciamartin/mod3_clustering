library(ConsensusClusterPlus)
title=tempdir()
results = ConsensusClusterPlus(mad_gset,maxK=3,reps=50,pItem=0.8,pFeature=1,distance="pearson",seed=5)
                           #   + title=title,clusterAlg="hc",distance="pearson",seed=1262118388.71279,plot="png")
#consensusTree - hclust object
results[[2]][["consensusTree"]]
#ml - consensus matrix result
#clrs - colors for cluster
icl = calcICL(results,title=title,plot="png")
icl[["clusterConsensus"]]
icl[["itemConsensus"]][1:5,]

sum(results[[3]]$consensusClass==1)/90
sum(results[[3]]$consensusClass==2)/90
sum(results[[3]]$consensusClass==3)/90

results[[3]]$consensusClass



# check if it matches the plot 

results = ConsensusClusterPlus(x146, ,maxK=3,reps=50,pItem=0.8,pFeature=1)
#    + title=title,clusterAlg="hc",distance="pearson",seed=1262118388.71279,plot="png")
#consensusTree - hclust object
results[[2]][["consensusTree"]]
#ml - consensus matrix result
#clrs - colors for cluster
icl = calcICL(results,title=title,plot="png")
icl[["clusterConsensus"]]
icl[["itemConsensus"]][1:5,]

sum(results[[3]]$consensusClass==1)/90
sum(results[[3]]$consensusClass==2)/90
sum(results[[3]]$consensusClass==3)/90