# Heatmap from https://flowingdata.com/2010/01/21/how-to-make-a-heatmap-a-quick-and-easy-solution/

nba <- read.csv("http://datasets.flowingdata.com/ppg2008.csv", sep=",")

nba <- read.csv("~/Documents/ppg2008.csv", sep = ";")

#nba <- nba[order(nba$Tilstand.1),]

row.names(nba) <- nba$Name
nba <- nba[,2:20]
nba_matrix <- data.matrix(nba)

nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = cm.colors(256), scale="column", margins=c(5,10))

nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = heat.colors(256), scale="column", margins=c(5,10))

# Traffic light, red, orange, green
nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = c("#cc3232", "#e7b416", "#2dc937"), scale="column", margins=c(5,10))
# Traffic light, red, green, orange
nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = c("#cc3232", "#2dc937", "#e7b416"), scale="column", margins=c(5,10))


mypalette<-RColorBrewer::brewer.pal(3,"Blues")

nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = mypalette, scale="column", margins=c(5,10))


# TBA, using ggplot2
# https://learnr.wordpress.com/2010/01/26/ggplot2-quick-heatmap-plotting/
