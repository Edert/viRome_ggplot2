\name{position.barplot}
\alias{position.barplot}
\title{
Plot a barplot of alignments across a genome
}
\description{
For a given reference, plot the counts of alignments of reads of a given size-range along the positive and negative strands
}
\usage{
position.barplot(vdf = NULL, minlen = 1, maxlen = 37, reflen = 10000, main = "", col="red", axes=c(0,0))
}
\arguments{
  \item{vdf}{
A data.frame as output from \code{\link{read.bam}} and \code{\link{clip.bam}}
}
  \item{minlen}{
The shortest read/alignment to include.  The beginning of the range of read sizes you wish to count.
}
  \item{maxlen}{
The longest read/alignment to include.  The maxlen of the range of read sizes you wish to count.
}
  \item{reflen}{
The length of the reference.  You should probably know this, if you performed the alignment; otherwise it will be in the header of the SAM/BAM file
}
  \item{main}{
The sample name associated with the data - to be used in the title of the resulting graph
}
  \item{col}{
The colour of the bars.  Default: "green"
}
   \item{axes}{
Min and max of the Y-axes, if both = 0 use default ggplot min and max.  Default: "(0,0)"
}
}
\details{
This function calculates counts of the occurrence of reads/alignments of a given size-range across a genome.  The x-axis is the genome position, the y-axis is the count, and bars point upwards for the positive strand, and downwards for the negative strand.

Plots a barplot to the current device. 

The value used for the position is the most 5' minlen of the alignment relative to the positive strand of the reference.
}
\value{
Plots a barplot to the current device and also returns a data.frame of the results
  \item{position }{The position in the reference}
  \item{poscount }{Count on the positive strand}
  \item{negcount }{Count on the negative strand}

}
\references{
}
\author{
Mick Watson, modified for ggplot by Thomas Eder
}
\note{
}
\seealso{
\code{\link{barplot.bam}}, \code{\link{clip.bam}}
}
\examples{

\dontrun{infile <- system.file("data/SRR389184_vs_SINV_sorted.bam", package="viRome")}
\dontrun{bam <- read.bam(bamfile=infile, chr="SINV", minlen=1, maxlen=11703, removeN=TRUE)}
\dontrun{bamc <- clip.bam(bam)}

\dontrun{bi <- position.barplot(vdf=bamc, minlen=21, maxlen=22, reflen=11703, main="SRR389184")}
\dontrun{bi}
}
\keyword{ aplot }
\keyword{ manip }

