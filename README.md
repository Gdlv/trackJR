# trackJR

*Using Julia language and R for tracking tiny insects: an analysis of microhymenoptera wasps and olfactometers responses.*

This package allow working and tracking tiny insect responses and is inspired in [pathtrackr](https://aharmer.github.io/pathtrackr/) and solution to work with tiny insect. Also, as use [Julia](https://julialang.org), it allow "meeting the velocity" and could be very helpful for batch processing.

We develop this package for [R](https://cran.r-project.org/) because (we love R! and) most analyzes in ecological studies are in R enviroment. R is a more "mature" language than Julia. Although as is expect for other lenguages, such as [Phyton], Julia would be the place were newly ecological advances place.

The main functions for tracking are in `Julia` language and used in R by [JuliaCall](https://cran.r-project.org/package=JuliaCall). These function are common from images processing and based on `convolve` with a kernel filter and take the `edgeness` of an image ([MIT Course](https://computationalthinking.mit.edu/Fall20/)).

![window](figs/00000212.png)

## How to use *trackJR*

### Pre-installing *trackJR*
1) Install [julia](https://julialang.org)
2) *trackJR* package require [FFmpeg](https://ffmpeg.org) to be installed on your machine, which R calls via the *system()* function as well as [pathtrackr](https://aharmer.github.io/pathtrackr/). These links provide instructions for download and allow to use it: [Install FFmpeg on Windows](http://www.wikihow.com/Install-FFmpeg-on-Windows)

### installing *trackJR*

To install *trackJR* directly within R using the *install\_github()* function from the [devtools](https://www.rstudio.com/products/rpackages/devtools/) package:

``` r
devtools::install_github("Gdlv/trackJR")
```
### start using *trackJR*!
After installing the package you need to load *trackJR*. 

``` r
Library(trackJR)
```
As you can see in the R console, there are few points to remember. *see troubleshoting points*.
The first step to start using the package is to tell R where is Julia binary file. After that, you could just start using and load [Julia] functions by *firstJulia* function. This function initalize the conection between [Julia] and [R] and write the image proccesing functions. This step, also install packages for Julia, so it could take few minutes. 
``` r
options(JULIA_HOME = "the folder that contains julia binary")
firstJulia()
```
Now we can use the *trackJR* function. This function use just only one argument, the path to video file to track the insect. The output is a `data.frame` with three column (frame, X and Y). 
``` r
vid<-"C:/Users/video001.mp4" 
tabV<-trackJR(vid)
```
Also, if you have a dir with video files, you would use the *trackJR_Batch* function for batch processing and take the output as `list` object. This `list` have the video name with the three column (frame, X and Y). Be careful to write the path to the directory without last bar (`/`)
``` r
vidDir<-"C:/Users/the50videos" 
tabV<-trackJR_Batch(vidDir)
```


## Troubleshooting and Ways to Get Help

#### Error: Julia is not found

Make sure the `Julia` installation is correct.
`JuliaCall` can find `Julia` on PATH,
and there are three ways for `JuliaCall` to find `Julia` not on PATH.

- Use `julia_setup(JULIA_HOME = "the folder that contains julia binary")`
- Use `options(JULIA_HOME = "the folder that contains julia binary")`
- Set `JULIA_HOME` in command line environment.

#### Error: "could not load libdSFMT.dll"
The cause for the problem is that R cannot find the libdSFMT.dll library needed by `Julia`.
add a line in your script:
`dyn.load("the folder that contains julia binary/bin/libdSFMT.dll")`
