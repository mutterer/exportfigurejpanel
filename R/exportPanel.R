#' Insert \%in\%.
#'
#' Call this function as an addin to insert \code{ \%in\% } at the cursor position.
#'
#' @export
exportPanel <- function() {
  rstudioapi::callFun("savePlotAsImage","/Users/jmutterer/Desktop/test.png", "png", 640, 480)
}
