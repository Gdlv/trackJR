#' trackJR
#'@description Tracking a video of tiny insect to get frame, position X and position Y.
#' @param pathDirAndFile Path of the directory and the video file name.is a Character string; e.g. "C:myPC/video.mp4".
#'
#' @return (data.frame) It return the tracked video with 3 column, the frame with x and y position. Be careful with X and Y position in the video, frames could be had (0,0) origin position at top-left of the plot.
#' @export
#'
#' @examples
#'mypathDirandFile<-"C:/Users/test/vid.mp4"
#'trackJR(mypathDirandFile)
#'
trackJR<- function (pathDirAndFile){
  VFile<-pathDirAndFile
  pathDirTemp<-paste(tempdir(),"/trackJRtemp/",sep="")

    if(!file.exists(pathDirTemp)) {  # If the folder does not exist, create a new one
      dir.create(pathDirTemp,F)
    } else {   # If it existed, delete and replace with a new one
      unlink(pathDirTemp, recursive = TRUE)
      dir.create(pathDirTemp,F)
    }

    system(paste("ffmpeg -i ",VFile," ",pathDirTemp,"%d.png",sep=""))
    a<-list()
    a[[1]]<-JuliaCall::julia_call("trackingR", pathDirTemp)
    a[[1]]$img<-magick::image_read(paste(pathDirTemp,"1.png",sep=""))
    return(a)
}

