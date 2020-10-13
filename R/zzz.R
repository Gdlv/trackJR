.onAttach <- function(libname, pkgname) {
  packageStartupMessage('Remember using: options(JULIA_HOME ="C:/path_to/Julia 1.x.x/bin")')
  
  packageStartupMessage('------------------------------------------------------------------------------ \t
                           visit JuliaCall for troubleshoting or https://github.com/Gdlv/trackJR/
                           ------------------------------------------------------------------------------ \t
                           Start Julia in R using "firstJulia()"')
}
