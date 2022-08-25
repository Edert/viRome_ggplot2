\name{barplot.bam}
\alias{barplot.bam}
\title{
Draw/calculate a barplot showing the length distribution of reads aligned to the reference.
}
\description{
This function counts the occurrence of reads of a given size range mapping to the positive and negative strands of a reference sequence.  

Generally, users of viRome may be interested in how many 21-22bp (viRNA) and 24-29bp (piRNA) reads align to the reference genome, on both the positive and negative strand.  
}
\usage{
barplot.bam(vdf = NULL, minlen = 1, maxlen = 37, scol="red",axes=c(1000,-1000), main = "Sequence length distribution",  ...)
}
\arguments{
  \item{vdf}{
A \code{\link{data.frame}} as produced by \code{\link{read.bam}} and \code{\link{clip.bam}}
}
  \item{minlen}{
The minimum length of aligned read to consider
}
  \item{maxlen}{
The maximum length of aligned read to consider
}
  \item{col}{
The colour of the bars.  Defaults to "red"
}
  \item{main}{
Title for the plot
}
  \item{axes}{
Min and max of the y-axes.
}

  \item{...}{
Further parameters to pass to the \code{\link{barplot}} function
}

}
\details{
A barplot is plotted.
}
\value{
A barplot is plotted
}
\references{
}
\author{
Mick Watson, modified for ggplot by Thomas Eder
}
\note{

}
\seealso{
\code{\link{read.bam}}, \code{\link{clip.bam}} 
}
\examples{

 \dontrun{infile <- system.file("data/SRR389184_vs_SINV_sorted.bam", package="viRome")}
 \dontrun{bam <- read.bam(bamfile=infile, chr="SINV", start=1, end=11703, removeN=TRUE)}
 \dontrun{bamc <- clip.bam(bam)}

 \dontrun{bi <- barplot.bam(vdf=bamc, minlen=1, maxlen=37)}
 \dontrun{bi}

 \dontrun{bp <- barplot.bam(bamc)}
 \dontrun{bp <- barplot.bam(bamc, down=TRUE)}


 \dontrun{bp <- barplot.bam(bamc, space=c(0,0))}
 \dontrun{bp <- barplot.bam(bamc, down=TRUE, space=c(0,0))}


 \dontrun{bp <- barplot.bam(bamc, minlen=17, maxlen=36)}
}
\keyword{ aplot }
\keyword{ manip }
