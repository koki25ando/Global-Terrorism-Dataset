## Global Script

# Package loading
library(tidyverse)
library(shiny)
library(DT)
library(data.table)
library(bit64)
library(maps)
library(plotly)
library(shinyjs)


# Data setting
gtd <- fread("https://s3-ap-southeast-2.amazonaws.com/globalterrorismdataset/global_terrorism_dataset.csv", data.table = FALSE)
gtd$iyear <- as.numeric(gtd$iyear)
gtd$imonth <- as.numeric(gtd$imonth)
gtd$iday <- as.numeric(gtd$iday)
gtd$date <- as.Date(gtd$date)