library(jsonlite)
library(RCurl)

# grab the data
raw_data <- getURL("http://52.20.161.146:8000/reports/homepage-banner/targeting?account_name=KATBAI2&site_name=Drupal")

# Then covert from JSON into a list in R
data <- fromJSON(raw_data)

#data <- fromJSON("./data/example.json")

## Totals for Boxes
total.shown <- data$totals$shown
total.converted <- data$totals$converted
total.cr <- data$totals$conversionrate

## Plot for Segments
seg <- data$segments
segment.names <- names(seg)
df <- data.frame(segment=NULL,variation=NULL,cr=NULL)
for(i in seq_along(seg)) {
    for(j in seq_along(seg[[i]]$variations)) {
        #seg[[i]]$variations[[j]]$results$conversionrate
        variation.names <- names(seg[[i]]$variations)
        df <- rbind(df, 
                    data.frame(segment=segment.names[i], 
                               variation=variation.names[j],
                               cr=seg[[i]]$variations[[j]]$results$conversionrate))
    }
}