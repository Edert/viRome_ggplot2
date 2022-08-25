position.barplot <- function(vdf=NULL, minlen=1, maxlen=37, reflen=10000, main="", col="green", axes=c(0,0)) {
  
  # limit the input to only contain reads
  # of size between minlen and maxlen
  vdf <- vdf[vdf$cliplen>=minlen&vdf$cliplen<=maxlen,]
  
  # get the reference name and size range as strings
  refname = vdf$rname[1]
  maps <- paste(minlen, "-", maxlen, sep="")
  
  
  # get counts of reads at each position for 
  # negative strand
  npos <- .count.reads.by.position(vdf, "-")
  
  # get counts of reads at each position for 
  # positive strand
  ppos <- .count.reads.by.position(vdf, "+")
  
  # both of the above may "miss" positions out
  # due to zero counts so we create a dummy
  # data.frame with all positions in it
  # and outer-join each of npos and ppos to it
  # filling in resulting NS's with 0 counts
  lgths <- data.frame(position=1:reflen)
  
  lpos <- merge(lgths, ppos, all.x=TRUE, sort=TRUE)
  lneg <- merge(lgths, npos, all.x=TRUE, sort=TRUE)
  
  lpos[is.na(lpos)] <- 0
  lneg[is.na(lneg)] <- 0
  
  # sort each of the new merged data.frames by position
  lpos <- lpos[order(lpos$position),]
  lneg <- lneg[order(lneg$position),]
  
  # calculate the range to be plotted
  mx <- max(c(lpos[,2],lneg[,2]))
  rng <- c(-1*mx,mx)
  
  if(axes[1] == 0 & axes[2] ==0){ #if not set do it automatically
    miny <- -(mx+1)
    maxy <- mx+1
  }else{
    miny <- axes[2]
    maxy <- axes[1]
  }
  
  #ggplot2
  p1 <- ggplot() +geom_bar(data = lneg, aes(x=position, y=0-count),stat = "identity", fill=col,width=1) 
  p1 <- p1 +geom_bar(data = lpos, aes(x=position, y=count),stat = "identity", fill=col,width=1)
  p1 <- p1 +theme_classic() +ggtitle(main) +ylim(c(miny,maxy)) 
  p1 <- p1 +theme(axis.title.y=element_blank(),axis.title.x=element_blank(),axis.text = element_text(size = 10,colour = "black"),plot.title = element_text(face="bold", size=16,hjust = 0.5),plot.margin = margin(10, 20, 10, 10)) 
  p1

}


.count.reads.by.position <- function(vdf=NULL, str=NULL) {

	# subset by strand
	svdf <- vdf[vdf$strand==str,]

	if (nrow(svdf) > 0) {
		# if there are any mappings on this strand
		# count the number of reads by position
		bn <- by(svdf$qname, svdf$pos, length)
		
		# create data.frame and return it
		ret <- data.frame(position=as.integer(names(bn)), count=as.vector(bn))
		return(ret)

	} else {
		# otherwise just return a dummy data.frame
		return(data.frame(position=1,poscount=0))
	}

}
