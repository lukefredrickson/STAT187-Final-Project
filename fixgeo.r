library(tidyverse)

bad_geo <- read.csv("properties_badgeo.csv")
good_geo <- read.csv("properties_goodgeo.csv")

bad_geo <- bad_geo %>% select(-c(lat, long))

good_geo <- good_geo %>% select(AmandaPropertyRSN, lat, long)

good_geo <- good_geo %>% filter(!is.na(AmandaPropertyRSN))
bad_geo <- bad_geo %>% filter(!is.na(AmandaPropertyRSN))

good_geo %>%  group_by(AmandaPropertyRSN) %>% filter(n()>1)
bad_geo %>%  group_by(AmandaPropertyRSN) %>% filter(n()>1)

properties <- left_join(bad_geo, good_geo, by="AmandaPropertyRSN")

# write out to new csv
write.csv(properties, "properties.csv", row.names=FALSE)
