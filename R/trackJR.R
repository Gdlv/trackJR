#' trackJR
#'@description Tracking a video of tiny insect to get frame, position X and position Y.
#' @param pathDirAndFile Path of the directory and the video file name.is a Character string; e.g. "C:myPC/video.mp4".
#' @param rframes Rate of frame which you want to extract or transform the video. Default is 20.
#' @param timestop Video time duration for tracking. Default is 5 minutes. Bring as a character string "00:05:00".
#' @return (data.frame) It return the tracked video with 3 column, the frame with x and y position. Be careful with X and Y position in the video, frames could be had (0,0) origin position at top-left of the plot.
#' @export
#'
#' @examples
#'mypathDirandFile<-"C:/Users/test/vid.mp4"
#'trackJR(mypathDirandFile)
#'
trackJR<- function (pathDirAndFile,rframes=20, timestop="00:05:00"){
  VFile<-pathDirAndFile
  pathDirTemp<-paste(tempdir(),"/trackJRtemp/",sep="")

    if(!file.exists(pathDirTemp)) {  # If the folder does not exist, create a new one
      dir.create(pathDirTemp,F)
    } else {   # If it existed, delete and replace with a new one
      unlink(pathDirTemp, recursive = TRUE)
      dir.create(pathDirTemp,F)
    }

    system(paste("ffmpeg -i ",VFile," -r ",rframes," -ss ",timestop,pathDirTemp,"%d.png",sep=""))
    a<-JuliaCall::julia_call("trackingR", pathDirTemp)
    return(a)
}

