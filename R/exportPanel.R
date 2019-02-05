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
    notMac<-FALSE
  } else {
    # will make it work on Win10 for now. better method needed
    f <-
      paste(Sys.getenv("USERPROFILE"),
            ".imagej",
            "IJ_Prefs.txt",
            sep = .Platform$file.sep)
    notMac<-TRUE
  }
  print (paste("prefs file: ",f))
  
  if (file.exists (f)) {
    ijPrefs <-
      read.table(
        f,
        header = FALSE,
        sep = "=",
        fill= T,
        col.names = c("Key", "Value")
      )
    print ("done reading prefs file")
    panelTempDir <-
      paste("", with(ijPrefs, Value[Key == ".figurej.tempDir"]), sep = "")
    panelFilename <-
      paste("", with(ijPrefs, Value[Key == ".figurej.panelFilename"]), sep =
              "")
    panelWidth <-
      paste("", with(ijPrefs, Value[Key == ".figurej.panelWidth"]), sep = "")
    panelHeight <-
      paste("", with(ijPrefs, Value[Key == ".figurej.panelHeight"]), sep = "")
    print (paste("temp dir:",panelTempDir))
    print (paste("fname:",panelFilename))
    print (paste("width:",panelWidth))
    print (paste("height:",panelHeight))
  }
  
  if (notMac){
    print("clean dir path")
    panelTempDir<-gsub("\\\\\\\\","/",panelTempDir)
    panelTempDir<-gsub("\\\\","",panelTempDir)
  }
  # print (file.exists(file.path(panelTempDir)))
  ### make sure temp dir exists, or create it
  if (file.exists(file.path(panelTempDir))) {
    print ("temp dir does exists")
  } else {
    print ("no temp dir, creating it")
    
    dir.create(panelTempDir)
  }
  
  if ((panelTempDir != "") &&
      (panelFilename != "") && (panelWidth != "") && (panelHeight != "")) {
    if (nchar(f) > 0) {
      context <- rstudioapi::getSourceEditorContext()
      code <- context$contents
      cat("code")
      sink(file=file.path(paste(panelTempDir,paste(strsplit(panelFilename,".tif"),".R",sep=""),sep=""),fsep=.Platform$file.sep),append=FALSE)
      cat("# Code for generating ")
      cat(panelFilename)
      cat(" figure panel\n\n")
      cat(code)
      cat("\n # end of code\n")
      sink(NULL)
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
# explicit call for debugging before updating github
# exportPanel()
