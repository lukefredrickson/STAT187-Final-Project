library(tidyverse)

bad_geo <- read.csv("properties_badgeo.csv")
good_geo <- read.csv("properties_new.csv")

bad_geo <- bad_geo %>% select(-c(lat, long))
good_geo <- good_geo %>% select(TaxParcelId, lat, long)

properties <- left_join(bad_geo, good_geo, by="TaxParcelId")

# write out to new csv
write.csv(properties, "properties.csv", row.names=FALSE)