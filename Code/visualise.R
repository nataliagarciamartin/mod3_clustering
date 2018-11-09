library(devtools)
library(Biobase)
library(dendextend)

install.packages(c("devtools","dendextend"))
source("http://www.bioconductor.org/biocLite.R")
biocLite(c("Biobase"))

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ChromHeatMap", version = "3.8")

#http://jtleek.com/genstats/inst/doc/01_13_clustering.html

# First we log transform and remove lowly expressed genes, then calculate Euclidean distance

edata = as.data.frame(gset)
dim(edata)
meansrows <- rowMeans(edata)
summary(meansrows)
#edata = edata[rowMeans(edata) > 50,]
edata = log2(edata + 1)

# By default calculates the distance between rows
dist1 = dist(t(edata))

length(dist1) #whyyyyyy

# Look at distance matrix
colramp = colorRampPalette(c(3,"white",2))(9)
heatmap(as.matrix(dist1),col=colramp,Colv=NA,Rowv=NA)


##### https://www.bioconductor.org/packages/release/bioc/vignettes/ComplexHeatmap/inst/doc/s9.examples.html

source("http://bioconductor.org/biocLite.R")
biocLite("ComplexHeatmap")
library(ComplexHeatmap)
library(circlize)

expr = gset
mat = as.matrix(expr[, grep("cell", colnames(expr))])
base_mean = rowMeans(mat)
mat_scaled = t(apply(mat, 1, scale))

type = gsub("s\\d+_", "", colnames(mat))
ha = HeatmapAnnotation(df = data.frame(type = type))

Heatmap(mat_scaled, name = "expression", km = 5, col = colorRamp2(c(-2, 0, 2), c("green", "white", "red")),
        top_annotation = ha, top_annotation_height = unit(4, "mm"), 
        show_row_names = FALSE, show_column_names = FALSE) +
  Heatmap(base_mean, name = "base_mean", show_row_names = FALSE, width = unit(5, "mm")) +
  Heatmap(expr$length, name = "length", col = colorRamp2(c(0, 1000000), c("white", "orange")),
          heatmap_legend_param = list(at = c(0, 200000, 400000, 60000, 800000, 1000000), 
                                      labels = c("0kb", "200kb", "400kb", "600kb", "800kb", "1mb")),
          width = unit(5, "mm")) +
  Heatmap(expr$type, name = "type", width = unit(5, "mm"))
