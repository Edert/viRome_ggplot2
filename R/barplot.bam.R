
barplot.bam <- function(vdf=NULL, minlen=1, maxlen=37, col="red", axes=c(1000,-1000),main="title", ...) {

  neg <- .sum.bam.length(vdf, "-", minlen, maxlen)
  pos <- .sum.bam.length(vdf, "+", minlen, maxlen)
  bavdf <- merge(pos, neg, by="length", sort=FALSE)
  colnames(bavdf) <- c("lgth","pos","neg")
      
  miny <- axes[2]
  maxy <- axes[1]
  
  mybreaks = seq(minlen,  maxlen, by = 2)
  mylabels = seq(minlen,  maxlen, by = 2)
  
  #ggplot2
  p1 <- ggplot() +geom_bar(data = bavdf, aes(x=lgth, y=0-neg),stat = "identity", fill=col,width=1, colour="black") 
  p1 <- p1 +geom_bar(data = bavdf, aes(x=lgth, y=pos),stat = "identity", fill=col,width=1, colour="black") +geom_hline(yintercept=0) +geom_vline(xintercept=21.5, linetype='dotted', size=0.5)
  p1 <- p1 +theme_classic()  +ggtitle(main) +scale_x_continuous(labels=mylabels,breaks=mybreaks)
  p1 <- p1 +theme(axis.title.y=element_blank(),axis.title.x=element_blank(),axis.text = element_text(size = 12,colour = "black"),plot.title = element_text(face="bold", size=16,hjust = 0.5)) 
  p1 <- p1 +ylim(c(miny,maxy))
  p1

}


.sum.bam.length <- function(vdf=NULL, str=NULL, minlen=NULL, maxlen=NULL) {

	# first limit the input to the strand we are interested in
	vdf <- vdf[vdf$strand==str,]

	# count the occurrence of each length of read
	# and convert to a data.frame
	tbl <- table(vdf$cliplen, useNA="always")
	tvdf <- as.data.frame(tbl)

	# The above may not contain every number between
	# minlen and maxlen, so we create a dummy
	# data.frame that does and "outer join" it 
	# to the above result, replacing the resulting
	# NA with zero counts
	yvdf <- data.frame(Counts=minlen:maxlen)
	avdf <- merge(yvdf, tvdf, by.x="Counts", by.y="Var1", all.x=TRUE, sort=FALSE)
	avdf[is.na(avdf)] <- 0

	# give it sensible column and row names
	colnames(avdf) <- c("length","freq")
	rownames(avdf) <- avdf$length
	
	# return 
	return(avdf[order(avdf$length),])
}
