#https://www.biostars.org/p/286187/

source("http://bioconductor.org/biocLite.R")
biocLite("ComplexHeatmap")
library(ComplexHeatmap)
library(gplots)
require(ComplexHeatmap)
require(circlize)
require(cluster)

heat=t(x146)

# Code to produce heatmap with 90 patients and 146 classifying genes 

#hierarchical

d <-dist(heat, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
hclus <- hclust(d, method="average")
groups<-cutree(hclus, k=3) # output labels from hierarchical clustering

#hierarchical with consensus 

heat=t(x146)
results = ConsensusClusterPlus(mad_gset, maxK=10, reps=1000, pItem=0.98, pFeature=1, distance="pearson", seed=5, clusterAlg="hc",plot="pdf")
groups <- results[[3]]$consensusClass

# plot heatmap

split <- paste0("Cluster\n")
split <- factor(paste0("Cluster\n", groups), levels=c("Cluster\n3","Cluster\n2","Cluster\n1"), labels = c("CCS3", "CCS2", "CCS1"))
reorder.hmap <- Heatmap(heat, split=split,
                        name="Transcript Z-score",
                        col = colorRamp2(c(-1.5, 0, 1.5), c("blue", "white", "orange")),
                        heatmap_legend_param=list(color_bar="continuous", legend_direction="horizontal", legend_width=unit(3,"cm"), title_position="topcenter", title_gp=gpar(fontsize=10)),
                        row_title="Transcript class",
                        row_title_side="left",
                        row_title_gp=gpar(fontsize=10),
                        show_row_names=FALSE,
                        column_title="",
                        column_title_side="bottom",
                        column_title_gp=gpar(fontsize=10),
                        column_title_rot=0,
                        show_column_names=FALSE,
                        clustering_distance_columns=function(x) as.dist(1-cor(t(x))),
                        clustering_method_columns="ward.D2",
                        clustering_distance_rows="euclidean",
                        clustering_method_rows="ward.D2",
                        row_dend_width=unit(30,"mm"),
                        column_dend_height=unit(30,"mm"))
draw(reorder.hmap)

# produce a different layout using heatmap.2

quantile.range <- quantile(x146, probs = seq(0, 1, 0.01))
palette.breaks <- seq(quantile.range["5%"], quantile.range["95%"], 0.1)
heatmap.2(x146, breaks=palette.breaks, col=colorRampPalette(c("blue", "white", "orange"))(length(palette.breaks) - 1), trace="none", ColSideColors=patientcolors)


