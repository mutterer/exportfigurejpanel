RStudio FigureJ Addin
=====================

RStudio FigureJ addin allows to export a copy of the current Rstudio plot matching the exposed FigureJ panel with expected dimensions.

Installation
------------
* Ensure you have RStudio > 1.1.x and devtools and rstudioapi installed:
```
install.packages("devtools")
install.packages("rstudioapi")
```
  
* Install the Addin from source on GitHub:
```
devtools::install_github("mutterer/exportfigurejpanel", type = "source")
```
