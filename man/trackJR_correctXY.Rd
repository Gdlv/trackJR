% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trackJR_correctXY.R
\name{trackJR_correctXY}
\alias{trackJR_correctXY}
\title{trackJR_correctXY}
\usage{
trackJR_correctXY(data_List, Refpoint)
}
\arguments{
\item{data_List}{The `list` object to be corrected by the reference points.}

\item{Refpoint}{the `refpoint` object of the list to be used for corrections.}
}
\value{
the `list`object where the `dataTrackJR` was corrected.
}
\description{
This function is useful to correct the `dataTrackJR` object of each video with a reference point.
}
\examples{
BatchList[[10]]<-trackJR_correctXY(BatchList[[10]],Refpoint = BatchList[[1]]$refpoint)
}
