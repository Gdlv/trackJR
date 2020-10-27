#' trackJR_ggplot
#'@description Generate a ggplot class object for the tracking a video. As a ggplot object you can add more layers.
#' @param pathDirtoVid Character string for path to the video.
#' @param dataTrackJR The R object of your workspace to plot the track.
#' @param frameIMG The frame you want to plot.
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' #'mypathDirandFile<-"C:/Users/test/vid.mp4"
#'dataT<-trackJR(mypathDirandFile)
#'graf<-trackJR_ggplot(mypathDirandFile,dataT)

trackJR_ggplot<-function (pathDirtoVid,dataTrackJR,frameIMG=1){
  mypathDirandFile=pathDirtoVid
  fr=frameIMG

    filetemp<-paste(tempfile(),fr,"frame.jpg",sep="")

    if(!file.exists(filetemp)) {  # If the file does not exist, create a new one
      file.create(filetemp,F)
    } else {   # If it existed, delete and replace with a new one
      unlink(filetemp, recursive = TRUE)
      file.create(filetemp,F)
    }
    system (paste("ffmpeg -y -i ",mypathDirandFile," -frames:v ", fr," -f image2 ",filetemp,sep=""))

  aimj<-jpeg::readJPEG(filetemp,T)
  library(ggplot2)
  library(ggpubr)
  dimx=dim(aimj)[2]
  dimy=-dim(aimj)[1]
  dataTrackJR<-dataTrackJR[order(dataTrackJR$fr),]
  p<-ggplot(data=dataTrackJR,aes(x=x,y=y))+ background_image(aimj)+geom_point()+
    scale_x_continuous(limits=c(0,dimx),expand = c(0,0))+
    scale_y_continuous(limits=c(dimy,0),expand = c(0,0))
  return(p)
}
