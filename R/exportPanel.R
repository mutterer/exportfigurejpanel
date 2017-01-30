#' Insert \%in\%.
#'
#' Call this function as an addin to insert \code{ \%in\% } at the cursor position.
#'
#' @export
exportPanel <- function() {
  rstudioapi::insertText(" %panel% ")
}
