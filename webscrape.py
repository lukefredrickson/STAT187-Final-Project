import requests
from bs4 import BeautifulSoup
import csv

parcelIdId = "ctl00_PageMainContent_OwnersTaxesTables_fvDetails_DetailsParcelId"
addressId = "ctl00_PageMainContent_OwnersTaxesTables_fvDetails_DetailsLocation"
ownersId = "ctl00_PageMainContent_OwnersTaxesTables_fvDetails_lOwners"
spanId = "ctl00_PageMainContent_OwnersTaxesTables_fvDetails_Label2"
valueId = "ctl00_PageMainContent_OwnersTaxesTables_fvDetails_Label6"
taxesId = "ctl00_PageMainContent_OwnersTaxesTables_fvDetails_Label13"

rentalInfoTableId = "ctl00_PageMainContent_RentalInformation_fvRentalInfo"

dataIds = {
    "TaxParcelId" : parcelIdId, 
    "Address" : addressId,
    "SPAN Number" : spanId,
    "PropertyValue" : valueId,
    "PropertyTaxes" : taxesId
}

with open('properties_scraped.csv', mode='w') as csv_file:
    fieldnames = ['TaxParcelId', 'Address', 'SPAN Number', 'PropertyValue', 'PropertyTaxes', 'Owner']
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

    writer.writeheader()

    startId = 1
    endId = 10986
    for propertyId in range(startId, endId+1):
        print('Parsing id #{id}'.format(id=propertyId))
        req = requests.get('https://property.burlingtonvt.gov/Details/?id={id}'.format(id=propertyId))
        soup = BeautifulSoup(req.text, 'html.parser')
        isRental = len(soup.find(id=rentalInfoTableId).contents[1].contents[1].contents) != 0
        if (isRental):
            row = {}
            for key in dataIds:
                row[key] = (soup.find(id=dataIds[key]).text)
                print(key, ":  ", soup.find(id=dataIds[key]).text)
            row["Owner"] = (soup.find(id=ownersId).next_element.next_element.contents[1].text)
            print("Owner: ", soup.find(id=ownersId).next_element.next_element.contents[1].text)

            writer.writerow(row)






