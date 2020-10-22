#' trackJR_Batch
#'@description Tracking a video of tiny insect to get frame, position X and position Y.In a batch mode.
#' @param pathDir Path of the directory where videos saved.is a Character string; e.g. "C:myPC/videos". write the string without last bar "/"
#' @param rframes Rate of frame which you want to extract or transform the video. Default is 20.
#' @param timestop Video time duration for tracking. Default is 5 minutes. Bring as a character string "00:05:00".

#' @return (list) It return the tracked directory in a list with all the videos with 3 column, the frame with x and y position. Be careful with X and Y position in the video, frames could be had (0,0) origin position at top-left of the plot.
#' @export
#'
#' @examples
#'mypathDir<-"C:/Users/test" # write the string without last bar "/"
#'trackJR_Batch(mypathDir)
#'
trackJR_Batch<- function (pathDir,rframes=20,timestop="00:05:00"){
  listF<-as.list(list.files(pathDir))
  names(listF)=listF
  for(i in 1:length(listF)){
    pathDirTemp<-paste(tempdir(),"/",names(listF)[i],"/",sep="")

    if(!file.exists(pathDirTemp)) {  # If the folder does not exist, create a new one
      dir.create(pathDirTemp,F)
    } else {   # If it existed, delete and replace with a new one
      unlink(pathDirTemp, recursive = TRUE)
      dir.create(pathDirTemp,F)
    }

    system(paste("ffmpeg -i ",pathDir,"/",names(listF)[i]," -r ",rframes," -t ",timestop," ",pathDirTemp,"%d.png",sep=""))
    listF[[i]]<-JuliaCall::julia_call("trackingR", pathDirTemp)
    }
  return(listF)
}
