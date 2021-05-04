library(tidyverse)
library("ggmap")
citation("ggmap")
library(dplyr)
library(lubridate)
library(ggplot2)
library("devtools")
library(data.table)
library(ggrepel)
library(readr)
properties <- read.csv("properties.csv")
View(rentalprop)
dim(rentalprop)
head(rentalprop)
attach(rentalprop)
devtools::install_github("dkahle/ggmap", ref = "tidyup", force=TRUE)
ggmap::register_google(key = "AIzaSyBoXvBVphUedpDsc05jtjZbH5pQGZJWQLc")

ggmap(get_googlemap(center = c(lon = -73.225, lat = 44.485),
                    zoom = 13, scale = 2, 
                    maptype ='terrain',
                    color = 'color',
                    alpha = 0.25)) +
  geom_point(aes(x = long, y = lat,  
                 color = CoCYears), data = properties, size = 0.5) + 
  theme(legend.position="bottom") +
  labs(title = "Map of Properties Owned by Biggest Landlords", x = "Longitude", y = "Latitude")



