
#https://www.biostars.org/p/286187/

source("http://bioconductor.org/biocLite.R")
biocLite("ComplexHeatmap")
library(ComplexHeatmap)
  
require(ComplexHeatmap)
require(circlize)
require(cluster)

df <- gset[1:100,1:90]

heat <- t(scale(t(df[,3:ncol(df)])))

hmap <- Heatmap(heat,
                name="Transcript Z-score",
                #col=colorRamp2(myBreaks, myCol),
                heatmap_legend_param=list(color_bar="continuous", legend_direction="horizontal", legend_width=unit(5,"cm"), title_position="topcenter", title_gp=gpar(fontsize=15, fontface="bold")),
                #split=df$Family,
                row_title="Transcript class",
                row_title_side="left",
                row_title_gp=gpar(fontsize=15, fontface="bold"),
                show_row_names=TRUE,
                column_title="",
                column_title_side="top",
                column_title_gp=gpar(fontsize=15, fontface="bold"),
                column_title_rot=0,
                show_column_names=TRUE,
                clustering_distance_columns=function(x) as.dist(1-cor(t(x))),
                clustering_method_columns="ward.D2",
                clustering_distance_rows="euclidean",
                clustering_method_rows="ward.D2",
                row_dend_width=unit(30,"mm"),
                column_dend_height=unit(30,"mm"))

draw(hmap, heatmap_legend_side="left")
