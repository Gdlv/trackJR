# trackJR
Using Julia language and R for tracking tiny insects: an analysis of microhymenoptera wasps and olfactometers responses.

explain how its work and a simple tutorial remember to install Julia and ffmpeg also the useful JuliaCall package for troubleshouting

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/JuliaCall)](https://cran.r-project.org/package=JuliaCall)

## Troubleshooting and Ways to Get Help

### Julia is not found

Make sure the `Julia` installation is correct.
`JuliaCall` can find `Julia` on PATH,
and there are three ways for `JuliaCall` to find `Julia` not on PATH.

- Use `julia_setup(JULIA_HOME = "the folder that contains julia binary")`
- Use `options(JULIA_HOME = "the folder that contains julia binary")`
- Set `JULIA_HOME` in command line environment.

### libstdc++.so.6: version `GLIBCXX_3.4.xx' not found
Such problems are usually on Linux machines.
The cause for the problem is that R cannot find the libstdc++ version needed by `Julia`.
To deal with the problem, users can export "TheFolderContainsJulia/lib/julia" to R_LD_LIBRARY_PATH.

A problem where Win could not find *.dll file when its exist in your PC:
libdSFMT.dll
dyn.load("the folder that contains julia binary/bin/libdSFMT.dll")
