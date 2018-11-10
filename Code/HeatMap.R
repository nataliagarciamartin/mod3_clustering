#https://www.biostars.org/p/286187/

source("http://bioconductor.org/biocLite.R")
biocLite("ComplexHeatmap")
library(ComplexHeatmap)

require(ComplexHeatmap)
require(circlize)
require(cluster)

#Note: split is used to reorder cluster in order to replicate figure 1.b from the paper

data <- x146
heat <- t(scale(t(data)))

heat <- t(heat) #transpose so we cluster the patients, not the genes



#k means
kclus <- kmeans(heat, 3)
kclus$cluster

split <- paste0("Cluster\n", kclus$cluster)

default.hmap <- Heatmap(heat, split=split)
split <- factor(paste0("Cluster\n", kclus$cluster), levels=c("Cluster\n3","Cluster\n1","Cluster\n2"), labels = c("CCS3", "CCS2", "CCS1"))
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



#k medoids: PAM (Partitioning Around Medoids, (Kaufman and Rousseeuw 1990))
kclus <- pam(heat, 3)
kclus$cluster

split <- paste0("Cluster\n", kclus$cluster)

default.hmap <- Heatmap(heat, split=split)
split <- factor(paste0("Cluster\n", kclus$cluster), levels=c("Cluster\n3","Cluster\n1","Cluster\n2"), labels = c("CCS3", "CCS2", "CCS1"))
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



#hierarchical
d <-dist(heat, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
hclus <- hclust(d)
groups<-cutree(hclus, k=3)

split <- paste0("Cluster\n", groups)

default.hmap <- Heatmap(heat, split=split)
split <- factor(paste0("Cluster\n", groups), levels=c("Cluster\n3","Cluster\n1","Cluster\n2"), labels = c("CCS3", "CCS2", "CCS1"))
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
