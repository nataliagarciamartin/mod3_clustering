
install.packages("cluster")
library(cluster)

# Select which data

data <- mad_gset # final 8000
data <- gset # all data
data <- t(scale(t(data))) #mad data already normalised but gset data is not
data <- t(data) #transpose so we cluster the patients, not the genes

# Select clustering strategy and create function if necessary 
# Some function such as kmeans give automatically the assigned cluster list, for others we need additional steps

kmeans

pam1 <- function(x, k){list(cluster = pam(x,k, cluster.only=TRUE))} 

hier <- function(x, k){
d <-dist(x, method = "average", diag = FALSE, upper = FALSE, p = 2)
hclus <- hclust(d)
groups<- cutree(hclus, k=k)
groups$cluster <- groups
groups <- as.list(groups)
}

# Compute gap statistic

set.seed(123)
gap_stat <- clusGap(data, FUN = hier, K.max = 5, B = 10)

# Plot gap statistic

x=1:5
gap <- gap_stat$Tab[,3]
plot(x, gap, type="b", xlab="Number of clusters", ylab="Gap statistic") #+ geom_line() + geom_point(size=5) + geom_errorbar(aes(ymax=gap+gap_stat$Tab[,4], ymin=gap-gap_stat$Tab[,4]))

     
# Hierarchical clustering

dmat <- dist(t(mad_gset)) # mad_gset is data in this script
htest <- hclust(dmat, method = "average")
plot(htest)