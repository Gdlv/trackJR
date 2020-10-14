# trackJR
Using Julia language and R for tracking tiny insects: an analysis of microhymenoptera wasps and olfactometers responses. This package allow working and tracking tiny insect responses and is inspired in [pathtrackr](https://aharmer.github.io/pathtrackr/) and solution to work with tiny insect. Also, as use [Julia] (https://julialang.org), it allow "meeting the velocity" and could be very helpful for batch processing.

We develop this package for [R](https://cran.r-project.org/) because (we love R! and) most analyzes in ecological studies are in R enviroment. R is a more "mature" language than Julia. Although as is expect for other lenguages, such as [Phyton], Julia would be the place were newly ecological advances place.


explain how its work and a simple tutorial remember to install Julia and ffmpeg also the useful JuliaCall package for troubleshouting

(https://cran.r-project.org/package=JuliaCall)

#### Pre-installing *trackJR*
1) Install [julia]
2) *trackJR* package require [FFmpeg](https://ffmpeg.org) to be installed on your machine, which R calls via the *system()* function as well as [pathtrackr](https://aharmer.github.io/pathtrackr/). These links provide instructions for download and allow to use it: [Install FFmpeg on Windows](http://www.wikihow.com/Install-FFmpeg-on-Windows)

#### installing *trackJR*

To install *trackJR* directly within R using the *install\_github()* function from the [devtools](https://www.rstudio.com/products/rpackages/devtools/) package:

``` r
devtools::install_github("Gdlv/trackJR")
```

## Troubleshooting and Ways to Get Help

### Julia is not found

Make sure the `Julia` installation is correct.
`JuliaCall` can find `Julia` on PATH,
and there are three ways for `JuliaCall` to find `Julia` not on PATH.

- Use `julia_setup(JULIA_HOME = "the folder that contains julia binary")`
- Use `options(JULIA_HOME = "the folder that contains julia binary")`
- Set `JULIA_HOME` in command line environment.

### Error: "could not load libdSFMT.dll"
The cause for the problem is that R cannot find the libdSFMT.dll library needed by `Julia`.
add a line in your script:
`dyn.load("the folder that contains julia binary/bin/libdSFMT.dll")`
