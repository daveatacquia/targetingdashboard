library(jsonlite)


data <- fromJSON("./data/example.json")

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