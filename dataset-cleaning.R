library(tidyverse)
properties_scraped <- read.csv("properties_scraped.csv")
coc <- read.csv("rental-property-certificate-of-compliance.csv", sep=";")

# join properties_scraped to coc
properties <- left_join(properties_scraped, coc, by="TaxParcelId")

# clean up dollar columns, converting from character to numeric
properties$PropertyValue <- as.numeric(gsub('\\$|,', '', properties$PropertyValue))
properties$PropertyTaxes <- as.numeric(gsub('\\$|,', '', properties$PropertyTaxes))

# split geopoint column to lat and long numeric cols
properties <- properties %>% separate(geopoint, into=c("lat", "long"), sep=",")

# drop unnecessary columns
properties <- properties %>% select(!c(Address, Span, UniqueId, UnitNumber, GISPIN, UpdateDate, LastMhInDate))

# drop commas and periods from owner names to eliminate discrepancies
properties$Owner <- gsub('\\.|,', '', properties$Owner)

# write out to new csv
write.csv(properties, "properties_goodgeo.csv", row.names=FALSE)

# top 10 largest landlords and the total value of their properties
properties %>%
  group_by(Owner) %>%
  summarize(
    NumberOfProperties = n(),
    TotalValue = sum(PropertyValue)
  ) %>% 
  arrange(desc(NumberOfProperties)) %>% 
  top_n(10, NumberOfProperties)
