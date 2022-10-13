#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("At least one argument must be supplied.")
}

# pkgs check
if("data.table" %in% rownames(installed.packages()) == FALSE) { install.packages("data.table") }

# script start
library(data.table)
temp = data.frame("patient" = args[1], "sex" = args[2], "status" = 1, "lane" = 1, sample = args[1], bam = "/processing_dir/tumor.bam","bai" = "/processing_dir/tumor.bai")
data.table::fwrite(temp, "/processing_dir/samplesheet.csv")

