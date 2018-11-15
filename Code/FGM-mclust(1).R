
#Model-based clustering

#Using BIC to determine optimality

BIC = mclustBIC(t(mad_gset),G = 1:5)

#Best BIC value
summary(BIC)

jpeg("BIC_plot.jpg")
plot(BIC)
dev.off()


#Fitting the optimal model

FGM_model = Mclust(t(mad_gset), G = 1:5, x = BIC)

summary(FGM_model)

jpeg("FGM_model.jpg")
par(mar = rep(2,4))
plot(FGM_model, what = 'classification')
dev.off()


#Model - based Classification

FGM_Classi = predict(FGM_model, newdata = t(mad_gset))

FGM_Classi




