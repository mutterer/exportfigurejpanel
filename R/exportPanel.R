#' Insert \%in\%.
#'
#' Call this function as an addin to insert \code{ \%in\% } at the cursor position.
#'
#' @export
exportPanel <- function() {
  # rstudioapi::callFun("savePlotAsImage","/Users/jmutterer/Desktop/test.png", "png", 640, 480)
  if (grepl("apple", Sys.getenv("R_PLATFORM"))) {
  f <-
    paste(Sys.getenv("HOME"),
          "/Library/Preferences/IJ_Prefs.txt",
          sep = "")
} else {
  f <-
    paste(Sys.getenv("HOME"),
          ".imagej",
          "IJ_Prefs.txt",
          sep = .Platform$file.sep)
}

if (file.exists (f)) {
  ijPrefs <-
    read.table(
      f,
      header = FALSE,
      sep = "=",
      col.names = c("Key", "Value")
    )
  panelTempDir <-
    paste("", with(ijPrefs, Value[Key == ".figurej.tempDir"]), sep = "")
  panelFilename <-
    paste("", with(ijPrefs, Value[Key == ".figurej.panelFilename"]), sep =
            "")
  panelWidth <-
    paste("", with(ijPrefs, Value[Key == ".figurej.panelWidth"]), sep = "")
  panelHeight <-
    paste("", with(ijPrefs, Value[Key == ".figurej.panelHeight"]), sep = "")
}
if ((panelTempDir != "") &&
    (panelFilename != "") && (panelWidth != "") && (panelHeight != "")) {
  if (nchar(f) > 0) {
    print (paste (panelTempDir, panelFilename, panelWidth, panelHeight))
    rstudioapi::callFun(
      "savePlotAsImage",
      paste(panelTempDir, panelFilename, sep = ""),
      "tif",
      as.numeric(panelWidth),
      as.numeric(panelHeight)
    )
    
  }
} 
}
