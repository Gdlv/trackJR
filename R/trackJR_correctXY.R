#' trackJR_correctXY
#' @description This function is useful to correct the `dataTrackJR` object of each video with a reference point.
#' @param data_List The `list` object to be corrected by the reference points.
#' @param Refpoint the `refpoint` object of the list to be used for corrections.
#'
#' @return the `list`object where the `dataTrackJR` was corrected.
#' @export
#'
#' @examples
#' BatchList[[10]]<-trackJR_correctXY(BatchList[[10]],Refpoint = BatchList[[1]]$refpoint)

trackJR_correctXY<-function (data_List,Refpoint){
  xcorrect<-Refpoint$x
  ycorrect<-Refpoint$y

  x<-data_List$refpoint$x
  y<-data_List$refpoint$y

  refx<-c(x-xcorrect)
  refy<-c(y-ycorrect)

  data_List$dataTrackJR$x<-data_List$dataTrackJR$x-refx
  data_List$dataTrackJR$y<-data_List$dataTrackJR$y-refy

  return(data_List)
}
