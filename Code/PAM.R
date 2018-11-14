source("http://bioconductor.org/biocLite.R")

biocLite("ConsensusClusterPlus")

library(ConsensusClusterPlus)
results = ConsensusClusterPlus(mad_gset, maxK=3, reps=1000, pItem=0.98, pFeature=1, distance="pearson", seed=5, clusterAlg="hc")
icl = calcICL(results)  
icl[["clusterConsensus"]]
icl[["itemConsensus"]][1:5,]

sum(results[[3]]$consensusClass==1)/90
sum(results[[3]]$consensusClass==2)/90
sum(results[[3]]$consensusClass==3)/90

labels = results[[3]]$consensusClass  # class results for 3 clusters






# PAM Classifier with consensus hierarchical clustering results

# PAM

#install package from zip file


library(pamr)

# For Interactive analysis, use:
#pamr.menu(mad_gset)


#Non-interactive analysis

## Train the classifier
x = mad_gset
y = labels

my_mad_gset = list(x=x, y = y, geneids=paste("g",as.character(1:nrow(x)),sep=""))

gset.train <- pamr.train(my_mad_gset)

#Results of gset.train

gset.train



## Cross-validate the classifier
# pamr carries out cross-validation for the  classifier.

gset.train.cv<- pamr.cv(gset.train, my_mad_gset, nfold = 10)

#View cross-validation results

gset.train.cv

# Plotting the cross-validated error curves
jpeg('cv_errors.jpg')
pamr.plotcv(gset.train.cv)
dev.off()


#List the most significant genes
sig_genes = pamr.listgenes(gset.train,  my_mad_gset, threshold=4.625, genenames = F) #164 significant genes

head(sig_genes)


#Predicted classes using pamr classifier

pamclasses = gset.train$yhat

pamclasses = pamclasses[,"4.625"]  #for particular threshold value

head(pamclasses)

gset.train$yhat$`4.625` #predicted classes using pam with threshold set as 4.625

gene_names = attr(y, "names")

my_y_hat = setNames(gset.train$yhat$`4.625`, gene_names) #Predicted cluster assignments by PAM


pamr.confusion(gset.train, threshold = 4.625, extra = T)


#Producing a display of the significant genes

pdf("sig_genes.pdf")
par(mar = rep(2,4))
pamr.geneplot(gset.train, my_mad_gset, threshold = 4.625)
dev.off()


#Predict clusters for 'unseen' data.
#'unseen' here is mad_gset

pamr_predictions = pamr.predict(gset.train, mad_gset, threshold = 4.625, type = c("class"))

#Transforming into desirable form to be used in the AdjustedRand function
pamr_predictions = setNames(pamr_predictions, gene_names) 




