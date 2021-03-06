#' trackJR_pbox
#' @description A function to select points inside a box.
#' @param data_trackJR The data frame with column "x" and "y" generated by the trackJR function.
#' @param data_box The box coordinates generated by the [trackJR_box] to determine the point inside the box.
#'
#' @return a subset of the [data_trackJR] inside the box.
#' @export
#'
#' @examples
#' #' #'mypathDirandFile<-"C:/Users/test/vid.mp4"
#' dataT<-trackJR(mypathDirandFile)
#' graf<-trackJR_ggplot(mypathDirandFile,dataT)
#' trackJR_box(graf,"box1")
#' estimuli<-trackJR_pbox(dataT,box1)

trackJR_pbox<-function(data_trackJR,data_box){
  p<-data_trackJR[dplyr::between(data_trackJR$x,data_box$xmin,data_box$xmax)&
                  dplyr::between(data_trackJR$y,data_box$ymin,data_box$ymax),]
  return(p)
}

