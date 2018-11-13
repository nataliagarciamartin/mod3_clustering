library(cluster)

# Select which data

data <- affset_sub
data <- t(data) #transpose so we cluster the patients, not the genes

# Select clustering strategy and create function if necessary 
# Some function such as kmeans give automatically the assigned cluster list, for others we need additional steps

kmeans

pam1 <- function(x, k){list(cluster = pam(x, k, cluster.only = TRUE))} 

hier <- function(x, k){
d <- dist(x)
hclus <- hclust(d)
groups <- cutree(hclus, k = k)
groups <- list(cluster = groups)
}

# Compute gap statistic

set.seed(123)

gap_stat <- clusGap(data, FUN = hier, K.max = 15, B = 100)

# Plot gap statistic

x <- 2:15
gap <- gap_stat$Tab[,3][2:15]
gap_norm <- gap/ gap_stat$Tab[,3][2]
plot(x, gap_norm, type = "b", xlab = "Number of Clusters", ylab="Gap Statistic", main = "Gap Statistic for Different Cluster Sizes") 
     
# Hierarchical clustering

dmat <- dist(t(mad_gset)) # mad_gset is data in this script
htest <- hclust(dmat, method = "average")
plot(htest)
