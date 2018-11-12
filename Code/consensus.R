library(ConsensusClusterPlus)

title=tempdir()
results = ConsensusClusterPlus(mad_gset, maxK=10, reps=1000, pItem=0.98, pFeature=1, distance="pearson", seed=5, clusterAlg="hc",plot="pdf")
icl = calcICL(results)
icl[["clusterConsensus"]]
icl[["itemConsensus"]][1:5,]

sum(results[[3]]$consensusClass==1)/90
sum(results[[3]]$consensusClass==2)/90
sum(results[[3]]$consensusClass==3)/90

results[[3]]$consensusClass  # class results for 3 clusters


# Note: the output plots are automatically saved as a pdf "consensus.pdf" in the "untitled_consensus_cluster" folder