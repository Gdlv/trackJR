% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trackJR_refpoint.R
\name{trackJR_refpoint}
\alias{trackJR_refpoint}
\title{trackJR_refpoint}
\usage{
trackJR_refpoint(listBatch)
}
\arguments{
\item{listBatch}{The `list` object for generate referent point for each video.}
}
\value{
The function add an object called "refpoint" for each video in the `list`.
}
\description{
Funtcion to generate reference points for analyze tracking in batch mode.
}
\examples{
mypathDir<-"C:/Users/test" # write the string without last bar "/"
trackdata<-trackJR_Batch(mypathDir)
trackJR_refpoint(trackdata)
}
