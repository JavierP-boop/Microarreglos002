


BiocManager::install("affy")

BiocManager::install("mouse4302cdf")

BiocManager::install("vsn")


setwd("A Clases de 6to/Secuencias/mir155/")

getwd()

list.files()

# con este se lee el archivo

pd = read.table("pdata.txt", header=TRUE, as.is=TRUE)
pd

# Ahora ya podemos leer los datos contenidos en los archivos CEL
affyData = ReadAffy(filenames=pd$filename)

# Podemos agregar a este objecto la información que guardamos en pd
pData(affyData) = pd

# También podemos especificar un nombre corto que nos facilite identificar cada muestra
sampleNames(affyData) = pd$name


affyData


# Grafica boxplot y histograma

boxplot(affyData, col=rainbow(6))

hist(affyData, col=rainbow(6))


# previsualizar una imagen
image(affyData[,1])

# heatmap

heatmap(cor(exprs(affyData)), symm=T)


# Dendograma de clusters
# se realizan bootstraps??

corClust = pvclust(exprs(affyData), nboot=1, method.dist="correlation")
plot(corClust)


# PCA 


pca = princomp(exprs(affyData))

plot(pca$loadings, main="Principal Component Analysis", col=rainbow(6),  
     pch=19, cex=2)

# Con este se le pone nombre

text(pca$loadings, colnames(exprs(affyData)), pos=3, cex=0.8)


# Normalizar ///////////////////////////////

# Con este codigo se normaliza usando la funcion RMA (Robust Microarray Analisis)

eset = rma(affyData)


# Este da listados de metodos para normalizar

normalize.AffyBatch.methods()


par(mfrow=c(1,2))


boxplot(affyData, col=rainbow(6))
boxplot(data.frame(exprs(eset)), col= rainbow(6))




par(mfrow=c(1,2))

corClust = pvclust(exprs(affyData), nboot=1, method.dist="correlation")
plot(corClust)

corClustafter = pvclust(exprs(eset), nboot=1, method.dist="correlation")
plot(corClustafter, main = "Agrupamiento de muestras despues de normalizar")


meanSdPlot(exprs(eset))






























































