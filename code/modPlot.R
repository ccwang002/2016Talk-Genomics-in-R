# For installation, run
#   install.packages("devtools")
#   devtools::install_github("genomicsclass/ph525x")
#   biocLite("Gviz")  # Gviz for plotting genomic data
library(ph525x)  # Provides some

png(
    file = "../slides/pics/modPlot_MAPK1.png",
    bg="transparent",
    width = 1024 * 2, height = 600 * 2, units = "px",
    res=300
)
modPlot("MAPK1", collapse=FALSE, useGeneSym=FALSE)
dev.off()
