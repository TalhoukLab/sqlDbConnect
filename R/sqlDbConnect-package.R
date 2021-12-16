#' @keywords internal
#' @import methods
"_PACKAGE"
NULL

.onAttach <- function(libname, pkgname) {
	library("DBI") # make sure required library is loaded
	
}