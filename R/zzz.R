.onAttach <- function(libname, pkgname) {

  packageStartupMessage('                         ------------------------------------- \t
                           visit JuliaCall for troubleshoting or https://github.com/Gdlv/trackJR/
                           --------------------------------------\t
                           ')
  packageStartupMessage('Remember using: options(JULIA_HOME ="C:/path_to/Julia 1.x.x/bin")')
  packageStartupMessage('Remember using: dyn.load("C:/path_to/Julia 1.x.x/bin/thepackagenotfound.dll")')
  packageStartupMessage('-------------------------------------')
  packageStartupMessage('Start Julia in R using "firstJulia()"')
  
}
