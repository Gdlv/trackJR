#' trackJR_refpoint
#' @description Funtcion to generate reference points for analyze tracking in batch mode.
#' @param listBatch The `list` object for generate referent point for each video.
#'
#' @return The function add an object called "refpoint" for each video in the `list`.
#' @export
#'
#' @examples
#' mypathDir<-"C:/Users/test" # write the string without last bar "/"
#' trackdata<-trackJR_Batch(mypathDir)
#' trackJR_refpoint(trackdata)

trackJR_refpoint<-function(listBatch){
  for(i in 1:length(listBatch)){
    graphicJR<-listBatch[[i]]$graf
    name<-paste("refpoint",i,sep="")
    trackJR_pref(graphicJR,name)
  }
}
