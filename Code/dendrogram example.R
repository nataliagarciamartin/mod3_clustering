samp <- sample(15)
xsamp <- x146[,samp]
d <- dist(t(xsamp), method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
htest <- hclust(d, method = "average")
plot(htest, xlab = "")
