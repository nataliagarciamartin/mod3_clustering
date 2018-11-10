
install.packages("cluster")
library(cluster)

data <- mad_gset
gap <- t(scale(t(data)))
gap <- t(gap) #transpose so we cluster the patients, not the genes

# Compute gap statistic
set.seed(123)
gap_stat <- clusGap(gap, FUN = kmeans, K.max = 5, B = 100)
# Plot gap statistic
x=1:5
plot(x,gap_stat$gap, type="b")
